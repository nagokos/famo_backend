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
            <p
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h4 font-weight-bold'
                  : 'text-h3 font-weight-bold mt-4'
              "
            >
              Everyone please rate
            </p>
            <p style="color: #616161">
              Famoは「みんなの評価が選手の評価に」をコンセプトとした、
              <br v-if="!$vuetify.breakpoint.mobile" />
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
            <v-btn
              v-if="!!currentUser"
              dark
              color="black"
              class="mt-4 font-weight-bold"
              x-large
              :ripple="false"
              :to="{ name: 'myReview' }"
            >
              マイページ
            </v-btn>
          </v-col>
          <v-col align="center" cols="12" md="6">
            <v-img max-width="450" src="@/assets/football.svg" />
          </v-col>
        </v-row>
      </v-container>
    </div>
    <!-- 選手を探す -->
    <home-player-search class="player-search" :leagues="leagues" />
    <div v-if="users.length !== 0" class="players-area">
      <v-container>
        <v-row>
          <v-col cols="12" class="mx-auto" style="max-width: 1050px">
            <p class="text-h4 font-weight-bold mb-1">The Best Players</p>
          </v-col>
          <v-col cols="12" class="px-0 py-0">
            <home-best-player :users="users" />
          </v-col>
        </v-row>
      </v-container>
    </div>
    <div v-if="reviews.length !== 0" class="review-area">
      <v-container>
        <v-row>
          <v-col cols="12">
            <p class="text-h4 font-weight-bold mb-1">みんなの評価</p>
          </v-col>
          <v-col
            v-for="(review, index) in reviews"
            :key="index"
            cols="12"
            lg="6"
          >
            <home-review :review="review" />
          </v-col>
        </v-row>
      </v-container>
    </div>
    <signup-dialog ref="signupDialog" />
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import HomeReview from "../parts/HomeReview";
import HomePlayerSearch from "../parts/HomePlayerSearch";
import homeBestPlayer from "../parts/HomeBestPlayer";
import SignupDialog from "../parts/SignupDialog";

export default {
  components: {
    HomeReview,
    HomePlayerSearch,
    SignupDialog,
    homeBestPlayer,
  },
  data() {
    return {
      reviews: [],
      leagues: [],
      users: [],
    };
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
  },
  created() {
    this.getLeagues();
    this.getReviews();
    this.getTopPlayers();
  },
  mounted() {
    this.toTop();
    this.activationSuccess();
    this.logoutSuccess();
    this.deleteSuccess();
    this.faildActivationUrl();
    this.faildPasswordResetUrl();
  },
  methods: {
    activationSuccess() {
      if (document.cookie.includes("activation=1")) {
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "アカウントを認証しました",
        });
        document.cookie = "activation=; max-age=0";
      }
    },
    logoutSuccess() {
      if (localStorage.getItem("logout")) {
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "ログアウトしました",
        });
        localStorage.removeItem("logout");
      }
    },
    deleteSuccess() {
      if (localStorage.getItem("delete")) {
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "アカウントを削除しました",
        });
        localStorage.removeItem("delete");
      }
    },
    faildActivationUrl() {
      if (document.cookie.includes("activation=2")) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "認証済み又はURLが無効です",
        });
        document.cookie = "activation=; max-age=0";
      } else if (document.cookie.includes("activation=3")) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "認証メールの有効期限が切れています",
        });
        document.cookie = "activation=; max-age=0";
      }
    },
    faildPasswordResetUrl() {
      if (document.cookie.includes("password_reset=1")) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "再設定済み又はURLが無効です",
        });
        document.cookie = "password_reset=; max-age=0";
      } else if (document.cookie.includes("password_reset=2")) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "再設定メールの有効期限が切れています",
        });
        document.cookie = "password_reset=; max-age=0";
      }
    },
    async getReviews() {
      console.log(process.env);
      const response = await this.$axios.get("/api/v1/reviews");
      this.reviews = response.data.reviews;
    },
    async getLeagues() {
      const response = await this.$axios.get("/api/v1/hierarchy_leagues");
      this.leagues = response.data.leagues;
    },
    async getTopPlayers() {
      const response = await this.$axios.get("/api/v1/top_players");
      if (this.$vuetify.breakpoint.mobile)
        return (this.users = response.data.users);
      const arrayUser = response.data.users;
      while (arrayUser.length) this.users.push(arrayUser.splice(0, 5));
    },
  },
};
</script>

<style scoped>
.site-concept {
  max-width: 1050px;
  margin: 0 auto;
}
.player-search {
  max-width: 1050px;
  margin: 0 auto;
  margin-top: 100px;
}
.players-area {
  max-width: 1050px;
  margin: 0 auto;
  margin-top: 100px;
}
.review-area {
  max-width: 1050px;
  margin: 0 auto;
}
</style>
