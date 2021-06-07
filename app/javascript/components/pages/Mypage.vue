<template>
  <div class="mt-10 mb-4">
    <speed-dial
      v-if="$vuetify.breakpoint.mobile"
    />
    <profile
      :user="currentUser"
    />
    <div
      class="profile-tabs"
    >
      <v-tabs
        color="black"
        :fixed-tabs="$vuetify.breakpoint.mobile"
        :class="$vuetify.breakpoint.mobile ? 'px-4' : ''"
        background-color="#FAFAFA"
      >
        <v-tab
          class="mr-5 font-weight-bold"
          @click="changeUserInformation"
        >
          ユーザー情報
        </v-tab>
        <v-tab
          class="font-weight-bold"
          @click="changeReviewList"
        >
          レビュー一覧
        </v-tab>
      </v-tabs>
    </div>
    <v-divider />
    <div class="profile-contents mt-4">
      <information
        v-if="userInformation"
        :user="currentUser"
      />
      <review-list
        v-if="reviewList"
        :user="currentUser"
      />
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import SpeedDial from "../parts/mobile/SpeedDial"
import Profile from "../parts/Profile"
import ReviewList from "../parts/ReviewList"
import Information from "../parts/Information"

export default {
  components: {
    SpeedDial,
    Profile,
    ReviewList,
    Information
  },
  data() {
    return {
      fab: false,
      userInformation: true,
      reviewList: false,
      rating: 3.1
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    fullName() {
      return `${this.currentUser.last_name} ${this.currentUser.first_name}`
    },
    player() {
      if (this.currentUser.role === "player") {
        return true
      } else {
        return false
      }
    }
  },
  methods: {
    changeUserInformation() {
      this.userInformation = true
      this.reviewList = false
    },
    changeReviewList() {
      this.reviewList = true
      this.userInformation = false
    }
  }
}
</script>

<style scoped>
  .profile-tabs {
    max-width: 1018px;
    margin: 0 auto;
  }
  .profile-contents {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>