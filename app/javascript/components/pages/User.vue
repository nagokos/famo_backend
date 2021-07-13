<template>
  <div v-if="loading">
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <the-profile-wrapper
      :user="user"
      :is-follow="isFollow"
      @click-follow="userFollow"
      @click-unfollow="userUnfollow"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
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
      user: {}
    }
  },
  computed: {
    ...mapGetters({ isFollow: "relationship/isFollow" }),
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
    this.setData()
  },
  methods: {
    async setData() {
      await this.getUser()
      await this.$store.dispatch("relationship/checkFollow", this.user.id)
      this.loading = true
    },
    async getUser() {
      const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}`)
      this.user = response.data.user
    },
    userFollow() {
      try {
        this.$store.dispatch("relationship/follow", this.user.id)
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "既にフォローしています"
        })
      }
    },
    userUnfollow() {
      this.$store.dispatch("relationship/unfollow", this.user.id)
    }
  }
}
</script>