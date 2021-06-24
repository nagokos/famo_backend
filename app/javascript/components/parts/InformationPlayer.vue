<template>
  <v-col cols="12">
    <v-card
      elevation="1"
      outlined
      justify-space-between
    >
      <v-card-title
        v-if="!profile"
        class="font-weight-bold"
      >
        選手
        <v-spacer />
        <v-btn
          color="primary"
          text
          @click="$emit('click-player')"
        >
          選手情報を追加
        </v-btn>
      </v-card-title>
      <div
        v-for="data in profileData"
        v-else
        :key="data.id"
      >
        <v-card-title class="font-weight-bold">
          {{ data.name }}
          <v-spacer />
          <v-btn icon>
            <v-icon>
              mdi-pencil
            </v-icon>
          </v-btn>
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
  </v-col>
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