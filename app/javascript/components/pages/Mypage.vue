<template>
  <div>
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <profile
      ref="profile"
      v-if="loading"
      :user="currentUser"
      :user-edit="userEdit"
      @click-player="$refs.playerDialog.open()"
      @click-edit="openEditDialog"
      @click-introduction="userEdit = { ...currentUser }"
      @click-update="updateIntroduction"
    />
    <div
      class="profile-tabs"
    >
      <v-divider />
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
    <the-profile-edit-dialog
      ref="profileEditDialog"
      v-bind.sync="userEdit"
      @click-update="updateProfile"
    />
    <the-player-dialog
      ref="playerDialog"
    />
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import Profile from "../parts/Profile"
import ReviewList from "../parts/ReviewList"
import Information from "../parts/Information"
import TheBreadCrumb from "../globals/TheBreadCrumb"
import ThePlayerDialog from "../parts/ThePlayerDialog"
import TheProfileEditDialog from "../parts/TheProfileEditDialog"

export default {
  components: {
    Profile,
    ReviewList,
    Information,
    TheBreadCrumb,
    ThePlayerDialog,
    TheProfileEditDialog,
  },
  data() {
    return {
      userInformation: true,
      reviewList: false,
      userEdit: {},
      profile: {},
      loading: false,
      breadCrumbs: [
        {
          text: "TOP",
          to: "/",
          disabled: false
        },
        {
          text: "マイページ",
          to: "/profile",
          disabled: true
        }
      ]
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
  },
  created() {
    this.userEdit = { ...this.currentUser }
  },
  methods: {
    changeUserInformation() {
      this.userInformation = true
      this.reviewList = false
    },
    changeReviewList() {
      this.reviewList = true
      this.userInformation = false
    },
    openEditDialog() {
      this.userEdit = { ...this.currentUser }
      this.$refs.profileEditDialog.open()
    },
    async updateIntroduction() {
      await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
      this.$refs.profile.close()
    },
    async updateProfile() {
      const user = await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
      if (!user) return this.$refs.profileEditDialog.dupEmail()
      if (user.activation) {
        this.$refs.profileEditDialog.close()
      } else {
        this.$refs.profileEditDialog.sendActivationEmail()
      }
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