<template>
  <v-col
    v-if="!$vuetify.breakpoint.mobile"
    cols="12"
    lg="4"
  >
    <v-card
      width="300"
      outlined
    >
      <v-card-text class="mt-2">
        <v-icon color="primary">
          mdi-map-marker
        </v-icon>
        <span
          class="font-weight-bold black--text"
          style="position: relative; top: 2px;"
        >
          リーグから探す
        </span>
      </v-card-text>
      <v-menu
        v-model="menu"
        :close-on-content-click="false"
        :nudge-width="200"
        offset-x
      >
        <template #activator="{ on, attrs }">
          <v-card-actions
            class="font-weight-bold text-subtitle-1 blue--text text--darken-2 py-0 ml-1 pl-4"
            style="cursor: pointer;"
            v-bind="attrs"
            v-on="on"
          >
            {{ isWhole ? "全国" : league.name }}
            <v-spacer />
            <v-icon>
              mdi-chevron-right
            </v-icon>
          </v-card-actions>
        </template>
        <v-card
          color="#FAFAFA"
          max-width="500"
        >
          <v-card-text>
            <v-chip-group
              column
            >
              <v-chip
                v-if="!isWhole"
                outlined
                small
                to="/whole"
              >
                全国
              </v-chip>
              <v-chip
                v-for="filterLeague in filterLeagues"
                :key="filterLeague.id"
                small
                :ripple="false"
                outlined
                @click="pushLeague(filterLeague)"
              >
                {{ filterLeague.name }}
              </v-chip>
            </v-chip-group>
          </v-card-text>
        </v-card>
      </v-menu>
      <v-card-text class="py-0">
        <v-divider />
      </v-card-text>
      <v-card-text class="pt-2">
        <v-chip-group
          column
        >
          <v-chip
            v-for="child in leagueChild"
            :key="child.id"
            small
            :ripple="false"
            outlined
            @click="pushChildPage(child)"
          >
            {{ child.name }}
          </v-chip>
        </v-chip-group>
      </v-card-text>
    </v-card>
    <v-card
      color="#f1f4f8"
      width="300"
      class="mt-8"
      outlined
    >
      <v-card-text>
        <v-icon color="primary">
          mdi-soccer-field
        </v-icon>
        <span
          class="font-weight-bold black--text"
          style="position: relative; top: 2px;"
        >
          ポジション
        </span>
      </v-card-text>
    </v-card>
    <v-select
      :value="position"
      class="mt-5"
      background-color="white"
      outlined
      dense
      :items="positions"
      item-text="name"
      item-value="value"
      style="max-width: 300px;"
      @change="$emit('update:position', $event)"
    />
    <v-card
      color="#f1f4f8"
      width="300"
      class="mt-2"
      outlined
    >
      <v-card-text>
        <v-icon color="primary">
          mdi-soccer
        </v-icon>
        <span
          class="font-weight-bold black--text"
          style="position: relative; top: 1px;"
        >
          チーム
        </span>
      </v-card-text>
    </v-card>
    <v-select
      :value="teamId"
      class="mt-5"
      background-color="white"
      outlined
      dense
      :items="teams"
      item-value="id"
      item-text="name"
      no-data-text="選択できるチームがありません"
      style="max-width: 300px;"
      @change="$emit('update:teamId', $event)"
    />
    <v-btn
      width="50"
      large
      :ripple="false"
      class="font-weight-bold mt-3 text-caption"
      @click="resetSearch"
    >
      リセット
    </v-btn>
    <v-btn
      width="210"
      large
      :ripple="false"
      color="#3949AB"
      dark
      class="font-weight-bold mt-3 text-caption ml-2"
      @click="searchPlayer"
    >
      検索する
    </v-btn>
  </v-col>
</template>

<script>
export default {
  props: {
    teamId: {
      type: [String, Number],
      default: () => {},
      required: true
    },
    position: {
      type: [String, Number],
      default: () => {},
      required: true
    },
    league: {
      type: Object,
      default: () => {},
      required: true
    },
    teams: {
      type: Array,
      default: () => {},
      required: true
    },
    leagues: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      menu: false,
      positions: [
        {
          name: "指定なし",
          value: ""
        },
        {
          name: "GK",
          value: 0
        },
        {
          name: "DF",
          value: 1
        },
        {
          name: "MF",
          value: 2
        },
        {
          name: "FW",
          value: 3
        }
      ]
    }
  },
  computed: {
    isWhole() {
      return this.$route.path.includes('/whole')
    },
    filterLeagues() {
      return this.leagues.filter(league => {
        return league.id !== this.league.id
      })
    },
    leagueChild() {
      if (!this.$route.params.categoryId && !this.$route.params.groupId) {
        return this.league.categories
      } else if (!this.$route.params.groupId && this.league.groups.length >= 2) {
        return this.league.groups
      } else {
        return false
      }
    },
  },
  methods: {
    resetSearch() {
      this.$emit("update:position", "")
      this.$emit("update:teamId", "")
    },
    searchPlayer() {
      delete this.$route.query.page
      let team = this.teams.find(team => team.id === this.teamId)
      if (team.name === "指定なし") team = ""
      let position = this.positions.find(position => position.value === this.position)
      if (position.name === "指定なし") position = ""
      this.$router.push({ name: this.$route.name, query: { team: team.name, position: position.name, page: undefined } }, () => {})
    },
    pushLeague(league) {
      this.resetSearch()
      if (!this.$route.params.categoryId && !this.$route.params.groupId) {
        const leagueEigo = this.leagueNameEigo(league.name)
        this.$router.push({ name: "leaguePlayer", params: { league: leagueEigo } })
      } else if (!this.$route.params.groupId) {
        this.$router.push({ name: "categoryPlayer", params: { categoryId: league.id } })
      } else {
        this.$router.push({ name: "groupPlayer", params: { groupId: league.id } })
      }
      this.menu = false
    },
    pushChildPage(child) {
      if (!this.$route.params.categoryId) {
        this.$router.push({ name: "categoryPlayer", params: { categoryId: child.id } })
      } else {
        this.$router.push({ name: "groupPlayer", params: { groupId: child.id } })
      }
    }
  }
}
</script>