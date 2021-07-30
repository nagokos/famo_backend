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
            <p :class="$vuetify.breakpoint.mobile ? 'text-h4 font-weight-bold' : 'text-h3 font-weight-bold mt-4'">
              Everyone please rate
            </p>
            <p style="color: #616161;">
              Famoは「みんなの評価が選手の評価に」をコンセプトとした、
              <br
                v-if="!$vuetify.breakpoint.mobile"
              >
              高校生のサッカープレーヤーを評価するサイトです。
            </p>
            <v-btn
              v-if="!currentUser"
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
    <home-player-search
      class="player-search"
      :leagues="leagues"
    />
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
    <home-reviews
      :reviews="reviews"
      class="review-area mb-16"
    />
    <signup-dialog
      ref="signupDialog"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import HomeReviews from "../parts/HomeReviews"
import HomePlayerSearch from "../parts/HomePlayerSearch"
import SignupDialog from "../parts/SignupDialog"

export default {
  components: {
    HomeReviews,
    HomePlayerSearch,
    SignupDialog,
  },
  data() {
    return {
      reviews: [],
      leagues: [],
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" })
  },
  created() {
    this.getLeagues()
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
    async getReviews() {
      const response = await this.$axios.get("/api/v1/reviews")
      this.reviews = response.data.reviews
    },
    async getLeagues() {
      const response = await this.$axios.get("/api/v1/hierarchy_leagues")
      this.leagues = response.data.leagues
    },
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