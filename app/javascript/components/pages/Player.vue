<template>
  <div v-if="loading">
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <the-profile-wrapper
      :user="user"
    />
  </div>
</template>

<script>
import Transform from "../../packs/league-transform"
import TheProfileWrapper from "../parts/TheProfileWrapper"
import TheBreadCrumb from "../globals/TheBreadCrumb"

export default {
  components: {
    TheProfileWrapper,
    TheBreadCrumb,
  },
  beforeRouteUpdate(to, from, next) {
    if (from.params.userId !== to.params.userId) {
      this.getUser(to.params.userId)
    }
    next()
  },
  data() {
    return {
      loading: false,
      user: {},
    }
  },
  computed: {
    breadCrumbs() {
      if (this.user.profile.group !== null) {
        return [
          {
            text: "TOP",
            to: "/",
            disabled: false
          },
          {
            text: this.user.profile.league.name,
            to: `/${Transform.leagueNameEigo(this.user.profile.league.name)}`,
            disabled: false
          },
          {
            text: this.user.profile.category.name,
            to: `/${Transform.leagueNameEigo(this.user.profile.league.name)}/${this.user.profile.category.id}`,
            disabled: false
          },
          {
            text: this.user.profile.group,
            to: `/${Transform.leagueNameEigo(this.user.profile.league.name)}/${this.user.profile.category.id}/${this.user.profile.groupId}`,
            disabled: false
          },
          {
            text: `${this.fullName}さん`,
            to: this.$route.path,
            disabled: true
          },
        ]
      } else {
        return [
          {
            text: "TOP",
            to: "/",
            disabled: false
          },
          {
            text: this.user.profile.league.name,
            to: `/${Transform.leagueNameEigo(this.user.profile.league.name)}`,
            disabled: false
          },
          {
            text: this.user.profile.category.name,
            to: `/${Transform.leagueNameEigo(this.user.profile.league.name)}/${this.user.profile.category.id}`,
            disabled: false
          },
          {
            text: `${this.fullName}さん`,
            to: this.$route.path,
            disabled: true
          },
        ]
      }
    },
    fullName() {
      return `${this.user.lastName}${this.user.firstName}`
    }
  },
  created() {
    this.getUser()
  },
  methods: {
    async getUser() {
      this.loading = false
      const userId = this.$route.params.userId
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/users/${userId}?role=player`)
      this.user = response.data.user
      this.loading = true
    },
  }
}
</script>