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
          v-bind.sync="q"
          @search-player="getPlayers"
        />
        <router-view
          :users="users"
          :teams="teams"
          :area="league"
          :q="q"
          @search-player="getPlayers"
        />
      </v-row>
    </v-container>
  </div>
</template>

<script>
import Transform from "../../packs/league-transform"
import TheBreadCrumb from "../globals/TheBreadCrumb"
import PlayerSearch from "../parts/PlayerSearch"

export default {
  components: {
    TheBreadCrumb,
    PlayerSearch,
  },
  beforeRouteUpdate(to, from, next) {
    next()
    if (to.params.league !== from.params.league) {
      this.getData()
    } else {
      this.resetSearch()
      this.getPlayers()
    }
  },
  data() {
    return {
      loading: false,
      users: [],
      league: {},
      leagues: [],
      teams: [],
      q: {
        leagueId: "",
        position: "",
        teamId: ""
      }
    }
  },
  computed: {
    isRating() {
      return this.$route.path.includes("ratings")
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
    }
  },
  created() {
    if (!!this.$route.params.search) this.q = this.$route.params.search
    this.getData()
  },
  methods: {
    resetSearch() {
      this.q.teamId = ""
      this.q.position = ""
    },
    async getData() {
      this.loading = false
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
      this.q.leagueId = leagueId
      this.isRating ? this.q.rating = true : this.q.rating = false
      const response = await this.$axios.get("/api/v1/players", {
        params: { q: this.q }
      })
      this.users = response.data.users
    },
    async getTeams() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/leagues/${leagueId}/teams`)
      this.teams = response.data.teams
      const unspecified = { name: "指定なし", id: "" }
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