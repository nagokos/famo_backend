<template>
  <div
    v-if="loading"
    class="league"
  >
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <v-container>
      <v-row>
        <player-search
          :league="league"
          :leagues="leagues"
          :teams="teams"
        />
        <player-list
          :users="users"
          :league="league"
        />
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Transform from "../../packs/league-transform"
import TheBreadCrumb from "../globals/TheBreadCrumb"
import PlayerSearch from "../parts/PlayerSearch"
import PlayerList from "../parts/PlayerList"

export default {
  components: {
    TheBreadCrumb
  },
  beforeRouteUpdate(to, from, next) {
    next()
    this.getLeague()
    this.getPlayers()
  },
  data() {
    return {
      menu: false,
      loading: false,
      position: "指定なし",
      players: [],
      league: {},
      leagues: [],
      positions: [
        {
          name: "指定なし"
        },
        {
          name: "GK"
        },
        {
          name: "DF"
        },
        {
          name: "MF"
        },
        {
          name: "FW"
        }
      ]
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    filterLeagues() {
      return this.leagues.filter(league => {
        return league.id !== this.league.id
      })
    },
    breadCrumbs() {
      return [
        {
          text: "TOP",
          to: "/",
          disabled: false,
        },
        {
          text: this.league.name,
          to: this.$route.path,
          disabled: false,
        },
      ]
    },
    fullName: () => {
      return(player) => {
        return `${player.lastName} ${player.firstName}`
      }
    },
    information: () => {
      return(player) => {
        return `${player.profile.team}(${player.profile.prefecture.name}) ${player.profile.position} / ${player.profile.officialNumber}`
      }
    },
  },
  created() {
    this.getData()
  },
  methods: {
    pushUserPage(user) {
      if (this.currentUser.id === user.id) {
        this.$router.push({ name: "profile" })
      } else {
        this.$router.push({
          name: "playerProfile",
          params: { league: this.$route.params.league, categoryId: user.profile.category.id, groupId: user.profile.groupId, userId: user.id }
        })
      }
    },
    async getData() {
      await this.getLeague()
      await this.getPlayers()
      await this.getLeagues()
      this.loading = true
    },
    pushLeague(league) {
      const leagueEigo = Transform.leagueNameEigo(league.name)
      this.menu = false
      this.$router.push({ name: "leaguePlayer", params: { league: leagueEigo } })
    },
    async getLeagues() {
      const response = await this.$axios.get("/api/v1/leagues")
      this.leagues = response.data.leagues
    },
    async getPlayers() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/leagues/${leagueId}/users`)
      this.players = response.data.users
      console.log(this.players);
    },
    async getLeague() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/leagues/${leagueId}`)
      this.league = response.data.league
    },
  }
}
</script>

<style scoped>
  .league {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>