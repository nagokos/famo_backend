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
          :league="group"
          :leagues="groups"
          :teams="teams"
          v-bind.sync="q"
        />
        <router-view
          :users="users"
          :teams="teams"
          :area="group"
          :q="q"
          :page.sync="page"
          :total-count="totalCount"
          :total-pages="totalPages"
          :current-page="currentPage"
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
    if (to.params.groupId !== from.params.groupId) {
      this.getData()
    } else {
      this.getPlayers()
    }
  },
  data() {
    return {
      users: [],
      group: {},
      groups: [],
      teams: [],
      loading: false,
      q: {
        groupId: "",
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
          text: this.group.league.name,
          to: `/${this.leagueNameEigo(this.group.league.name)}`,
          disabled: false,
        },
        {
          text: this.group.category.name,
          to: `/${this.leagueNameEigo(this.group.league.name)}/${this.group.category.id}`,
          disabled: false
        },
        {
          text: this.group.name,
          to: this.$route.path,
          disabled: true
        }
      ]
    }
  },
  created() {
    if (!!this.$route.query.page) this.page = +this.$route.query.page
    if (!!this.$route.params.search) this.q = this.$route.params.search
    this.getData()
  },
  methods: {
    async getData() {
      this.loading = false
      await this.getGroup()
      await this.getPlayers()
      await this.getGroups()
      await this.getTeams()
      this.loading = true
    },
    async getPlayers() {
      this.q.groupId = this.group.id
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
    async getGroup() {
      const response = await this.$axios.get(`/api/v1/groups/${this.$route.params.groupId}`)
      this.group = response.data.group
      if (this.group.name === null) {
        this.$store.dispatch("notFound/setNotFound", true)
      }
    },
    async getTeams() {
      const response = await this.$axios.get(`/api/v1/groups/${this.group.id}/teams`)
      this.teams = response.data.teams
      const unspecified = { name: "指定なし", id: "" }
      this.teams.unshift(unspecified)
    },
    async getGroups() {
      const categoryId = this.group.category.id
      const response = await this.$axios.get(`/api/v1/categories/${categoryId}/groups`)
      this.groups = response.data.groups
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