<template>
  <div :style="$vuetify.breakpoint.mobile ? 'position: relative; top: 27px;' : ''">
    <!-- ログインユーザーの場合 -->
    <v-btn
      v-if="isMypage"
      :ripple="false"
      class="font-weight-bold px-2 py-5 text-caption"
      width="130"
      :to="{ name: 'mySetting', params: { type: 'profile' } }"
    >
      プロフィール編集
    </v-btn>
    <template v-if="!isMypage && user.role === 'player'">
      <v-btn
        v-if="!$vuetify.breakpoint.mobile"
        :ripple="false"
        :outlined="!followStatus"
        depressed
        width="120"
        color="primary"
        class="font-weight-bold px-2 py-5 text-caption mr-2"
        @click="followStatus ? unfollow() : follow()"
      >
        {{ followStatus ? 'フォロー中' : 'フォローする' }}
      </v-btn>
      <v-btn
        v-if="$vuetify.breakpoint.mobile"
        depressed
        height="40"
        :ripple="false"
        :outlined="!followStatus"
        color="primary"
        class="px-2"
        @click="followStatus ? unfollow() : follow()"
      >
        <v-icon>
          {{ followStatus ? 'mdi-account-check' : 'mdi-account-plus' }}
        </v-icon>
      </v-btn>
      <v-btn
        class="font-weight-bold px-2 py-5"
        dark
        :ripple="false"
        :width="$vuetify.breakpoint.mobile ? 100 : 120"
        :style="$vuetify.breakpoint.mobile ? 'font-size: 10px;' : 'font-size: 12px;'"
        color="primary"
        @click="$refs.reviewDialog.open()"
      >
        レビューを書く
      </v-btn>
    </template>
    <template v-if="!isMypage && user.role === 'reviewer'">
      <v-btn
        :ripple="false"
        :outlined="!followStatus"
        depressed
        width="120"
        color="primary"
        class="font-weight-bold px-2 py-5 text-caption mr-2"
        @click="followStatus ? unfollow() : follow()"
      >
        {{ followStatus ? 'フォロー中' : 'フォローする' }}
      </v-btn>
    </template>
    <the-review-dialog
      ref="reviewDialog"
      :user="user"
      @create-review="createReview"
    />
  </div>
</template>

<script>
import TheReviewDialog from "./TheReviewDialog"

export default {
  components: {
    TheReviewDialog
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
    isFollow: {
      type: Boolean,
      default: false,
      required: true
    }
  },
  data() {
    return {
      followStatus: this.isFollow
    }
  },
  computed: {
    isMypage() {
      return this.$route.path.includes("/profile")
    }
  },
  methods: {
    createReview(review) {
      this.$emit("create-review", review)
    },
    async follow() {
      try {
        await this.$axios.post(`/api/v1/users/${this.$route.params.userId}/relationship`)
        this.followStatus = true
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    },
    async unfollow() {
      try {
        await this.$axios.delete(`/api/v1/users/${this.$route.params.userId}/relationship`)
        this.followStatus = false
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    }
  }
}
</script>
