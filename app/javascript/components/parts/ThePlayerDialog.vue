<template>
  <div>
    <v-dialog
      v-model="dialog"
      width="550"
      :persistent="true"
      scrollable
    >
      <v-card>
        <v-btn
          icon
          @click="close"
        >
          <v-icon>
            mdi-close
          </v-icon>
        </v-btn>
        <v-card-title
          class="pt-0 pb-5 font-weight-bold justify-center text-h5"
        >
          選手情報登録
        </v-card-title>
        <v-divider />
        <v-card-text
          :style="$vuetify.breakpoint.mobile ? 'height: 430px' : ''"
        >
          <ValidationObserver
            ref="observer"
            v-slot="{ handleSubmit }"
          >
            <v-form
              ref="form"
            >
              <v-container>
                <v-row>
                  <!-- チーム選択 -->
                  <v-col
                    cols="12"
                    class="mt-5"
                  >
                    <span
                      class="font-weight-bold text-h6 black--text"
                    >
                      所属チーム
                    </span>
                    <br>
                    <span
                      class="text-caption font-weight-bold"
                    >
                      ＊所属チームが見つからない方は
                      <strong
                        class="red--text"
                        style="cursor: pointer;"
                        @click="$refs.registerTeam.open()"
                      >
                        こちら
                      </strong>
                      からチームを登録して下さい。
                    </span>
                  </v-col>
                  <v-col
                    cols="12"
                    class="pt-0"
                  >
                    <ValidationProvider
                      v-slot="{ errors }"
                      rules="required"
                      name="都道府県"
                    >
                      <v-select
                        v-model="prefectureId"
                        outlined
                        dense
                        label="都道府県"
                        :items="prefectures"
                        item-value="id"
                        item-text="name"
                        background-color="#F2F4F8"
                        :error-messages="errors"
                      />
                    </ValidationProvider>
                  </v-col>
                  <v-col
                    v-if="prefectureId"
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
                    <ValidationProvider
                      v-slot="{ errors }"
                      rules="required"
                      name="リーグ"
                    >
                      <v-select
                        v-model="leagueId"
                        outlined
                        dense
                        label="リーグ"
                        :items="leagues"
                        item-value="id"
                        item-text="name"
                        background-color="#F2F4F8"
                        :error-messages="errors"
                        @click="categoryId = 0"
                      />
                    </ValidationProvider>
                  </v-col>
                  <v-col
                    v-if="leagueId"
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
                        v-model="categoryId"
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
                    v-if="categoryId && filterGroups.length !== 1"
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
    </v-dialog>
    <team-register-dialog
      ref="registerTeam"
      :prefectures="prefectures"
      @create-team="pushTeam"
    />
  </div>
</template>

<script>
import TeamRegisterDialog from "./TeamRegisterDialog"

export default {
  components : {
    TeamRegisterDialog
  },
  data() {
    return {
      dialog: false,
      leagues: [],
      prefectures: [],
      positions: ["GK", "DF", "MF", "FW"],
      leagueId: "",
      categoryId: "",
      prefectureId: "",
      profile: {
        position: "",
        officialNumber: "",
        practiceNunmber: "",
        groupId: "",
        teamId: "",
      }
    }
  },
  computed: {
     filterTeams() {
      return this.prefectures.find(prefecture => {
        return prefecture.id === this.prefectureId
      }).teams
    },
    filterCategories() {
      return this.leagues.find(league => {
        return league.id === this.leagueId
      }).categories
    },
    filterGroups() {
      return this.filterCategories.find(category => {
        return category.id === this.categoryId
      }).groups
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
      this.dialog = true
    },
    close() {
      this.$refs.observer.reset()
      this.$refs.form.reset()
      this.dialog = false
    },
    pushTeam(team) {
      this.prefectures.find(prefecture => {
        return prefecture.id === team.prefectureId
      }).teams.push(team)
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