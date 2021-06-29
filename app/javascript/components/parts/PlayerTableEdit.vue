<template>
  <ValidationObserver
    ref="observer"
    v-slot="{ invalid }"
  >
    <v-card-text class="pb-0">
      <v-container>
        <v-row>
          <player-form-team
            v-if="teamEdit"
            :prefecture="prefecture"
            :team-id.sync="profileEdit.teamId"
          />
          <player-form-league
            v-if="leagueEdit"
            :league="league"
            :category="category"
            :group-id.sync="profileEdit.groupId"
          />
          <player-form-position
            v-if="positionEdit"
            :position.sync="profileEdit.position"
          />
          <player-form-number
            v-if="numberEdit"
            v-bind.sync="profileEdit"
          />
        </v-row>
      </v-container>
    </v-card-text>
    <v-card-actions class="pt-0">
      <v-spacer />
      <v-btn
        color="primary"
        text
        @click="clickCancel"
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
</template>

<script>
import PlayerFormTeam from "./PlayerFormTeam"
import PlayerFormLeague from "./PlayerFormLeague"
import PlayerFormPosition from "./PlayerFormPosition"
import PlayerFormNumber from "./PlayerFormNumber"

export default {
  components: {
    PlayerFormTeam,
    PlayerFormLeague,
    PlayerFormPosition,
    PlayerFormNumber
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
      teamEdit: false,
      leagueEdit: false,
      positionEdit: false,
      numberEdit: false,
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
        break
      case "リーグ":
        this.leagueEdit = true
        break
      case "ポジション":
        this.positionEdit = true
        break
      case "背番号":
        this.numberEdit = true
        break
      }
    },
    clickCancel() {
      this.$emit("click-cancel")
    },
    clickUpdate() {
      this.$emit("click-update")
    },
    setErrors(errors) {
      this.$refs.observer.setErrors(errors)
    }
  }
}
</script>