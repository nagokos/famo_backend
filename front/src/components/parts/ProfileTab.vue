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
      @click="pushReviewPage"
    >
      レビュー
    </v-tab>
    <v-tab
      exact
      :ripple="false"
      class="font-weight-bold"
      @click="pushFollowingPage"
    >
      フォロー
    </v-tab>
    <v-tab
      exact
      :ripple="false"
      class="font-weight-bold"
      @click="pushFollowerPage"
    >
      フォロワー
    </v-tab>
  </v-tabs>
</template>

<script>
import { mapGetters } from 'vuex';
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true,
    },
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" })
  },
  methods: {
    pushReviewPage() {
      if (this.$route.path.includes("profile")) {
        this.$router.push({ name: 'myReview' }, () => {})
      } else if (this.$route.path.includes("users")) {
        this.$router.push({ name: 'reviewerReview' }, () => {})
      } else {
        this.$router.push({ name: 'playerReview' }, () => {})
      }
    },
    pushFollowingPage() {
      if (!this.currentUser) return this.pushLoginPage()
      if (this.$route.path.includes("profile")) {
        this.$router.push({ name: 'myFollowing' }, () => {})
      } else if (this.$route.path.includes("users")) {
        this.$router.push({ name: 'reviewerFollowing' }, () => {})
      } else {
        this.$router.push({ name: 'playerFollowing' }, () => {})
      }
    },
    pushFollowerPage() {
      if (!this.currentUser) return this.pushLoginPage()
      if (this.$route.path.includes("profile")) {
        this.$router.push({ name: 'myFollowers' }, () => {})
      } else if (this.$route.path.includes("users")) {
        this.$router.push({ name: 'reviewerFollowers' }, () => {})
      } else {
        this.$router.push({ name: 'playerFollowers' }, () => {})
      }
    },
    pushLoginPage() {
      this.$router.push({ name: "login" })
      this.$store.dispatch("flash/setFlash", {
        type: "error",
        message: "ログインしてください",
      });
    }
  }
};
</script>
