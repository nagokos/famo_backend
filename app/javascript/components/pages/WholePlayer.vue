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
          @search-player="searchPlayer"
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
          text: "全国",
          to: this.$route.path,
          disabled: true,
        },
      ]
    }
  },
  created() {
    this.getData()
  },
  methods: {
    async getData() {
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
      const response = await this.$axios.get(`/api/v1/players`)
      this.users = response.data.users
    },
    async searchPlayer(position, team) {
      const response = await this.$axios.get(`/api/v1/players`, {
        params: {
          q: {
            position: position,
            team_id: team
          }
        }
      })
      this.users = response.data.users
    },
    async getTeams() {
      const response = await this.$axios.get("/api/v1/teams")
      this.teams = response.data.teams
      const unspecified = { name: "指定なし", id: "" }
      this.teams.unshift(unspecified)
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