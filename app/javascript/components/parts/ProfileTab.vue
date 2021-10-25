<template>
  <v-tabs
    :fixed-tabs="$vuetify.breakpoint.mobile"
    background-color="#FAFAFA"
    :class="$vuetify.breakpoint.mobile ? 'px-4' : ''"
  >
    <v-tab
      exact
      :ripple="false"
      class="font-weight-bold"
      @click="transitionReview"
    >
      レビュー
    </v-tab>
    <v-tab
      exact
      :ripple="false"
      class="font-weight-bold"
      @click="transitionFollowing"
    >
      フォロー
    </v-tab>
    <v-tab
      exact
      :ripple="false"
      class="font-weight-bold"
      @click="transitionFollowers"
    >
      フォロワー
    </v-tab>
  </v-tabs>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
  },
  methods: {
    transitionReview() {
      if (this.$route.path.includes("profile")) {
        this.$router.push({ name: "myReview" }, () => {})
      } else if (this.$route.path.includes("users")) {
        this.$router.push({ name: "reviewerReview" }, () => {})
      } else {
        this.$router.push({ name: "playerReview" }, () => {})
      }
    },
    transitionFollowing() {
      if (!this.currentUser) {
        this.$router.push({ name: "login" })
        return this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "ログインしてください"
        })
      }
      if (this.$route.path.includes("profile")) {
        this.$router.push({ name: "myFollowing" }, () => {})
      } else if (this.$route.path.includes("users")) {
        this.$router.push({ name: "reviewerFollowing" }, () => {})
      } else {
        this.$router.push({ name: "playerFollowing" }, () => {})
      }
    },
    transitionFollowers() {
      if (!this.currentUser) {
        this.$router.push({ name: "login" })
        return this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "ログインしてください"
        })
      }
      if (this.$route.path.includes("profile")) {
        this.$router.push({ name: "myFollowers" }, () => {})
      } else if (this.$route.path.includes("users")) {
        this.$router.push({ name: "reviewerFollowers" }, () => {})
      } else {
        this.$router.push({ name: "playerFollowers" }, () => {})
      }
    }
  }
}
</script>
