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
          <v-col
            v-if="loading && currentUser.role === 'player' && !$vuetify.breakpoint.mobile"
            cols="4"
          >
            <!-- 選手テーブル -->
            <player-table
              :profile="profile"
            />
          </v-col>
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
      <v-col
        v-if="loading && currentUser.role === 'player' && userInformation && $vuetify.breakpoint.mobile"
        cols="12"
      >
        <player-card
          :profile="profile"
        />
      </v-col>
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
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import CareerCard from "../parts/CareerCard"
import ProfileAction from "../parts/ProfileAction"
import ProfileTitle from "../parts/ProfileTitle"
import PlayerTable from "../parts/PlayerTable"
import PlayerCard from "../parts/PlayerCard"
import ProfileIntroduction from '../parts/ProfileIntroduction.vue'
import ProfileTab from "../parts/ProfileTab"
import ReviewList from "../parts/ReviewList"
import RelationCard from "../parts/RelationCard"
import TheBreadCrumb from "../globals/TheBreadCrumb"

export default {
  components: {
    CareerCard,
    PlayerTable,
    PlayerCard,
    ProfileAction,
    ProfileTitle,
    ProfileIntroduction,
    ProfileTab,
    ReviewList,
    RelationCard,
    TheBreadCrumb,
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
    async getProfileData() {
      const response = await this.$axios.get("/api/v1/profile")
      this.profile = response.data
      this.loading = true
    },
    async updateIntroduction() {
      const response = await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
      if (response.errors) {
        this.$refs.profileIntroduction.setErrors(response.errors)
        return this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "文字数がオーバーしています"
        })
      }
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "更新しました"
      })
      this.$refs.profileIntroduction.close()
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