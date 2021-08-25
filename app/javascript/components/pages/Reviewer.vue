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
      return [
        {
          text: "TOP",
          to: "/",
          disabled: false
        },
        {
          text: `${this.user.name}さん`,
          to: this.$route.path,
          disabled: true
        },
      ]
    },
  },
  created() {
    this.getUser(this.$route.params.userId)
  },
  methods: {
    async getUser(userId) {
      this.loading = false
      const response = await this.$axios.get(`/api/v1/users/${userId}?role=reviewer`)
      this.user = response.data.user
      this.loading = true
    },
  }
}
</script>