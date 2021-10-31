<template>
  <v-card
    outlined
    elevation="1"
    class="mb-8"
  >
    <v-list class="pb-0">
      <v-list-item>
        <v-list-item-avatar
          size="45"
          class="mr-2"
          :style="!!reviewUser ? 'cursor: pointer;' : ''"
          @click="pushUserPage"
        >
          <v-img
            :src="avatar"
          />
        </v-list-item-avatar>
        <v-list-item-content class="mt-1">
          <v-list-item-title :class="$vuetify.breakpoint.mobile ? 'mb-0' : ''">
            <span :class="$vuetify.breakpoint.mobile ? 'text-caption font-weight-bold' : 'text-body-2 font-weight-bold'">
              <span
                v-cloak
                :style="!!reviewUser ? 'cursor: pointer;' : ''"
                @click="pushUserPage"
              >
                {{ userName }}
              </span>
              <span v-if="user.role === 'player' && !!reviewUser">
                さんのレビュー
              </span>
              <span v-if="user.role === 'reviewer'">
                {{ `さんへのレビュー・${relativeTime}` }}
              </span>
            </span>
          </v-list-item-title>
          <v-list-item-subtitle
            v-if="user.role === 'player'"
            class="pb-0"
          >
            <span
              class="text-caption"
              style="color: rgba(0,0,0,.6)"
            >
              {{ relativeTime }}
            </span>
          </v-list-item-subtitle>
          <v-list-item-subtitle
            v-if="user.role === 'reviewer'"
            class="pb-0"
          >
            <span
              class="text-caption"
              style="color: rgba(0,0,0,.6)"
            >
              {{ review.reviewee.profile.team }}({{ review.reviewee.profile.prefecture.name }}) / {{ review.reviewee.profile.position }}
            </span>
          </v-list-item-subtitle>
        </v-list-item-content>
        <review-card-menu
          :review="review"
          :user="user"
          @delete-review="deleteReview"
        />
      </v-list-item>
    </v-list>
    <v-card-actions class="pl-3 py-0">
      <v-rating
        :value="+review.rate"
        background-color="#ef5350"
        color="#ef5350"
        readonly
        dense
        half-increments
      />
      <span class="ml-1 text-h6 font-weight-bold">
        {{ review.rate }}
      </span>
      <span
        v-if="!$vuetify.breakpoint.mobile"
        class="text-caption mt-1 ml-3"
        style="color: rgba(0,0,0,.6)"
      >
        試合日 {{ review.gameDate }}
      </span>
    </v-card-actions>
    <v-card-text class="mb-2 pt-1">
      <span
        v-if="$vuetify.breakpoint.mobile"
        class="text-caption"
        style="color: rgba(0,0,0,.6)"
      >
        試合日 {{ review.gameDate }}
      </span>
      <p class="mb-0 mt-2">
        {{ review.content.length >= 350 ? `${review.content.substr(0, 350)}...` : review.content }}
        <span
          v-if="review.content.length >= 350"
          class="text-caption mt-1 ml-3 blue--text text--darken-2"
          style="cursor: pointer;"
          @click="$refs.showReviewDialog.open()"
        >
          もっとみる
        </span>
      </p>
    </v-card-text>
    <v-card-actions 
      v-if="!isMyReview" 
      class="pr-5"
    >
      <v-spacer />
      <div>
        <v-icon 
          v-if="isLike"
          size="20"
          @click="deleteLike"
        >
          mdi-thumb-up
        </v-icon>
        <v-icon 
          v-if="!isLike"
          size="20"
          @click="createLike"
        >
          mdi-thumb-up-outline
        </v-icon>
        <span
          v-if="likeCount > 0"
          style="position: relative; top: 1px;"
        >{{ likeCount }}</span>
      </div>
      <!-- <v-icon 
        size="20" 
        @click="$refs.reviewReportDialog.open()"
      >
        mdi-flag-outline
      </v-icon> -->
    </v-card-actions>
    <the-review-report-dialog
      ref="reviewReportDialog"
      :review="review" 
    />
    <the-show-review-dialog
      ref="showReviewDialog"
      :user="user"
      :review="review"
    />
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'
import ReviewCardMenu from "./ReviewCardMenu"
import TheShowReviewDialog from "./TheShowReviewDialog"
import TheReviewReportDialog from "./TheReviewReportDialog"

export default {
  components: {
    ReviewCardMenu,
    TheShowReviewDialog,
    TheReviewReportDialog,
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
    review: {
      type: Object,
      default: () => {},
      required: true
    },
    status: {
      type: Boolean,
      default: false,
      required: true
    },
    count: {
      type: Number,
      default: 0,
      required: true
    }
  },
  data() {
    return {
      isLike: this.status,
      likeCount: this.count
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    relativeTime() {
      return this.$dayjs(this.review.createdAt).fromNow()
    },
    isMyReview() {
      if (!this.reviewUser) return
      return this.review.reviewer.id === this.currentUser.id
    },
    userName() {
      if (!this.reviewUser) return "退会したユーザー"
      return this.user.role === 'player' ? this.review.reviewer.name : this.review.reviewee.name
    },
    reviewUser() {
      return this.user.role === 'player' ? this.review.reviewer : this.review.reviewee
    },
    avatar() {
      if (this.reviewUser) {
        return this.reviewUser.avatar
      } else {
        return 'https://pics.prcm.jp/a508a977c6fa9/84540173/png/84540173.png'
      }
    }
  },
  methods: {
    deleteReview(review) {
      this.$emit("delete-review", review)
    },
    pushUserPage() {
      if (!this.reviewUser) return
      if (this.currentUser.id === this.reviewUser.id) return this.$router.push({ name: "myReview" })
      if (this.reviewUser.role === "player") {
        const leagueEigo = this.leagueNameEigo(this.reviewUser.profile.league.name)
        this.$router.push({
          name: "playerReview",
          params: { league: leagueEigo, categoryId: this.reviewUser.profile.category.id, groupId: this.reviewUser.profile.groupId, userId: this.reviewUser.id }
        })
      } else {
        this.$router.push({ name: "reviewerReview", params: { userId: this.reviewUser.id } })
      }
    },
    async createLike() {
      try {
        await this.$axios.post(`/api/v1/reviews/${this.review.id}/like`)
        this.isLike = true
        this.likeCount += 1
      } catch(error) {
        console.log(error.response);
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    },
    async deleteLike() {
      await this.$axios.delete(`/api/v1/reviews/${this.review.id}/like`)
      this.isLike = false
      this.likeCount -= 1
    }
  }
}
</script>