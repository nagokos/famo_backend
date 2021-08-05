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
        <v-col
          cols="12"
          lg="8"
        >
          <div
            class="font-weight-bold"
            style="font-size: 1.8rem"
          >
            {{ league.name }}
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
              :to="{ name: 'leaguePlayer' }"
            >
              選手一覧
            </v-tab>
            <v-tab
              exact
              class="font-weight-bold"
              :ripple="false"
              :to="{ name: 'leagueRating' }"
            >
              ランキング
            </v-tab>
          </v-tabs>
          <v-divider />
          <router-view
            :users="users"
            :league="league"
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
      this.getPlayers()
    }
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
    this.getData()
  },
  methods: {
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
      const response = await this.$axios.get(`/api/v1/players`, {
        params: {
          q: {
            league_id: leagueId,
          }
        }
      })
      this.users = response.data.users
    },
    async searchPlayer(position, team) {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/players`, {
        params: {
          q: {
            league_id: leagueId,
            position: position,
            team_id: team
          }
        }
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