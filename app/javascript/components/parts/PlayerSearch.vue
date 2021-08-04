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
            {{ league.name }}
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
                outlined
                small
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
      v-model="position"
      class="mt-5"
      background-color="white"
      outlined
      dense
      :items="positions"
      item-text="name"
      item-value="value"
      style="max-width: 300px;"
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
      v-model="team"
      class="mt-5"
      background-color="white"
      outlined
      dense
      :items="teams"
      item-value="id"
      item-text="name"
      no-data-text="選択できるチームがありません"
      style="max-width: 300px;"
    />
    <v-btn
      width="300"
      large
      :ripple="false"
      color="#3949AB"
      dark
      class="font-weight-bold mt-3"
      @click="searchPlayer"
    >
      検索する
    </v-btn>
  </v-col>
</template>

<script>
import Transform from "../../packs/league-transform"

export default {
  props: {
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
      position: 10,
      team: 0,
      positions: [
        {
          name: "指定なし",
          value: 10
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
    searchPlayer() {
      this.$emit("search-player", this.position, this,team)
    },
    pushLeague(league) {
      if (!this.$route.params.categoryId && !this.$route.params.groupId) {
        const leagueEigo = Transform.leagueNameEigo(league.name)
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