<template>
  <div class="top">
    <!-- トップページメイン -->
    <div class="site-concept">
      <v-container>
        <v-row class="mt-10">
          <v-col
            cols="12"
            md="6"
            :class="$vuetify.breakpoint.mobile ? 'text-center' : 'mt-10'"
          >
            <p :class="mobileStyle">
              Everyone please rate
            </p>
            <p style="color: #616161;">
              Famoは「みんなの評価が選手の評価に」をコンセプトとした、
              <br
                v-if="!$vuetify.breakpoint.mobile"
              >
              高校生のプレーヤーを評価するサイトです。
            </p>
            <v-btn
              dark
              color="black"
              class="mt-4 font-weight-bold"
              x-large
              :ripple="false"
              :to="{ name: 'login' }"
            >
              今すぐはじめる
            </v-btn>
          </v-col>
          <v-col
            align="center"
            cols="12"
            md="6"
          >
            <v-img
              max-width="450"
              src="/img/football.svg"
            />
          </v-col>
        </v-row>
      </v-container>
    </div>
    <!-- 選手を探す -->
    <div class="player-search">
      <v-container>
        <v-row>
          <v-col>
            <p class="text-h4 font-weight-bold mb-1">
              選手を探す
            </p>
            <p
              class="font-weight-bold mt-3"
              style="color: #EF5350;"
            >
              各リーグから選手を探すことができます
            </p>
          </v-col>
        </v-row>
        <v-row>
          <v-col
            cols="12"
            md="6"
          >
            <v-col class="py-0">
              <span class="font-weight-bold">プリンス・プレミア</span>
            </v-col>
            <v-col>
              <v-btn
                outlined
                rounded
                small
                class="font-weight-bold"
              >
                プリンス
              </v-btn>
            </v-col>
          </v-col>
          <v-col
            cols="12"
            md="6"
          />
        </v-row>
      </v-container>
    </div>
    <div class="players-area">
      <v-container>
        <v-row>
          <v-col cols="12">
            <p class="text-h4 font-weight-bold mb-1">
              The Best Players
            </p>
          </v-col>
        </v-row>
      </v-container>
    </div>
    <div class="review-area mb-16">
      <v-container>
        <v-row>
          <v-col cols="12">
            <p class="text-h4 font-weight-bold mb-1">
              みんなの評価
            </p>
          </v-col>
          <v-col
            v-for="(review, index) in reviews"
            :key="index"
            cols="12"
            lg="6"
          >
            <v-card
              outlined
              :min-height="$vuetify.breakpoint.mobile ? 370 : 310"
              :max-height="$vuetify.breakpoint.mobile ? 370 : 310"
            >
              <v-card-title>
                <v-avatar
                  class="mr-3"
                  style="cursor: pointer;"
                  @click="pushUserPage(review.reviewee.id)"
                >
                  <v-img
                    :src="review.reviewee.avatar"
                  />
                </v-avatar>
                <span
                  class="font-weight-bold"
                  style="cursor: pointer;"
                  @click="pushUserPage(review.reviewee.id)"
                >{{ review.reviewee.fullName }}</span>
              </v-card-title>
              <v-card-text class="pb-0">
                <p class="text-caption">
                  {{ review.reviewee.team }} / {{ review.reviewee.position }}
                </p>
                <v-divider />
              </v-card-text>
              <v-card-actions class="pl-3 mt-2 pb-0">
                <v-rating
                  v-model="review.rate"
                  align="right"
                  background-color="#ef5350"
                  color="#ef5350"
                  readonly
                  dense
                />
                <span
                  class="ml-1 text-h6 font-weight-bold"
                >
                  {{ review.rate.toFixed(1) }}
                </span>
                <span
                  v-if="!$vuetify.breakpoint.mobile"
                  class="text-caption mt-1 ml-3"
                  style="color: rgba(0,0,0,.6)"
                >
                  試合日 {{ review.gameDate }}
                </span>
              </v-card-actions>
              <v-card-text
                class="py-0 mt-2"
                :style="$vuetify.breakpoint.mobile ? 'height: 135px; max-height: 135px;' : 'height: 75px; max-height: 75px;'"
              >
                <p
                  v-if="$vuetify.breakpoint.mobile"
                  class="text-caption"
                >
                  試合日 {{ review.gameDate }}
                </p>
                <p>
                  {{ cutContent(review.content) }}<span
                    v-if="review.content.length >= 80"
                    class="text-caption mt-1 ml-3 blue--text text--darken-2"
                    style="cursor: pointer;"
                  >
                    もっとみる
                  </span>
                </p>
              </v-card-text>
              <v-card-actions class="mr-3">
                <v-spacer />
                <v-avatar
                  size="40"
                  class="mr-3"
                  style="cursor: pointer;"
                  @click="pushUserPage(review.reviewer.id)"
                >
                  <v-img
                    :src="review.reviewer.avatar"
                  />
                </v-avatar>
                <span
                  class="font-weight-bold"
                  style="cursor: pointer;"
                  @click="pushUserPage(review.reviewer.id)"
                >{{ review.reviewer.fullName }}</span>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </div>
    <signup-dialog
      ref="signupDialog"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import SignupDialog from "../parts/SignupDialog"

export default {
  components: {
    SignupDialog
  },
  data() {
    return {
      reviews: []
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    cutContent: () =>  {
      return(content) => {
        if (content.length >= 80) {
          return `${content.substr(0, 80)}...`;
        } else {
          return content
        }
      }
    },
    mobileStyle() {
      if (this.$vuetify.breakpoint.mobile) return 'text-h4 font-weight-bold'
      else return 'text-h3 font-weight-bold mt-4'
    },
  },
  created() {
    this.getReviews()
  },
  mounted() {
    this.isActivation()
    this.isLogout()
    this.isDelete()
  },
  methods: {
    isActivation() {
      if (document.cookie.includes("activation=1")) {
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: 'アカウントを認証しました'
        })
        document.cookie = "activation=; max-age=0"
      }
    },
    isLogout() {
      if (localStorage.getItem('logout')) {
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "ログアウトしました"
        })
        localStorage.removeItem("logout")
      }
    },
    isDelete() {
      if (localStorage.getItem('delete')) {
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "アカウントを削除しました"
        })
        localStorage.removeItem("delete")
      }
    },
    pushUserPage(userId) {
      if (this.currentUser.id === userId) {
        this.$router.push({ name: "profile" })
      } else {
        this.$router.push({ name: "userProfile", params: { userId: userId } })
      }
    },
    async getReviews() {
      const response = await this.$axios.get("/api/v1/reviews")
      this.reviews = response.data.reviews
      console.log(this.reviews);
    }
  }
}
</script>

<style scoped>
  .top {
    max-width: 1050px;
    margin: 0 auto;
  }
  .player-search {
    margin-top: 100px;
  }
  .players-area {
    margin-top: 100px;
  }
  .review-area {
    margin-top: 100px;
  }
</style>