<template>
  <div>
    <ValidationObserver
      v-if="loading"
      ref="observer"
      v-slot="{ handleSubmit }"
    >
      <v-form>
        <v-container>
          <v-row>
            <!-- チーム選択 -->
            <v-col
              cols="12"
              class="pt-2"
            >
              <span
                class="font-weight-bold grey--text text--darken-1"
                :style="$vuetify.breakpoint.mobile ? 'font-size: 10px;' : 'font-size: 12px;'"
              >
                選手登録をすることで評価を受けられるようになります(高校生のみ登録可能)
                <br>
                所属チームが見つからない場合はチームを登録してください
              </span>
            </v-col>
            <v-col
              cols="12"
              md="4"
              class="pt-1 pb-0"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                所属チーム
              </span>
              <div class="mt-1 mb-1">
                <v-btn
                  class="font-weight-bold"
                  width="100"
                  height="35"
                  small
                  :ripple="false"
                  @click="$refs.registerTeamDialog.open()"
                >
                  チーム登録
                </v-btn>
              </div>
            </v-col>
            <v-col
              cols="12"
              md="8"
              class="py-0"
            >
              <player-form-team
                class="mt-3"
                :prefectures="prefectures"
                :prefecture="profile.prefecture.id"
                :team-id.sync="profile.teamId"
              />
            </v-col>
            <!-- リーグ選択 -->
            <v-col
              cols="12"
              md="4"
              class="pt-1 pb-0"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                所属リーグ
              </span>
            </v-col>
            <v-col
              cols="12"
              md="8"
              class="py-0"
            >
              <player-form-league
                class="mt-2"
                :leagues="leagues"
                :league="profile.league.id"
                :category="profile.category.id"
                :group-id.sync="profile.groupId"
              />
            </v-col>
            <v-col
              class="pt-1 pb-0"
              cols="12"
              md="4"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                前所属
              </span>
            </v-col>
            <v-col
              class="py-0"
              cols="12"
              md="8"
            >
              <player-form-career
                class="mt-2"
                :career.sync="profile.career"
              />
            </v-col>
            <!-- ポジション選択 -->
            <v-col
              cols="12"
              md="4"
              class="pt-1 pb-0"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                ポジション
              </span>
            </v-col>
            <v-col
              cols="12"
              md="8"
              class="py-0"
            >
              <player-form-position
                class="mt-2"
                :position.sync="profile.position"
              />
            </v-col>
            <!-- 背番号 -->
            <v-col
              class="pt-1 pb-0"
              cols="12"
              md="4"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                背番号
              </span>
            </v-col>
            <v-col
              class="py-0"
              cols="12"
              md="8"
            >
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
                :ripple="false"
                @click="handleSubmit(sendPlayerData)"
              >
                {{ user.profile ? "更新する" : "登録する" }}
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </ValidationObserver>
    <the-team-register-dialog
      ref="registerTeamDialog"
      :prefectures="prefectures"
      @create-team="pushTeam"
    />
    <v-col
      v-if="!loading"
      cols="12"
      align="center"
    >
      <v-progress-circular
        indeterminate
        color="primary"
      />
    </v-col>
  </div>
</template>

<script>
import PlayerFormTeam from "./PlayerFormTeam"
import PlayerFormLeague from "./PlayerFormLeague"
import PlayerFormPosition from "./PlayerFormPosition"
import PlayerFormNumber from "./PlayerFormNumber"
import PlayerFormCareer from "./PlayerFormCareer"
import TheTeamRegisterDialog from "./TheTeamRegisterDialog"

export default {
  components : {
    PlayerFormTeam,
    PlayerFormLeague,
    PlayerFormPosition,
    PlayerFormNumber,
    PlayerFormCareer,
    TheTeamRegisterDialog
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true,
    }
  },
  data() {
    return {
      loading: false,
      leagues: [],
      prefectures: [],
      profile: {
        position: "",
        officialNumber: "",
        practiceNumber: "",
        career: "",
        teamId: "",
        team: "",
        groupId: "",
        group: "",
        prefecture: {
          id: ""
        },
        category: {
          id: ""
        },
        league: {
          id: ""
        }
      },
    }
  },
  created() {
    this.setData()
    this.serProfile()
  },
  methods: {
    pushTeam(team) {
      this.prefectures.find(prefecture => {
        return prefecture.id === team.prefectureId
      }).teams.push(team)
      this.$refs.registerTeamDialog.close()
    },
    serProfile() {
      if (this.user.profile) {
        this.profile = this.user.profile
      }
    },
    async setData() {
      await this.getLeagueData()
      await this.getPrefectureTeamData()
      this.loading = true
    },
    async getLeagueData() {
      const response = await this.$axios.get("/api/v1/leagues")
      this.leagues = response.data.leagues
    },
    async getPrefectureTeamData() {
      const response = await this.$axios.get("/api/v1/prefecture_teams")
      this.prefectures = response.data.prefectures
    },
    async sendPlayerData() {
      try {
        if (this.user.role !== "player") {
          const response = await this.$axios.post("/api/v1/profile", {
            profile: this.profile
          })
          await this.$store.dispatch("flash/setFlash", {
            type: "success",
            message: "登録しました"
          })
          this.profile = response.data.profile
          this.$emit('fetch-user')
        } else {
          const response = await this.$axios.patch("/api/v1/profile", {
            profile: this.profile
          })
          await this.$store.dispatch("flash/setFlash", {
            type: "success",
            message: "更新しました"
          })
          this.profile = response.data.profile
        }
      } catch(err) {
        await this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "フォームに不備があります"
        })
        this.$refs.observer.setErrors(err.response.data.errors)
      }
    },
  }
}
</script>