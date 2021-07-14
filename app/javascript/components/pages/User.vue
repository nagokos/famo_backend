<template>
  <div v-if="loading">
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <the-profile-wrapper
      :user="user"
      :is-follow="isFollow"
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
  data() {
    return {
      loading: false,
      user: {},
      isFollow: false
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
          text: `${this.fullName}さん`,
          to: this.$route.path,
          disabled: true
        },
      ]
    },
    fullName() {
      return `${this.user.lastName}${this.user.firstName}`
    }
  },
  created() {
    this.getUser()
    this.checkFollow()
  },
  methods: {
     async checkFollow() {
      const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/relationships/check`)
      this.isFollow = response.data.status
      this.loading = true
    },
    async getUser() {
      const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}`)
      this.user = response.data.user
      this.loading = true
    },
  }
}
</script>