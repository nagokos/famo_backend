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
          :page.sync="page"
          :total-pages="totalPages"
          :current-page="currentPage"
          :total-count="totalCount"
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
      },
      page: 1,
      totalPages: 1,
      currentPage: 1,
      totalCount: 0
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
      if (!!this.$route.query.page) this.page = +this.$route.query.page
      this.isRating ? this.q.rating = true : this.q.rating = false
      const response = await this.$axios.get("/api/v1/players", {
        params: {
          q: this.q,
          page: this.page
        }
      })
      this.totalCount = +response.headers["total-count"]
      this.currentPage = +response.headers["current-page"]
      this.totalPages = +response.headers["total-pages"]
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