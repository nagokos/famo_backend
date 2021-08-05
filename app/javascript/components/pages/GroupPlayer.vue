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
        <v-col
          cols="12"
          lg="8"
        >
          <div
            class="font-weight-bold"
            style="font-size: 1.8rem"
          >
            {{ group.name }}
          </div>
          <div v-if="$vuetify.breakpoint.mobile">
            詳細条件
          </div>
          <v-tabs
            class="mt-2"
            background-color="#FAFAFA"
            color="black"
          >
            <v-tab
              exact
              class="font-weight-bold"
              :ripple="false"
              :to="{ name: 'groupPlayer' }"
            >
              選手一覧
            </v-tab>
            <v-tab
              exact
              class="font-weight-bold"
              :ripple="false"
              :to="{ name: 'groupRating' }"
            >
              ランキング
            </v-tab>
          </v-tabs>
          <v-divider />
          <router-view
            :users="users"
            :league="group"
          />
        </v-col>
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
      const response = await this.$axios.get(`/api/v1/players`, {
        params: {
          q: {
            group_id: this.$route.params.groupId
          }
        }
      })
      this.users = response.data.users
    },
    async searchPlayer(position, team) {
      const response = await this.$axios.get(`/api/v1/players`, {
        params: {
          q: {
            group_id: this.$route.params.groupId,
            position: position,
            team_id: team
          }
        }
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
      console.log(this.teams);
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