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
              class="mt-6 py-0"
              :user="currentUser"
            />
          </v-list-item-content>
          <profile-action
            :class="{ 'mt-6': !$vuetify.breakpoint.mobile }"
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
          <!-- 選手テーブル -->
          <player-table
            v-if="loading && !$vuetify.breakpoint.mobile"
            ref="playerTable"
            :profile="profile"
            :profile-edit="profileEdit"
            @click-player="$refs.playerDialog.open()"
            @click-update="updatePlayerData"
            @click-edit="profileEdit = { ...profile }"
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
      <!-- 選手カード -->
      <player-card
        ref="playerCard"
        v-if="loading && userInformation && $vuetify.breakpoint.mobile"
        :profile="profile"
        :profile-edit="profileEdit"
        @click-player="$refs.playerDialog.open()"
        @click-edit="profileEdit = { ...profile }"
        @click-update="updatePlayerData"
      />
      <career-card
        v-if="userInformation"
      />
      <relation-card
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
      @click-register="createPlayerData"
    />
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import CareerCard from "../parts/CareerCard"
import PlayerCard from "../parts/PlayerCard"
import ProfileAction from "../parts/ProfileAction"
import ProfileTitle from "../parts/ProfileTitle"
import PlayerTable from "../parts/PlayerTable"
import ProfileIntroduction from '../parts/ProfileIntroduction.vue'
import ProfileTab from "../parts/ProfileTab"
import ReviewList from "../parts/ReviewList"
import RelationCard from "../parts/RelationCard"
import TheBreadCrumb from "../globals/TheBreadCrumb"
import ThePlayerDialog from "../parts/ThePlayerDialog"
import TheProfileEditDialog from "../parts/TheProfileEditDialog"

export default {
  components: {
    CareerCard,
    PlayerCard,
    ProfileAction,
    ProfileTitle,
    PlayerTable,
    ProfileIntroduction,
    ProfileTab,
    ReviewList,
    RelationCard,
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
      const response = await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
      if (response.errors) return this.$refs.profileIntroduction.setErrors(response.errors)
      this.$refs.profileIntroduction.close()
    },
    async updateProfile() {
      const response = await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
      if (response.errors) return this.$refs.profileEditDialog.setErrors(response.errors)
      if (response.activationState === "active") {
        this.$refs.profileEditDialog.close()
      } else {
        this.$refs.profileEditDialog.sendActivationEmail()
      }
    },
    async createPlayerData(profile) {
      try {
        const response = await this.$axios.post("/api/v1/profile", {
          profile: profile
        })
        this.profile = response.data
        this.$refs.playerDialog.close()
      } catch(err) {
        this.$refs.playerDialog.setErrors(err.response.data.errors)
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