<template>
  <v-dialog v-model="dialog" fullscreen transition="dialog-bottom-transition">
    <v-card>
      <v-btn icon :ripple="false" @click="dialog = false">
        <v-icon> mdi-close </v-icon>
      </v-btn>
      <v-list two-line>
        <v-list-item>
          <v-list-item-icon>
            <v-icon color="#3949AB"> mdi-account </v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title class="text-subtitle-2">
              名前
            </v-list-item-title>
            <v-list-item-subtitle class="mt-1 text-caption">
              {{ user.name }}
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
        <v-divider inset />
        <template v-if="user.role === 'player'">
          <v-list-item v-for="data in areaData" :key="data.title">
            <v-list-item-icon>
              <v-icon color="#3949AB">
                {{ data.icon }}
              </v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title class="text-subtitle-2">
                {{ data.title }}
              </v-list-item-title>
              <v-list-item-subtitle class="mt-1 text-caption">
                {{ data.value }}
              </v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
          <v-divider inset />
          <v-list-item v-for="data in playerData" :key="data.title">
            <v-list-item-icon>
              <v-icon color="#3949AB">
                {{ data.icon }}
              </v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title class="text-subtitle-2">
                {{ data.title }}
              </v-list-item-title>
              <v-list-item-subtitle class="mt-1 text-caption">
                {{ data.value }}
              </v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </template>
        <v-list-item v-for="data in reviewerData" v-else :key="data.title">
          <v-list-item-icon>
            <v-icon color="#3949AB">
              {{ data.icon }}
            </v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title class="text-subtitle-2">
              {{ data.title }}
            </v-list-item-title>
            <v-list-item-subtitle class="mt-1 text-caption">
              <span v-if="data.title !== 'レビュー平均'">{{ data.value }}</span>
              <div v-else>
                <v-icon
                  color="orange"
                  x-small
                  style="position: relative; bottom: 1px"
                >
                  mdi-star
                </v-icon>
                <span class="mt-1">
                  {{ data.value }}
                </span>
              </div>
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true,
    },
    totalCount: {
      type: Number,
      default: 0,
      required: true,
    },
    average: {
      type: Number,
      default: 0,
      required: true,
    },
  },
  data() {
    return {
      dialog: false,
    };
  },
  computed: {
    reviewerData() {
      return [
        {
          icon: "mdi-comment-processing",
          title: "レビュー数",
          value: this.reviewCount,
        },
        {
          title: "レビュー平均",
          value: this.average.toFixed(1),
        },
      ];
    },
    areaData() {
      return [
        {
          icon: "mdi-map-marker",
          title: "所属チーム",
          value: this.teamName,
        },
        {
          title: "所属リーグ",
          value: this.leagueName,
        },
        {
          title: "前所属",
          value: this.careerName,
        },
      ];
    },
    playerData() {
      return [
        {
          icon: "mdi-soccer",
          title: "背番号",
          value: this.uniformNumber,
        },
        {
          title: "ポジション",
          value: this.user.profile.position,
        },
      ];
    },
    teamName() {
      return `${this.user.profile.team}(${this.user.profile.prefecture.name})`;
    },
    leagueName() {
      if (this.user.profile.group) {
        return `${this.user.profile.league.name}${this.user.profile.category.name}(${this.user.profile.group})`;
      } else {
        return `${this.user.profile.league.name}${this.user.profile.category.name}`;
      }
    },
    careerName() {
      if (this.user.profile.career) {
        return this.user.profile.career;
      } else {
        return "前所属はありません";
      }
    },
    uniformNumber() {
      if (this.user.profile.practiceNumber) {
        return `公式戦${this.user.profile.officialNumber} 練習${this.user.profile.practiceNumber}`;
      } else {
        return this.user.profile.officialNumber;
      }
    },
    reviewCount() {
      return `${this.totalCount}件`;
    },
  },
  methods: {
    open() {
      this.dialog = true;
    },
  },
};
</script>
