<template>
  <v-card
    outlined
    elevation="1"
  >
    <ValidationObserver
      ref="observer"
      v-slot="{ invalid }"
    >
      <v-card-text class="pb-0">
        <v-container>
          <v-row>
            <!-- チーム -->
            <v-col
              v-if="loading && teamEdit"
              cols="12"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                所属チーム
              </span>
              <br>
              <span class="text-caption">
                チームを登録される方は
                <strong
                  class="red--text"
                  style="cursor: pointer;"
                  @click="dialog = true"
                >
                  こちら
                </strong>
                をクリック
              </span>
              <player-form-team
                class="mt-4"
                :prefectures="prefectures"
                :prefecture="prefecture"
                :team-id.sync="profileEdit.teamId"
              />
            </v-col>
            <!-- リーグ選択 -->
            <v-col
              v-if="loading && leagueEdit"
              cols="12"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                所属リーグ
              </span>
              <player-form-league
                v-if="leagueEdit"
                class="mt-3"
                :leagues="leagues"
                :league="league"
                :category="category"
                :group-id.sync="profileEdit.groupId"
              />
            </v-col>
            <!-- ポジション -->
            <v-col
              v-if="positionEdit"
              cols="12"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                ポジション
              </span>
              <player-form-position
                class="mt-3"
                :position.sync="profileEdit.position"
              />
            </v-col>
            <!-- 背番号 -->
            <v-col
              v-if="numberEdit"
              cols="12"
            >
              <span
                class="font-weight-bold text-h6 black--text"
              >
                背番号
              </span>
              <player-form-number
                class="mt-3"
                v-bind.sync="profileEdit"
              />
            </v-col>
            <!-- ローディング -->
            <v-col
              v-if="!loading && leagueEdit || !loading && teamEdit"
              align="center"
              cols="12"
            >
              <v-progress-circular
                indeterminate
                color="primary"
              />
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
      <v-card-actions class="pt-0">
        <v-spacer />
        <v-btn
          color="primary"
          text
          @click="$emit('click-cancel')"
        >
          キャンセル
        </v-btn>
        <v-btn
          color="primary"
          text
          :disabled="invalid"
          @click="$emit('click-update')"
        >
          更新
        </v-btn>
      </v-card-actions>
    </ValidationObserver>
    <register-team-dialog
      ref="registerTeamDialog"
      :prefectures="prefectures"
      @create-team="pushTeam"
    />
  </v-card>
</template>

<script>
import PlayerFormTeam from "./PlayerFormTeam"
import PlayerFormLeague from "./PlayerFormLeague"
import PlayerFormPosition from "./PlayerFormPosition"
import PlayerFormNumber from "./PlayerFormNumber"
import RegisterTeamDialog from "./RegisterTeamDialog"

export default {
  components: {
    PlayerFormTeam,
    PlayerFormLeague,
    PlayerFormPosition,
    PlayerFormNumber,
    RegisterTeamDialog
  },
  props: {
    profileEdit: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      dialog: false,
      loading: false,
      teamEdit: false,
      leagueEdit: false,
      positionEdit: false,
      numberEdit: false,
      prefectures: [],
      leagues: [],
    }
  },
  computed: {
    prefecture() {
      return this.profileEdit.team.prefecture.id
    },
    league() {
      return this.profileEdit.group.category.league.id
    },
    category() {
      return this.profileEdit.group.category.id
    }
  },
  methods: {
    change(name) {
      switch(name) {
      case "チーム":
        this.teamEdit = true
        this.getPrefectureTeamData()
        break
      case "リーグ":
        this.leagueEdit = true
        this.getLeagueData()
        break
      case "ポジション":
        this.positionEdit = true
        break
      case "背番号":
        this.numberEdit = true
        break
      }
    },
    pushTeam(team) {
      this.prefectures.find(prefecture => {
        return prefecture.id === team.prefectureId
      }).teams.push(team)
    },
    setErrors(errors) {
      this.$refs.observer.setErrors(errors)
    },
    async getLeagueData() {
      const response = await this.$axios.get("/api/v1/leagues")
      this.leagues = response.data
      this.loading = true
    },
    async getPrefectureTeamData() {
      const response = await this.$axios.get("/api/v1/prefecture_teams")
      this.prefectures = response.data
      this.loading = true
    },
  }
}
</script>