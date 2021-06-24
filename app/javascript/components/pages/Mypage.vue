<template>
  <div>
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <div class="profile-top">
      <v-list
        color="#FAFAFA"
      >
        <v-list-item>
          <!-- アバター -->
          <v-list-item-avatar
            size="110"
          >
            <v-img
              :src="currentUser.avatar"
            />
          </v-list-item-avatar>
          <!-- タイトル -->
          <v-list-item-content>
            <profile-title
              v-if="!$vuetify.breakpoint.mobile"
              class="mt-10 py-0"
              :user="currentUser"
            />
          </v-list-item-content>
          <profile-action
            :class="{ 'mt-10': !$vuetify.breakpoint.mobile }"
            @click-edit="openEditDialog"
          />
        </v-list-item>
        <profile-title
          v-if="$vuetify.breakpoint.mobile"
          class="ml-3"
          :user="currentUser"
        />
      </v-list>
      <v-container class="px-4 pt-0">
        <v-row>
          <!-- 自己紹介文 -->
          <profile-introduction
            ref="profileIntroduction"
            :user="currentUser"
            v-bind.sync="userEdit"
            @click-introduction="userEdit = { ...currentUser }"
            @click-update="updateIntroduction"
          />
          <!-- カード -->
          <profile-card
            v-if="!$vuetify.breakpoint.mobile && loading"
            :profile="profile"
            @click-player="$refs.playerDialog.open()"
            @click-edit="openEditDialog"
          />
        </v-row>
      </v-container>
    </div>
    <div
      class="profile-tabs"
    >
      <v-divider />
      <!-- タブ -->
      <profile-tab
        @click-user="changeUserInformation"
        @click-review="changeReviewList"
      />
    </div>
    <v-divider />
    <div class="profile-contents mt-4">
      <information
        v-if="userInformation && loading"
        :user="currentUser"
        :profile="profile"
        @click-player="$refs.playerDialog.open()"
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
      @click-register="sendPlayerData"
    />
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import ProfileAction from "../parts/ProfileAction"
import ProfileTitle from "../parts/ProfileTitle"
import ProfileCard from "../parts/ProfileCard"
import ProfileIntroduction from '../parts/ProfileIntroduction.vue'
import ProfileTab from "../parts/ProfileTab"
import ReviewList from "../parts/ReviewList"
import Information from "../parts/Information"
import TheBreadCrumb from "../globals/TheBreadCrumb"
import ThePlayerDialog from "../parts/ThePlayerDialog"
import TheProfileEditDialog from "../parts/TheProfileEditDialog"

export default {
  components: {
    ProfileAction,
    ProfileTitle,
    ProfileCard,
    ProfileIntroduction,
    ProfileTab,
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
    this.setUserEdit()
    this.getProfileData()
  },
  methods: {
    setUserEdit() {
      this.userEdit = { ...this.currentUser }
    },
    changeUserInformation() {
      this.userInformation = true
      this.reviewList = false
    },
    changeReviewList() {
      this.reviewList = true
      this.userInformation = false
    },
    openEditDialog() {
      this.setUserEdit()
      this.$refs.profileEditDialog.open()
    },
    async getProfileData() {
      const response = await this.$axios.get("/api/v1/profile")
      this.profile = response.data
      this.loading = true
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
    },
    async sendPlayerData(profile) {
      try {
        const response = await this.$axios.post("/api/v1/profile", {
          profile: profile
        })
        this.profile = response.data
      } catch(err) {
        this.$refs.observer.setErrors(err.response.data.errors)
      }
    },
  }
}
</script>

<style scoped>
  .profile-top {
    max-width: 1050px;
    margin: 0 auto;
  }
  .profile-tabs {
    max-width: 1018px;
    margin: 0 auto;
  }
  .profile-contents {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>