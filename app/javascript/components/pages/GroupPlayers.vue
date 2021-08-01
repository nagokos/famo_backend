<template>
  <div
    v-if="loading"
    class="league"
  >
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
  </div>
</template>

<script>
import Transform from "../../packs/league-transform"
import TheBreadCrumb from "../globals/TheBreadCrumb"

export default {
  components: {
    TheBreadCrumb
  },
  data() {
    return {
      players: [],
      group: {},
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
          to: `/${this.$route.params.league}`,
          disabled: false,
        },
        {
          text: this.group.category.name,
          to: `/${this.$route.params.league}/${this.$route.params.categoryId}`,
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
    this.getGroup()
    this.getPlayers()
  },
  methods: {
    async getPlayers() {
      const response = await this.$axios.get(`/api/v1/groups/${this.$route.params.groupId}/users`)
      this.players = response.data.users
    },
    async getGroup() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(
        `/api/v1/${leagueId}/${this.$route.params.categoryId}/groups/${this.$route.params.groupId}`
      )
      this.group = response.data.group
      this.loading = true
    }
  }
}
</script>