<template>
  <div>
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <div
      class="contents"
    >
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
          <v-col
            cols="12"
            lg="8"
          >
            <!-- 自己紹介文 -->
            <introduction
              v-if="!introductionForm"
              :user="currentUser"
              @open-form="introductionOpen"
            />
            <!-- 自己紹介編集 -->
            <introduction-edit
              v-if="introductionForm"
              ref="introductionEdit"
              :introduction.sync="userEdit.introduction"
              @send-introduction="updateIntroduction"
              @close-form="introductionForm = false"
            />
          </v-col>
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
      class="mx-auto"
      style="max-width: 1018px;"
    >
      <v-divider />
      <!-- タブ -->
      <profile-tab />
    </div>
    <v-divider />
    <div
      class="contents mt-5"
    >
      <v-container>
        <v-row>
          <!-- 選手カード -->
          <v-col
            v-if="$route.path === '/profile'"
            cols="12"
            md="4"
          />
          <v-col
            v-if="$route.path === '/profile'"
            cols="12"
            md="8"
          >
            <review-card
              :user="currentUser"
            />
          </v-col>
          <relation-card
            v-if="$route.path === '/profile/relation'"
            :user="currentUser"
          />
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import ProfileAction from "../parts/ProfileAction"
import ProfileTitle from "../parts/ProfileTitle"
import PlayerTable from "../parts/PlayerTable"
import PlayerCard from "../parts/PlayerCard"
import Introduction from '../parts/Introduction.vue'
import IntroductionEdit from '../parts/IntroductionEdit.vue'
import ProfileTab from "../parts/ProfileTab"
import ReviewCard from "../parts/ReviewCard"
import RelationCard from "../parts/RelationCard"
import TheBreadCrumb from "../globals/TheBreadCrumb"

export default {
  components: {
    PlayerTable,
    PlayerCard,
    ProfileAction,
    ProfileTitle,
    Introduction,
    IntroductionEdit,
    ProfileTab,
    ReviewCard,
    RelationCard,
    TheBreadCrumb,
  },
  data() {
    return {
      introductionForm: false,
      userEdit: {},
      profile: {},
      loading: false,
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    breadCrumbs() {
      return [
        {
          text: "TOP",
          to: "/",
          disabled: false
        },
        {
          text: "マイページ",
          to: this.$route.path,
          disabled: true
        },
      ]
    }
  },
  created() {
    this.setUserEdit()
    this.getProfileData()
  },
  methods: {
    setUserEdit() {
      this.userEdit = { ...this.currentUser }
    },
    introductionOpen() {
      this.introductionForm = true
      this.setUserEdit()
    },
    async getProfileData() {
      const response = await this.$axios.get("/api/v1/profile")
      this.profile = response.data
      this.loading = true
    },
    async updateIntroduction() {
      const response = await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
      if (response.errors) {
        this.$refs.introductionEdit.setErrors(response.errors)
        return this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "文字数がオーバーしています"
        })
      }
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "更新しました"
      })
      this.introductionForm = false
    },
  }
}
</script>

<style scoped>
  .contents {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>