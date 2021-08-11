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
          v-if="!$vuetify.breakpoint.mobile"
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
import TheBreadCrumb from "../globals/TheBreadCrumb"
import PlayerSearch from "../parts/PlayerSearch"

export default {
  components: {
    TheBreadCrumb,
    PlayerSearch,
  },
  beforeRouteUpdate(to, from, next) {
    next()
    this.getPlayers()
  },
  data() {
    return {
      loading: false,
      users: [],
      league: {},
      leagues: [],
      teams: [],
      q: {
        position: "",
        teamId: "",
        rating: false
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
      this.isRating ? this.q.rating = true : this.q.rating = false
      const response = await this.$axios.get("/api/v1/players", {
        params: { q: this.q }
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