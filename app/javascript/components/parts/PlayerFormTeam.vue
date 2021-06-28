<template>
  <v-col cols="12">
    <span
      class="font-weight-bold text-h6 black--text"
    >
      所属チーム編集
    </span>
    <br>
    <span class="text-caption">チームを登録される方は <strong class="red--text">こちら</strong> をクリック</span>
    <v-select
      v-model="prefectureId"
      class="mt-4"
      outlined
      dense
      label="都道府県"
      :items="prefectures"
      item-value="id"
      item-text="name"
      background-color="#F2F4F8"
      @click="$emit('update:teamId', '')"
    />
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
        @change="$emit('update:teamId', $event)"
        :error-messages="errors"
      />
    </ValidationProvider>
  </v-col>
</template>

<script>
export default {
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
      prefectures: [],
      prefectureId: this.prefecture
    }
  },
  computed: {
    filterTeams() {
      if (this.prefectures.length !== 0) {
        return this.prefectures.find(prefecture => {
          return prefecture.id === this.prefectureId
        }).teams
      }
    }
  },
  created() {
    this.getPrefectureTeamData()
  },
  methods: {
    async getPrefectureTeamData() {
      const response = await this.$axios.get("/api/v1/prefecture_teams")
      this.prefectures = response.data
    }
  }
}
</script>