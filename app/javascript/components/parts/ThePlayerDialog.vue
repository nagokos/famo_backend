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
                        @click="$refs.registerTeamDialog.open()"
                      >
                        こちら
                      </strong>
                      からチームを登録して下さい。
                    </span>
                    <player-form-team
                      class="mt-3"
                      :prefectures="prefectures"
                      :prefecture="prefectureId"
                      :team-id.sync="profile.teamId"
                    />
                  </v-col>
                  <!-- リーグ選択 -->
                  <v-col
                    cols="12"
                    class="pt-0"
                  >
                    <span
                      class="font-weight-bold text-h6 black--text"
                    >
                      所属リーグ
                    </span>
                    <player-form-league
                      class="mt-2"
                      :leagues="leagues"
                      :league="leagueId"
                      :category="categoryId"
                      :group-id.sync="profile.groupId"
                    />
                  </v-col>
                  <!-- ポジション選択 -->
                  <v-col
                    cols="12"
                    class="pt-0"
                  >
                    <span
                      class="font-weight-bold text-h6 black--text"
                    >
                      ポジション
                    </span>
                    <player-form-position
                      class="mt-2"
                      :position.sync="profile.position"
                    />
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
                    <player-form-number
                      class="mt-2"
                      v-bind.sync="profile"
                    />
                  </v-col>
                  <v-col
                    cols="12"
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
    <register-team-dialog
      ref="registerTeamDialog"
      :prefectures="prefectures"
      @create-team="pushTeam"
    />
  </div>
</template>

<script>
import PlayerFormTeam from "./PlayerFormTeam"
import PlayerFormLeague from "./PlayerFormLeague"
import PlayerFormPosition from "./PlayerFormPosition"
import PlayerFormNumber from "./PlayerFormNumber"
import RegisterTeamDialog from "./RegisterTeamDialog"

export default {
  components : {
    PlayerFormTeam,
    PlayerFormLeague,
    PlayerFormPosition,
    PlayerFormNumber,
    RegisterTeamDialog
  },
  data() {
    return {
      dialog: false,
      leagues: [],
      prefectures: [],
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
      Object.assign(this.$data.profile, this.$options.data().profile)
      this.dialog = false
    },
    pushTeam(team) {
      this.prefectures.find(prefecture => {
        return prefecture.id === team.prefectureId
      }).teams.push(team)
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