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
        />
        <player-list
          :users="users"
          :league="group"
        />
      </v-row>
    </v-container>
  </div>
</template>

<script>
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
    this.getGroup()
    this.getPlayers()
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
  async created() {
    await this.getGroup()
    this.getPlayers()
    this.getGroups()
  },
  methods: {
     async getPlayers() {
      const response = await this.$axios.get(`/api/v1/groups/${this.$route.params.groupId}/users`)
      this.users = response.data.users
    },
    async getGroup() {
      const response = await this.$axios.get(`/api/v1/groups/${this.$route.params.groupId}`)
      console.log(response);
      this.group = response.data.group
      if (this.group.name === null) {
        this.$store.dispatch("notFound/setNotFound", true)
      }
      this.loading = true
    },
    async getTeams() {
      const response = await this.$axios.get(`/api/v1/groups/${this.group.id}/teams`)
      this.teams = response.data.teams
      const unspecified = { name: "指定なし", id: 0 }
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