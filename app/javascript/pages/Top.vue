<template>
  <div class="top">
    <!-- トップページメイン -->
    <div class="site-concept">
      <v-container>
        <v-row class="mt-10">
          <v-col :class="this.bkPoint === 'lg' ? 'mt-10' : 'text-center'">
            <p :class="bkStyle">
              Everyone please rate
            </p>
            <p style="color: #616161;">Famoは「みんなの評価が選手の評価に」をコンセプトとした、
              高校生のプレーヤーを評価するサイトです。
            </p>
            <v-btn dark color="black" class="mt-4" x-large depressed style="font-weight: bold">今すぐはじめる</v-btn>
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
            <p class="text-h4 font-weight-black mb-1">選手を探す</p>
            <p class="font-weight-black" style="color: #EF5350;">~ 各リーグから選手を探すことができます ~</p>
          </v-col>
        </v-row>
        <v-row>
          <v-col>

          </v-col>
          <v-col></v-col>
          <v-col></v-col>
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
</style>