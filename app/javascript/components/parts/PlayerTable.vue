<template>
  <v-card
    outlined
  >
    <v-simple-table
      dense
    >
      <tbody>
        <tr
          v-for="data in profileData"
          :key="data.id"
        >
          <td
            class="pr-0"
          >
            <span
              class="font-weight-bold"
              style="font-size: 10px"
            >
              {{ data.name }}
            </span>
          </td>
          <td
            align="end"
            class="pl-0"
          >
            <span
              class="font-weight-bold"
              style="font-size: 10px"
            >
              {{ data.information }}
            </span>
          </td>
        </tr>
      </tbody>
    </v-simple-table>
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
          name: "ポジション・背番号",
          information: this.positionAndUniform
        },
        {
          name: "前所属",
          information: this.careerName
        }
      ]
    },
    teamName() {
      return `${this.profile.team.name}(${this.profile.team.prefecture.name})`
    },
    leagueName() {
      if (this.profile.group.name) {
        return `${this.profile.group.category.league.name}${this.profile.group.category.name}(${this.profile.group.name})`
      } else {
        return `${this.profile.group.category.league.name}${this.profile.group.category.name}`
      }
    },
    careerName() {
      if (this.profile.career) {
        return this.profile.career
      } else {
        return "所属はありません"
      }
    },
    positionAndUniform() {
      if (this.profile.practiceNumber) {
        return `${this.profile.position} / 公式戦${this.profile.officialNumber} 練習${this.profile.practiceNumber}`
      } else {
        return this.profile.officialNumber
      }
    }
  },
}
</script>

<style scoped>
  .v-data-table
    tbody
    tr:hover:not(.v-data-table__expanded__content) {
    background: #ffffff !important;
  }
</style>
