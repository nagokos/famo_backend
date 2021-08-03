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
    TheBreadCrumb,
    PlayerSearch,
    PlayerList
  },
  beforeRouteUpdate(to, from, next) {
    next()
    this.getLeague()
    this.getPlayers()
  },
  data() {
    return {
      loading: false,
      users: [],
      league: {},
      leagues: [],
      teams: []
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
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
    }
  },
  created() {
    this.getData()
  },
  methods: {
    async getData() {
      await this.getLeague()
      await this.getPlayers()
      await this.getLeagues()
      await this.getTeams()
      this.loading = true
    },
    async getLeagues() {
      const response = await this.$axios.get("/api/v1/leagues")
      this.leagues = response.data.leagues
    },
    async getPlayers() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/leagues/${leagueId}/users?team_id=''&position=''`)
      this.users = response.data.users
    },
    async getTeams() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/leagues/${leagueId}/teams`)
      this.teams = response.data.teams
      const unspecified = { name: "指定なし", id: 0 }
      this.teams.unshift(unspecified)
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