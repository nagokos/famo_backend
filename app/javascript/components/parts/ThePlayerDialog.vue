<template>
  <v-dialog
    v-model="dialog"
    width="550"
    :persistent="true"
    scrollable
  >
    <v-card v-if="registerPlayer">
      <v-btn
        icon
        @click="close"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
      <v-card-title
        class="pt-0 font-weight-bold justify-center text-h5"
      >
        選手情報登録
      </v-card-title>
      <v-divider />
      <v-card-text
        :style="$vuetify.breakpoint.mobile ? 'height: 450px' : ''"
      >
        <ValidationObserver
          ref="observer"
          v-slot="{ handleSubmit }"
        >
          <v-form ref="form">
            <v-container>
              <v-row>
                <!-- チーム選択 -->
                <v-col
                  class="mt-3"
                  cols="12"
                >
                  <span
                    class="font-weight-bold text-h6 black--text"
                  >
                    所属チーム
                  </span>
                  <br>
                  <span
                    class="font-weight-bold"
                    :style="$vuetify.breakpoint.mobile ? 'font-size: 10px;' : 'font-size: 12px;'"
                  >
                    ＊所属チームが見つからない場合は
                    <span
                      class="red--text"
                      style="cursor: pointer;"
                      @click="changeForm"
                    >
                      こちら
                    </span>
                    からチームを登録してください。
                  </span>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <v-select
                    v-model="prefecture"
                    outlined
                    dense
                    label="都道府県"
                    :items="prefectures"
                    item-value="id"
                    item-text="name"
                    background-color="#F2F4F8"
                  />
                </v-col>
                <v-col
                  v-if="prefecture"
                  cols="12"
                  class="pt-0"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="required"
                    name="チーム"
                    vid="team"
                  >
                    <v-autocomplete
                      v-model="profile.teamId"
                      no-data-text="チームが見つかりません"
                      outlined
                      dense
                      required
                      label="チーム"
                      :items="filterTeams"
                      item-value="id"
                      item-text="name"
                      background-color="#F2F4F8"
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <!-- リーグ選択 -->
                <v-col
                  class="pt-0"
                  cols="12"
                >
                  <span
                    class="font-weight-bold text-h6 black--text"
                  >
                    所属リーグ
                  </span>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <v-select
                    v-model="league"
                    outlined
                    dense
                    label="リーグ"
                    :items="leagues"
                    item-value="id"
                    item-text="name"
                    background-color="#F2F4F8"
                    @click="category = ''"
                  />
                </v-col>
                <v-col
                  v-if="league"
                  cols="12"
                  class="pt-0"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="required"
                    name="カテゴリ"
                    vid="group"
                  >
                    <v-select
                      v-model="category"
                      outlined
                      dense
                      required
                      label="カテゴリ"
                      :items="filterCategories"
                      item-value="id"
                      item-text="name"
                      background-color="#F2F4F8"
                      :error-messages="errors"
                      @change="setGroupId"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  v-if="category && filterGroups.length !== 1"
                  cols="12"
                  class="pt-0"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="required"
                    name="グループ"
                    vid="group"
                  >
                    <v-select
                      v-model="profile.groupId"
                      outlined
                      dense
                      required
                      label="グループ"
                      :items="filterGroups"
                      item-value="id"
                      item-text="name"
                      background-color="#F2F4F8"
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <!-- ポジション選択 -->
                <v-col
                  class="pt-0"
                  cols="12"
                >
                  <span
                    class="font-weight-bold text-h6 black--text"
                  >
                    ポジション
                  </span>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="required"
                    name="ポジション"
                    vid="position"
                  >
                    <v-select
                      v-model="profile.position"
                      background-color="#F2F4F8"
                      outlined
                      dense
                      required
                      label="ポジション"
                      :items="positions"
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <!-- 背番号 -->
                <v-col
                  class="pt-0"
                  cols="12"
                >
                  <span
                    class="font-weight-bold text-h6 black--text"
                  >
                    背番号

                  </span>
                  <br>
                  <span class="font-weight-bold text-caption">＊公式戦・練習試合で分れている場合は両方入力して下さい。</span>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="required|numeric"
                    name="公式戦"
                    vid="official_number"
                  >
                    <v-text-field
                      v-model="profile.officialNumber"
                      label="公式戦"
                      background-color="#F2F4F8"
                      outlined
                      dense
                      required
                      hint="公式戦での背番号を入力して下さい"
                      persistent-hint
                      type="number"
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <ValidationProvider
                    rules="numeric"
                    name="練習試合"
                    vid="practice_number"
                  >
                    <v-text-field
                      v-model="profile.practiceNumber"
                      label="練習試合"
                      outlined
                      dense
                      hint="練習試合での背番号を入力して下さい"
                      persistent-hint
                      type="number"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <v-btn
                    color="#3949AB"
                    class="font-weight-bold"
                    large
                    dark
                    block
                    depressed
                    @click="handleSubmit(clickRegister)"
                  >
                    登録する
                  </v-btn>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </ValidationObserver>
      </v-card-text>
    </v-card>
    <the-player-dialog-team
      v-if="registerTeam"
      :prefectures="prefectures"
      @click-back="changeForm"
      @create-team="pushTeam"
    />
  </v-dialog>
</template>

<script>
import ThePlayerDialogTeam from "./ThePlayerDialogTeam"

export default {
  components : {
    ThePlayerDialogTeam
  },
  data() {
    return {
      dialog: false,
      registerTeam: false,
      registerPlayer: false,
      leagues: [],
      prefectures: [],
      profile: {
        position: "",
        officialNumber: "",
        practiceNunmber: "",
        groupId: "",
        teamId: "",
      },
      league: "",
      category: "",
      prefecture: "",
      positions: [ "GK", "DF", "MF", "FW" ]
    }
  },
  computed: {
    filterCategories() {
      return this.leagues.find(league => {
        return league.id === this.league
      }).categories
    },
    filterGroups() {
      return this.filterCategories.find(category => {
        return category.id === this.category
      }).groups
    },
    filterTeams() {
      return this.prefectures.find(prefecture => {
        return prefecture.id === this.prefecture
      }).teams
    }
  },
  watch: {
    dialog(value) {
      if (value) {
        this.getLeagueData()
        this.getPrefectureTeamData()
      }
    }
  },
  methods: {
    open() {
      this.registerPlayer = true
      this.dialog = true
    },
    close() {
      this.$refs.observer.reset()
      this.$refs.form.reset()
      this.dialog = false
    },
    changeForm() {
      this.registerPlayer = !this.registerPlayer
      this.registerTeam = !this.registerTeam
    },
    pushTeam(team) {
      this.prefectures.find(prefecture => {
        return prefecture.id === team.prefectureId
      }).teams.push(team)
      this.changeForm()
    },
    setGroupId() {
      if (this.filterGroups.length === 1) {
        this.profile.groupId = this.filterGroups[0].id
      }
    },
    clickRegister() {
      this.$emit("click-register", this.profile)
    },
    setErrors(errors) {
      this.$refs.observer.setErrors(errors)
    },
    async getLeagueData() {
      const response = await this.$axios.get("/api/v1/leagues")
      this.leagues = response.data
    },
    async getPrefectureTeamData() {
      const response = await this.$axios.get("/api/v1/prefecture_teams")
      this.prefectures = response.data
    },
  }
}
</script>