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
      :to="{ name: setReviewName }"
    >
      レビュー
    </v-tab>
    <v-tab
      exact
      :ripple="false"
      class="font-weight-bold"
      :to="{ name: setFollowingName }"
    >
      フォロー
    </v-tab>
    <v-tab
      exact
      :ripple="false"
      class="font-weight-bold"
      :to="{ name: setFollowersName }"
    >
      フォロワー
    </v-tab>
  </v-tabs>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  computed: {
    setReviewName() {
      if (this.$route.path.includes("profile")) {
        return "myReview"
      } else if (this.$route.path.includes("users")) {
        return "reviewerReview"
      } else {
        return "playerReview"
      }
    },
    setFollowingName() {
      if (this.$route.path.includes("profile")) {
        return "myFollowing"
      } else if (this.$route.path.includes("users")) {
        return "reviewerFollowing"
      } else {
        return "playerFollowing"
      }
    },
    setFollowersName() {
      if (this.$route.path.includes("profile")) {
        return "myFollowers"
      } else if (this.$route.path.includes("users")) {
        return "reviewerFollowers"
      } else {
        return "playerFollowers"
      }
    }
  }
}
</script>
