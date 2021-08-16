<template>
  <v-card outlined>
    <v-simple-table dense>
      <tbody v-if="profile">
        <tr
          v-for="data in playerData"
          :key="data.id"
        >
          <td class="pr-0">
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
      <tbody v-if="!profile">
        <tr
          v-for="data in reviewerData"
          :key="data.id"
        >
          <td
            class="pr-0"
            style="height: 37px;"
          >
            <span
              class="font-weight-bold text-caption"
            >
              {{ data.name }}
            </span>
          </td>
          <td
            align="end"
            class="pl-0"
          >
            <v-card-actions
              v-if="data.name === 'レビュー平均'"
              class="py-0 px-0"
            >
              <v-spacer />
              <v-rating
                style="position: relative; bottom: 1px; left: 3px;"
                color="orange"
                size="18"
                readonly
                :value="1"
                length="1"
              />
              <span
                class="font-weight-bold"
              >
                {{ data.information }}
              </span>
            </v-card-actions>
            <span
              v-else
              class="font-weight-bold"
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
    },
    reviews: {
      type: Array,
      default: () => {},
      required: true
    },
    totalCount: {
      type: Number,
      default: 0,
      required: true
    },
    average: {
      type: Number,
      default: 0,
      required: true
    }
  },
  computed: {
    playerData() {
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
    reviewerData() {
      return [
        {
          name: "レビュー数",
          information: this.reviewCount
        },
        {
          name: "レビュー平均",
          information: this.average
        }
      ]
    },
    teamName() {
      return `${this.profile.team}(${this.profile.prefecture.name})`
    },
    leagueName() {
      if (this.profile.group) {
        return `${this.profile.league.name}${this.profile.category.name}(${this.profile.group})`
      } else {
        return `${this.profile.league.name}${this.profile.category.name}`
      }
    },
    careerName() {
      if (this.profile.career) {
        return this.profile.career
      } else {
        return "前所属はありません"
      }
    },
    positionAndUniform() {
      if (this.profile.practiceNumber) {
        return `${this.profile.position} / 公式戦${this.profile.officialNumber} 練習${this.profile.practiceNumber}`
      } else {
        return `${this.profile.position} / ${this.profile.officialNumber}`
      }
    },
    reviewCount() {
      return `${this.totalCount}件`
    },
    reviewAverage() {
      if (this.reviews.length === 0) return 0
      const rateArray = this.reviews.map(review => +review.rate)
      const sumRate = rateArray.reduce((rate, currentRate) => {
        return rate + currentRate
      })
      const rateAverage = sumRate / this.reviews.length
      return Math.round(rateAverage * 10) / 10
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
