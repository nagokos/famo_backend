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
              :class="user.role === 'player' ? 'mt-8 py-0' : ''"
              :user="user"
            />
          </v-list-item-content>
          <profile-action
            :user="user"
            :is-follow="isFollow"
            :class="!$vuetify.breakpoint.mobile && user.role === 'player' ? 'mt-12' : ''"
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
            v-if="!$vuetify.breakpoint.mobile"
            cols="4"
          >
            <!-- テーブル -->
            <profile-table
              :profile="user.profile"
              :reviews="reviews"
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
      <profile-tab
        :user="user"
      />
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
            v-if="!isRelation"
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
              v-if="$route.path.includes('/following')"
              ref="following"
              @check-follow="setFollowingIds"
              @reset-ids="followersIds = []"
            />
          </keep-alive>
          <keep-alive>
            <relation-card
              v-if="$route.path.includes('/followers')"
              ref="followers"
              @check-follow="setFollowersIds"
              @reset-ids="followingIds = []"
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
import ProfileTable from "../parts/ProfileTable"
import Introduction from '../parts/Introduction'
import IntroductionEdit from '../parts/IntroductionEdit'
import ProfileTab from "../parts/ProfileTab"
import ReviewCard from "../parts/ReviewCard"
import RelationCard from "../parts/RelationCard"

export default {
  components: {
    ProfileTable,
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
      reviews: [],
      followingIds: [],
      followersIds: [],
      q: {
        sort: "created",
        gameDate: ""
      }
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
  watch: {
    $route(to, from) {
      if(to.path.includes("/following")) {
        this.$nextTick(() => {
          this.$refs.following.switchFollow(this.followersIds)
        })
      } else if (to.path.includes("/followers")) {
        this.$nextTick(() => {
           this.$refs.followers.switchFollow(this.followingIds)
        })
      }
    }
  },
  async  created() {
    await this.checkFollow()
    await this.getReviews()
    this.loading = true
  },
  methods: {
    setFollowingIds(id) {
      this.followingIds.push(id)
    },
    setFollowersIds(id) {
      this.followersIds.push(id)
    },
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