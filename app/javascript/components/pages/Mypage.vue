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
          <player
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
      <player
        v-if="loading && userInformation && $vuetify.breakpoint.mobile"
        ref="playerCard"
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
    <the-player-dialog
      ref="playerDialog"
      @click-register="createPlayerData"
    />
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import CareerCard from "../parts/CareerCard"
import ProfileAction from "../parts/ProfileAction"
import ProfileTitle from "../parts/ProfileTitle"
import Player from "../parts/Player"
import ProfileIntroduction from '../parts/ProfileIntroduction.vue'
import ProfileTab from "../parts/ProfileTab"
import ReviewList from "../parts/ReviewList"
import RelationCard from "../parts/RelationCard"
import TheBreadCrumb from "../globals/TheBreadCrumb"
import ThePlayerDialog from "../parts/ThePlayerDialog"

export default {
  components: {
    CareerCard,
    Player,
    ProfileAction,
    ProfileTitle,
    ProfileIntroduction,
    ProfileTab,
    ReviewList,
    RelationCard,
    TheBreadCrumb,
    ThePlayerDialog,
  },
  data() {
    return {
      userInformation: true,
      reviewList: false,
      userEdit: {},
      profile: {},
      profileEdit: {},
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
    async updatePlayerData() {
      try {
        const response = await this.$axios.patch("/api/v1/profile", {
          profile: this.profileEdit
        })
        this.profile = response.data
        if (this.$vuetify.breakpoint.mobile) return this.$refs.playerCard.close()
        else return this.$refs.playerTable.close()
      } catch(err) {
        if (this.$vuetify.breakpoint.mobile) return this.$refs.playerCard.setErrors(err.response.data.errors)
        else return this.$refs.playerTable.setErrors(err.response.data.errors)
      }
    }
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