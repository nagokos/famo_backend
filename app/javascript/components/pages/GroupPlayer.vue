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
          @search-player="searchPlayer"
        />
        <router-view
          :users="users"
          :teams="teams"
          :area="group"
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
          text: this.group.league.name,
          to: `/${Transform.leagueNameEigo(this.group.league.name)}`,
          disabled: false,
        },
        {
          text: this.group.category.name,
          to: `/${Transform.leagueNameEigo(this.group.league.name)}/${this.group.category.id}`,
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
   this.getData()
  },
  methods: {
    async getData() {
      await this.getGroup()
      await this.getPlayers()
      await this.getGroups()
      await this.getTeams()
      this.loading = true
    },
    async getPlayers() {
      const q = { group_id: this.group.id }
      this.isRating ? q.rating = true : q.rating = false
      const response = await this.$axios.get("/api/v1/players", {
        params: { q }
      })
      this.users = response.data.users
    },
    async searchPlayer(q) {
      q.group_id = this.$route.params.groupId
      const response = await this.$axios.get(`/api/v1/players`, {
        params: { q }
      })
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