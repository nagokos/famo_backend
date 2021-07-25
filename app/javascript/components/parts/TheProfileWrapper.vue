<template>
  <div v-if="loading">
    <div class="contents">
      <v-list color="#FAFAFA">
        <v-list-item>
          <!-- アバター -->
          <v-list-item-avatar :size="$vuetify.breakpoint.mobile ? 100 : 110">
            <v-img
              :src="user.avatar"
            />
          </v-list-item-avatar>
          <!-- タイトル -->
          <v-list-item-content>
            <profile-title
              v-if="!$vuetify.breakpoint.mobile"
              class="mt-8 py-0"
              :user="user"
            />
          </v-list-item-content>
          <profile-action
            :user="user"
            :is-follow="isFollow"
            :class="{ 'mt-12': !$vuetify.breakpoint.mobile }"
            @create-review="pushReview"
          />
        </v-list-item>
        <profile-title
          v-if="$vuetify.breakpoint.mobile"
          class="ml-3"
          :user="user"
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
              :user="user"
              @open-form="openIntroduction"
            />
            <!-- 自己紹介編集 -->
            <introduction-edit
              v-if="introductionForm"
              ref="introductionEdit"
              :introduction.sync="userEdit.introduction"
              @send-introduction="$emit('update-introduction', userEdit)"
              @close-form="closeIntroduction"
            />
          </v-col>
          <v-col
            v-if="user.role === 'player' && !$vuetify.breakpoint.mobile"
            cols="4"
          >
            <!-- 選手テーブル -->
            <player-table
              :profile="user.profile"
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
    <div class="contents mt-5">
      <v-container>
        <v-row>
          <!-- 選手カード -->
          <v-col
            v-if="!isRelation"
            cols="12"
            md="4"
          />
          <v-col
            v-show="!isRelation"
            cols="12"
            md="8"
          >
            <keep-alive
              v-for="(review, index) in reviews"
              :key="index"
            >
              <review-card
                v-if="!isRelation"
                :user="user"
                :review="review"
                @delete-review="filterReview"
              />
            </keep-alive>
          </v-col>
          <keep-alive>
            <relation-card
              v-if="isRelation"
              :user="user"
            />
          </keep-alive>
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
import ProfileAction from "../parts/ProfileAction"
import ProfileTitle from "../parts/ProfileTitle"
import PlayerTable from "../parts/PlayerTable"
import Introduction from '../parts/Introduction.vue'
import IntroductionEdit from '../parts/IntroductionEdit.vue'
import ProfileTab from "../parts/ProfileTab"
import ReviewCard from "../parts/ReviewCard"
import RelationCard from "../parts/RelationCard"

export default {
  components: {
    PlayerTable,
    ProfileAction,
    ProfileTitle,
    Introduction,
    IntroductionEdit,
    ProfileTab,
    ReviewCard,
    RelationCard,
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
  },
  data() {
    return {
      loading: false,
      isFollow: false,
      introductionForm: false,
      userEdit: { ...this.user },
      reviews: []
    }
  },
  computed: {
    isRelation() {
      return this.$route.path.includes("/following") || this.$route.path.includes("/followers")
    },
    isMypage() {
      return this.$route.path.includes("/profile")
    }
  },
  created() {
    this.checkFollow()
    this.getReviews()
  },
  methods: {
    openIntroduction() {
      this.introductionForm = true
      this.userEdit = { ...this.user }
    },
    closeIntroduction() {
      this.introductionForm = false
    },
    introductionErrors(errors) {
      this.$refs.introductionEdit.setErrors(errors)
    },
    filterReview(deleteReview) {
      this.reviews = this.reviews.filter(review => review.id !== deleteReview.id )
    },
    pushReview(review) {
      console.log(review);
      this.reviews.unshift(review)
    },
    async getReviews() {
      if (this.isMypage) {
        const response = await this.$axios.get("/api/v1/users/current/reviews")
        this.reviews = response.data.reviews
      } else {
        const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/reviews`)
        this.reviews = response.data.reviews
      }
      this.loading = true
    },
    async checkFollow() {
      if (!this.isMypage) {
        const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/relationships/check`)
        this.isFollow = response.data.status
      }
    }
  }
}
</script>

<style scoped>
  .contents {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>