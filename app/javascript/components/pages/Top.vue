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
              class="mt-4"
              x-large
              style="font-weight: bold"
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
            <p class="text-h4 font-weight-black mb-1">
              選手を探す
            </p>
            <p
              class="font-weight-black mt-3"
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
          <v-col>
            <p class="text-h4 font-weight-black mb-1">
              The Best Players
            </p>
            <p
              class="font-weight-black mt-3"
              style="color: #EF5350;"
            >
              シーズンを通してのベストプレイヤー達です！
            </p>
          </v-col>
        </v-row>
      </v-container>
    </div>
    <div class="review-area">
      <v-container>
        <v-row>
          <v-col>
            <p class="text-h4 font-weight-black mb-1">
              みんなの評価
            </p>
            <p
              class="font-weight-black mt-3"
              style="color: #EF5350;"
            >
              選手達の評価です！
            </p>
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
import SignupDialog from "../parts/SignupDialog"

export default {
  components: {
    SignupDialog
  },
  computed: {
    mobileStyle() {
      if (this.$vuetify.breakpoint.mobile) return 'text-h4 font-weight-black'
      else return 'text-h3 font-weight-black mt-4'
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