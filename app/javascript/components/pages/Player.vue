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
            to: `/${this.leagueNameEigo(this.user.profile.league.name)}`,
            disabled: false
          },
          {
            text: this.user.profile.category.name,
            to: `/${this.leagueNameEigo(this.user.profile.league.name)}/${this.user.profile.category.id}`,
            disabled: false
          },
          {
            text: this.user.profile.group,
            to: `/${this.leagueNameEigo(this.user.profile.league.name)}/${this.user.profile.category.id}/${this.user.profile.groupId}`,
            disabled: false
          },
          {
            text: `${this.user.name}さん`,
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
            to: `/${this.leagueNameEigo(this.user.profile.league.name)}`,
            disabled: false
          },
          {
            text: this.user.profile.category.name,
            to: `/${this.leagueNameEigo(this.user.profile.league.name)}/${this.user.profile.category.id}`,
            disabled: false
          },
          {
            text: `${this.user.name}さん`,
            to: this.$route.path,
            disabled: true
          },
        ]
      }
    },
  },
  created() {
    this.getUser()
  },
  methods: {
    async getUser() {
      this.loading = false
      const userId = this.$route.params.userId
      const response = await this.$axios.get(`/api/v1/players/${userId}`)
      this.user = response.data.user
      this.loading = true
    },
  }
}
</script>