<template>
  <div>
    <v-container>
      <v-row>
        <v-col class="pb-0">
          <p class="text-h4 font-weight-bold mb-1">
            選手を探す
          </p>
          <p
            class="font-weight-bold mt-3"
            style="color: #EF5350;"
          >
            各リーグから選手を探すことができます
          </p>
        </v-col>
      </v-row>
      <v-row>
        <v-col
          cols="12"
          class="pt-0"
        >
          <v-chip-group
            v-show="categories.length === 0"
            column
          >
            <v-chip
              v-for="league in leagues"
              :key="league.id"
              v-model="leagueChip"
              :ripple="false"
              outlined
              @click="findCategories(league)"
            >
              {{ league.name }}
            </v-chip>
          </v-chip-group>
          <v-chip-group
            v-show="categories.length !== 0 && groups.length === 0"
            column
          >
            <v-col
              class="py-0 px-0 mb-3"
              cols="12"
            >
              <v-btn
                class="mr-1"
                icon
                @click="resetLeague"
              >
                <v-icon>
                  mdi-arrow-left
                </v-icon>
              </v-btn>
              <span
                class="font-weight-bold text-h6 text-decoration-underline"
                :style="$vuetify.breakpoint.mobile ? 'position: relative; top: 4px; cursor: pointer;' : 'position: relative; top: 3px; cursor: pointer;'"
                @click="pushLeague"
              >
                {{ leagueName }}
              </span>
            </v-col>
            <v-chip
              v-for="category in categories"
              :key="category.id"
              v-model="categoryChip"
              :ripple="false"
              outlined
              @click="findOrPushGroups(category)"
            >
              {{ category.name }}
            </v-chip>
          </v-chip-group>
          <v-chip-group
            v-show="groups.length >= 2"
            column
          >
            <v-col
              class="py-0 px-0 mb-3"
              cols="12"
            >
              <v-btn
                class="mr-1"
                icon
                @click="resetCategory"
              >
                <v-icon>
                  mdi-arrow-left
                </v-icon>
              </v-btn>
              <span
                class="font-weight-bold text-h6 text-decoration-underline"
                :style="$vuetify.breakpoint.mobile ? 'position: relative; top: 4px; cursor: pointer;' : 'position: relative; top: 3px; cursor: pointer;'"
                @click="pushCategory"
              >
                {{ categoryName }}
              </span>
            </v-col>
            <v-chip
              v-for="group in groups"
              :key="group.id"
              :ripple="false"
              outlined
              @click="pushGroup(group.id)"
            >
              {{ group.name }}
            </v-chip>
          </v-chip-group>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import Transform from "../../packs/league-transform"

export default {
  props: {
    leagues: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      categories: [],
      groups: [],
      leagueChip: false,
      categoryChip: false,
      categoryName: "",
      leagueName: "",
      leagueId: "",
      categoryId: "",
    }
  },
  methods: {
    resetLeague() {
      this.categories = ""
      this.leagueChip = ""
    },
    resetCategory() {
      this.groups = ""
      this.categoryChip = ""
    },
    findCategories(leagueData) {
      this.categories = this.leagues.find(league => {
        return league.id === leagueData.id
      }).categories
      this.leagueName = leagueData.name
      this.leagueId = leagueData.id
    },
    findOrPushGroups(categoryData) {
      this.groups = this.categories.find(category => {
        return category.id === categoryData.id
      }).groups
      this.categoryName = categoryData.name
      this.categoryId = categoryData.id
      if (this.groups.length < 2) {
        this.pushCategory()
        this.groups = []
      }
    },
    pushLeague() {
      const leagueEigo = Transform.leagueNameEigo(this.leagueName)
      localStorage.leagueId = this.leagueId
      this.$router.push({ name: "leaguePlayer", params: { league: leagueEigo } })
    },
    pushCategory() {
      const leagueEigo = Transform.leagueNameEigo(this.leagueName)
      this.$router.push({ name: "categoryPlayer", params: { league: leagueEigo, categoryId: this.categoryId } })
    },
    pushGroup(groupId) {
      const leagueEigo = Transform.leagueNameEigo(this.leagueName)
      this.$router.push({ name: "groupPlayer", params: { league: leagueEigo, categoryId: this.categoryId, groupId: groupId } })
    },
  }
}
</script>
