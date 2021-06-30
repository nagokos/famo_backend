<template>
  <div>
    <ValidationProvider
      v-slot="{ errors }"
      rules="required"
      name="都道府県"
      vid="team"
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
        @click="$emit('update:teamId', '')"
      />
    </ValidationProvider>
    <ValidationProvider
      v-if="prefectureId"
      v-slot="{ errors }"
      rules="required"
      name="チーム"
      vid="team"
    >
      <v-autocomplete
        :value="teamId"
        class="mt-1"
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
        @change="$emit('update:teamId', $event)"
      />
    </ValidationProvider>
    <team-register-dialog
      ref="teamRegisterDialog"
      :prefectures="prefectures"
      @create-team="pushTeam"
    />
  </v-col>
</template>

<script>
import TeamRegisterDialog from "./TeamRegisterDialog"

export default {
  components: {
    TeamRegisterDialog
  },
  props: {
    prefecture: {
      type: Number,
      default: 0,
      required: true
    },
    teamId: {
      type: [Number, String],
      default: 0,
      required: true
    },
  },
  data() {
    return {
      loading: false,
      prefectures: [],
      prefectureId: this.prefecture
    }
  },
  computed: {
    filterTeams() {
      return this.prefectures.find(prefecture => {
        return prefecture.id === this.prefectureId
      }).teams
    }
  },
  created() {
    this.getPrefectureTeamData()
  },
  methods: {
    pushTeam(team) {
      this.prefectures.find(prefecture => {
        return prefecture.id === team.prefectureId
      }).teams.push(team)
    },
    async getPrefectureTeamData() {
      const response = await this.$axios.get("/api/v1/prefecture_teams")
      this.loading = true
      this.prefectures = response.data
    }
  }
}
</script>