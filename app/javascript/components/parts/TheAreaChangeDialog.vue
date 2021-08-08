<template>
  <v-dialog
    v-model="dialog"
    width="550"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
    @input="close(close)"
  >
    <v-card color="#FAFAFA">
      <v-btn
        icon
        :ripple="false"
        @click="close"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
      <v-card-title class="font-weight-bold px-9">
        エリア変更
        <v-spacer />
        <v-btn
          :ripple="false"
          class="font-weight-bold"
          small
          @click="pushWhole"
        >
          全国
        </v-btn>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
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
                v-model="league"
                outlined
                :items="leagues"
                item-text="name"
                item-value="id"
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
                v-model="category"
                outlined
                :items="filterCategories"
                item-text="name"
                item-value="id"
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
                v-model="group"
                outlined
                :items="filterGroups"
                item-value="id"
                item-text="name"
                dense
                no-data-text="表示できるグループがありません"
              />
            </v-col>
            <v-col
              class="pt-1"
              cols="12"
            >
              <v-btn
                class="font-weight-bold"
                large
                dark
                color="#3949AB"
                block
                @click="areaChange"
              >
                変更する
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      leagues: [],
      league: "",
      category: "",
      group: "",
      loading: false
    }
  },
  computed: {
    filterCategories() {
      let categories = []
      const unspecified = { name: "指定なし", id: "" }
      categories.push(unspecified)
      if (!this.league || !this.loading) return categories
      const findCategories = this.leagues.find(league => {
        return league.id === this.league
      }).categories
      findCategories.forEach(category => categories.push(category))
      return categories
    },
    filterGroups() {
      let groups = []
      const unspecified = { name: "指定なし", id: "" }
      groups.push(unspecified)
      if (!this.category || !this.loading) return groups
      const findGroups = this.filterCategories.find(category => {
        return category.id === this.category
      }).groups
      findGroups.forEach(category => groups.push(category))
      if (groups.length === 2) groups.splice(0)
      const notGroup = { name: "グループはありません", id: "" }
      groups.push(notGroup)
      return groups
    },
  },
  async created() {
    await this.getLeagueData()
    await this.setId()
    await this.setLeagueData()
    this.loading = true
  },
  methods: {
    resetId() {
      this.group = ""
      this.category = ""
    },
    setId() {
      if (!!this.$route.params.league) this.league = this.getLeagueId(this.$route.params.league)
      if (!!this.$route.params.categoryId) this.category = +this.$route.params.categoryId
      if (!!this.$route.params.groupId) this.group = +this.$route.params.groupId
    },
    setLeagueData() {
      const unspecified = { name: "指定なし", id: "" }
      this.leagues.unshift(unspecified)
    },
    open() {
      this.dialog = true
    },
    close() {
      this.dialog = false
    },
    pushWhole() {
      if (!this.$route.path.includes("whole")) {
        this.$router.push({ name: 'wholePlayer' })
      } else {
        this.close()
      }
    },
    areaChange() {
      if (!this.league && !this.category && !this.group) {
        if (this.$route.path.includes("whole")) return this.close()
        this.$router.push({ name: 'wholePlayer' })
      } else if (this.league && !this.category && !this.group) {
        const league = this.leagues.find(league => league.id === this.league)
        const leagueEigo = this.leagueNameEigo(league.name)
        if (this.$route.path.includes(leagueEigo) && !this.$route.params.categoryId && !this.$route.params.groupId) return this.close()
        this.$router.push({ name: "leaguePlayer", params: { league: leagueEigo } })
      } else if (this.league && this.category && !this.group) {
        if (this.$route.path.includes(this.category) && !this.$route.params.groupId) return this.close()
        const league = this.leagues.find(league => league.id === this.league).name
        const leagueEigo = this.leagueNameEigo(league)
        this.$router.push({ name: "categoryPlayer", params: { league: leagueEigo, categoryId: this.category } })
      } else {
        if (+this.$route.params.groupId === this.group) return this.close()
        const league = this.leagues.find(league => league.id === this.league).name
        const leagueEigo = this.leagueNameEigo(league)
        this.$router.push({ name: "groupPlayer", params: { league: leagueEigo, categoryId: this.category, groupId: this.group } })
      }
    },
    async getLeagueData() {
      const response = await this.$axios.get("/api/v1/hierarchy_leagues")
      this.leagues = response.data.leagues
    },
  }
}
</script>