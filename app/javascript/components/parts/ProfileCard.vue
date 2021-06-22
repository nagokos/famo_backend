<template>
  <v-col
    lg="4"
  >
    <v-card
      outlined
    >
      <v-simple-table dense>
        <tbody>
          <v-col
            v-if="!profile"
            align="center"
          >
            <v-btn
              right
              text
              color="primary"
              @click="$emit('click-player')"
            >
              選手情報追加
            </v-btn>
          </v-col>
          <tr
            v-for="data in profileData"
            v-else
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
            <td
              class="px-0"
            >
              <v-btn
                x-small
                icon
              >
                <v-icon
                  x-small
                >
                  mdi-pencil
                </v-icon>
              </v-btn>
            </td>
          </tr>
        </tbody>
      </v-simple-table>
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
        return `公式戦${this.profile.officialNumber}、 練習${this.profile.practiceNumber}`
      } else {
        return this.profile.officialNumber
      }
    }
  }
}
</script>

<style scoped>
  .v-data-table
    tbody
    tr:hover:not(.v-data-table__expanded__content) {
    background: #ffffff !important;
  }
</style>