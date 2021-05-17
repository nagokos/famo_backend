<template>
  <div class="top">
    <!-- トップページメイン -->
    <div class="site-concept">
      <v-container>
        <v-row class="mt-10">
          <v-col :class="bkPoint === 'lg' ? 'mt-10' : 'text-center'">
            <p :class="bkStyle">
              Everyone please rate
            </p>
            <p style="color: #616161;">
              Famoは「みんなの評価が選手の評価に」をコンセプトとした、
              高校生のプレーヤーを評価するサイトです。
            </p>
            <v-btn
              dark
              color="black"
              class="mt-4"
              x-large
              depressed
              style="font-weight: bold"
            >
              今すぐはじめる
            </v-btn>
          </v-col>
          <v-col>
            <v-img
              max-width="400"
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
            lg="6"
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
                @click="push"
              >
                プリンス
              </v-btn>
            </v-col>
          </v-col>
          <v-col
            cols="12"
            lg="6"
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
  </div>
</template>

<script>
export default {
  data() {
    return {
    }
  },
  computed: {
    bkPoint() {
      return this.$vuetify.breakpoint.name
    },
    bkStyle() {
      const bk = this.bkPoint
      if (bk === 'lg') return 'text-h3 font-weight-black mt-4'
      else return 'text-h4 font-weight-black'
    },

  },
  mounted() {
    console.log(this.$vuetify.breakpoint.name);
  },
  methods: {
    push() {
      console.log('a');
    }
  }
}
</script>

<style scoped>
  .top {
    max-width: 1000px;
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