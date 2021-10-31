<template>
  <v-card
    outlined
    elevation="1"
  >
    <div
      v-for="data in profileData"
      :key="data.id"
    >
      <v-card-title class="font-weight-bold">
        {{ data.name }}
      </v-card-title>
      <v-card-text
        align="center"
        class="font-weight-bold"
        style="color: rgba(0,0,0,.6);"
      >
        {{ data.information }}
      </v-card-text>
    </div>
  </v-card>
</template>

<script>
export default {
  props: {
    profile: {
      type: Object,
      default: () => {},
      required: false
    }
  },
  computed: {
    profileData() {
      return [
        {
          name: "チーム",
          information: this.teamName
        },
        {
          name: "リーグ",
          information: this.leagueName
        },
        {
          name: "ポジション",
          information: this.profile.position
        },
        {
          name: "背番号",
          information: this.uniformNumber
        },
      ]
    },
    teamName() {
      return `${this.profile.team.name}(${this.profile.team.prefecture.name})`
    },
    leagueName() {
      if (this.profile.group.name) {
        return `${this.profile.group.category.league.name}${this.profile.group.category.name}${this.profile.group.name}`
      } else {
        return `${this.profile.group.category.league.name}${this.profile.group.category.name}`
      }
    },
    uniformNumber() {
      if (this.profile.practiceNumber) {
        return `公式戦${this.profile.officialNumber} 練習${this.profile.practiceNumber}`
      } else {
        return this.profile.officialNumber
      }
    }
  }
}
</script>