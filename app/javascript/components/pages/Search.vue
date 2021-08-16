<template>
  <div
    v-if="loading"
    class="search mx-auto mt-6"
  >
    <v-container>
      <v-row>
        <v-col cols="12">
          <v-sheet
            :color="$vuetify.breakpoint.mobile ? '#FAFAFA' : 'white'"
            rounded
            class="rounded-xl"
          >
            <v-container style="max-width: 400px;">
              <v-row>
                <v-col
                  align="center"
                  class="font-weight-bold text-h5 mt-4"
                  cols="12"
                >
                  選手検索
                </v-col>
                <v-col
                  cols="12"
                  class="pb-0 font-weight-bold text-subtitle-1"
                >
                  リーグ
                </v-col>
                <v-col
                  class="py-0"
                  cols="12"
                >
                  <v-select
                    v-model="q.leagueId"
                    outlined
                    :items="leagues"
                    item-value="id"
                    item-text="name"
                    dense
                    @click="resetId"
                  />
                </v-col>
                <v-col
                  cols="12"
                  class="py-0 font-weight-bold text-subtitle-1"
                >
                  カテゴリ
                </v-col>
                <v-col
                  class="py-0"
                  cols="12"
                >
                  <v-select
                    v-model="q.categoryId"
                    outlined
                    :items="filterCategories"
                    item-value="id"
                    item-text="name"
                    dense
                    no-data-text="表示できるカテゴリがありません"
                    @click="group = ''"
                  />
                </v-col>
                <v-col
                  cols="12"
                  class="py-0 font-weight-bold text-subtitle-1"
                >
                  グループ
                </v-col>
                <v-col
                  class="py-0"
                  cols="12"
                >
                  <v-select
                    v-model="q.groupId"
                    outlined
                    :items="filterGroups"
                    item-value="id"
                    item-text="name"
                    dense
                    no-data-text="表示できるグループがありません"
                  />
                </v-col>
                <v-col
                  cols="12"
                  class="py-0"
                >
                  <span
                    class="blue--text text--darken-2"
                    style="cursor: pointer;"
                    @click="deepSearch = !deepSearch"
                  >{{ deepSearch ? '閉じる' : '絞り込み' }}</span>
                </v-col>
                <template v-if="deepSearch">
                  <v-col
                    class="font-weight-bold pb-1"
                    cols="12"
                  >
                    ポジション
                  </v-col>
                  <v-col
                    class="py-0"
                    cols="12"
                  >
                    <v-select
                      v-model="q.position"
                      outlined
                      dense
                      :items="positions"
                      item-text="name"
                      item-value="value"
                    />
                  </v-col>
                  <v-col
                    class="font-weight-bold pt-0 pb-1"
                    cols="12"
                  >
                    チーム
                  </v-col>
                  <v-col
                    class="py-0"
                    cols="12"
                  >
                    <v-autocomplete
                      v-model="q.team"
                      outlined
                      dense
                      :items="teams"
                      item-text="name"
                      item-value="name"
                      persistent-hint
                      hint="※ チームを指定すると全国での表示になります"
                    />
                  </v-col>
                </template>
                <v-col
                  class="pt-1"
                  cols="12"
                >
                  <v-btn
                    class="font-weight-bold mb-8"
                    large
                    dark
                    color="#3949AB"
                    block
                    :ripple="false"
                    @click="pushSearchPage"
                  >
                    検索する
                  </v-btn>
                </v-col>
              </v-row>
            </v-container>
          </v-sheet>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      deepSearch: false,
      leagues: [],
      teams: [],
      q: {
        leagueId: "",
        categoryId: "",
        groupId: "",
        position: "指定なし",
        team: "指定なし"
      },
      loading: false,
      positions: [
        { name: "指定なし"},
        { name: "GK" },
        { name: "DF" },
        { name: "MF" },
        { name: "FW" }
      ]
    }
  },
  computed: {
    filterCategories() {
      let categories = []
      const unspecified = { name: "指定なし", id: "" }
      categories.push(unspecified)
      if (!this.q.leagueId || !this.loading) return categories
      const findCategories = this.leagues.find(league => {
        return league.id === this.q.leagueId
      }).categories
      findCategories.forEach(category => categories.push(category))
      return categories
    },
    filterGroups() {
      let groups = []
      const unspecified = { name: "指定なし", id: "" }
      groups.push(unspecified)
      if (!this.q.categoryId || !this.loading) return groups
      const findGroups = this.filterCategories.find(category => {
        return category.id === this.q.categoryId
      }).groups
      findGroups.forEach(category => groups.push(category))
      if (groups.length === 2) groups.splice(0)
      const notGroup = { name: "グループはありません", id: "" }
      groups.push(notGroup)
      return groups
    },
  },
  created() {
    this.setData()
  },
  methods: {
    async setData() {
      await this.getLeagueData()
      await this.setLeagueUnspecified()
      await this.getTeams()
      await this.setTeamUnspecified()
      this.loading = true
    },
    resetId() {
      this.q.groupId = ""
      this.q.categoryId = ""
    },
    setLeagueData() {
      const unspecified = { name: "指定なし", id: "" }
      this.leagues.unshift(unspecified)
    },
    pushSearchPage() {
      if (!this.q.leagueId && !this.q.categoryId && !this.q.groupId) {
        this.$router.push({ name: 'wholePlayer', params: { q: this.q } })
      } else if (this.q.leagueId && !this.q.categoryId && !this.q.groupId) {
        const league = this.leagues.find(league => league.id === this.q.leagueId)
        const leagueEigo = this.leagueNameEigo(league.name)
        this.$router.push({ name: "leaguePlayer", params: { league: leagueEigo, search: this.q } })
      } else if (this.q.leagueId && this.q.categoryId && !this.q.groupId) {
        const league = this.leagues.find(league => league.id === this.q.leagueId).name
        const leagueEigo = this.leagueNameEigo(league)
        this.$router.push({ name: "categoryPlayer", params: { league: leagueEigo, categoryId: this.q.categoryId, search: this.q } })
      } else {
        const league = this.leagues.find(league => league.id === this.q.leagueId).name
        const leagueEigo = this.leagueNameEigo(league)
        this.$router.push({ name: "groupPlayer", params: { league: leagueEigo, categoryId: this.q.categoryId, groupId: this.q.groupId, search: this.q } })
      }
    },
    async getLeagueData() {
      const response = await this.$axios.get("/api/v1/hierarchy_leagues")
      this.leagues = response.data.leagues
    },
  }
}
</script>

<style scoped>
  .search {
    max-width: 650px;
  }
</style>