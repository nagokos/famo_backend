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
          :league="category"
          :leagues="categories"
          :teams="teams"
          @search-player="searchPlayer"
        />
        <router-view
          :users="users"
          :teams="teams"
          :area="category"
          @search-player="searchPlayer"
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
    if (to.params.categoryId !== from.params.categoryId) {
      this.getData()
    } else {
      this.getPlayers()
    }
  },
  data() {
    return {
      users: [],
      category: {},
      categories: [],
      teams: [],
      loading: false
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
          text: this.category.league.name,
          to: `/${Transform.leagueNameEigo(this.category.league.name)}`,
          disabled: false,
        },
        {
          text: this.category.name,
          to: this.$route.path,
          disabled: true
        }
      ]
    }
  },
  created() {
    this.getData()
  },
  methods: {
    async getData() {
      this.loading = false
      await this.getCategory()
      await this.getPlayers()
      await this.getCategories()
      await this.getTeams()
      this.loading = true
    },
    async getPlayers() {
      const q = { category_id: this.category.id }
      this.isRating ? q.rating = true : q.rating = false
      const response = await this.$axios.get("/api/v1/players", {
        params: { q }
      })
      this.users = response.data.users
    },
    async searchPlayer(q) {
      q.category_id = this.$route.params.categoryId
      const response = await this.$axios.get(`/api/v1/players`, {
        params: { q }
      })
      this.users = response.data.users
    },
    async getCategory() {
      const response = await this.$axios.get(`/api/v1/categories/${this.$route.params.categoryId}`)
      this.category = response.data.category
    },
    async getTeams() {
      const response = await this.$axios.get(`/api/v1/categories/${this.category.id}/teams`)
      this.teams = response.data.teams
      const unspecified = { name: "指定なし", id: "" }
      this.teams.unshift(unspecified)
    },
    async getCategories() {
      const leagueEigo = Transform.leagueNameEigo(this.category.league.name)
      const leagueId = Transform.getLeagueId(leagueEigo)
      const response = await this.$axios.get(`/api/v1/leagues/${leagueId}/categories`)
      this.categories = response.data.categories
    }
  }
}
</script>

<style scoped>
  .league {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>