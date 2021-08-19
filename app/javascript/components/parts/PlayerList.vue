<template>
  <v-col
    cols="12"
    lg="8"
  >
    <div
      v-if="!$vuetify.breakpoint.mobile"
      class="font-weight-bold"
      style="font-size: 1.8rem"
    >
      {{ isWhole ? "全国" : area.name }}
    </div>
    <div
      v-if="$vuetify.breakpoint.mobile"
      class="font-weight-bold text-h5"
    >
      <span @click="$refs.areaChangeDialog.open()">
        {{ isWhole ? "全国" : area.name }}
        <v-icon
          size="30"
          class="ml-1 mb-1"
        >
          mdi-chevron-down
        </v-icon>
      </span>
    </div>
    <v-tabs
      v-model="tab"
      class="mt-2"
      background-color="#FAFAFA"
      color="black"
    >
      <v-tab
        class="font-weight-bold"
        :ripple="false"
        @click="pushPlayer"
      >
        選手一覧
      </v-tab>
      <v-tab
        class="font-weight-bold"
        :ripple="false"
        @click="pushRating"
      >
        ランキング
      </v-tab>
    </v-tabs>
    <v-divider />
    <v-card-actions
      v-if="$vuetify.breakpoint.mobile"
      class="pb-0 mt-2"
    >
      <span class="font-weight-bold text-subtitle-2">
        {{ searchDataInformation }}
      </span>
      <v-spacer />
      <v-btn
        :ripple="false"
        small
        @click="$refs.playerSearchDialog.open()"
      >
        <v-icon size="20">
          mdi-tune
        </v-icon>
        <span class="text-caption font-weight-bold ml-1">フィルター</span>
      </v-btn>
    </v-card-actions>
    <v-list
      three-line
      :class="$vuetify.breakpoint.mobile ? 'pt-0' : 'mt-3'"
      color="#FAFAFA"
    >
      <template v-for="(user, index) in users">
        <player-list-item
          :key="user.id"
          :user="user"
          :index="rankIndex[index]"
        />
        <v-divider
          v-if="users.length > index + 1"
          :key="index"
          :class="$vuetify.breakpoint.mobile ? '' : 'my-5'"
        />
      </template>
    </v-list>
    <template v-if="totalCount > 20">
      <v-divider class="mt-10" />
      <v-card
        outlined
        color="#f1f4f8"
      >
        <v-pagination
          :value="page"
          :length="totalPages"
          color="#3949AB"
          class="my-5"
          @input="pagination($event)"
        />
      </v-card>
      <v-divider />
    </template>
    <the-area-change-dialog
      v-if="$vuetify.breakpoint.mobile"
      ref="areaChangeDialog"
    />
    <the-player-search-dialog
      v-if="$vuetify.breakpoint.mobile"
      ref="playerSearchDialog"
      :teams="teams"
      v-bind.sync="q"
    />
  </v-col>
</template>

<script>
import PlayerListItem from "../parts/PlayerListItem"
import TheAreaChangeDialog from "../parts/TheAreaChangeDialog"
import ThePlayerSearchDialog from "../parts/ThePlayerSearchDialog"

export default {
  components: {
    PlayerListItem,
    TheAreaChangeDialog,
    ThePlayerSearchDialog
  },
  props: {
    area: {
      type: Object,
      default: () => {},
      required: true
    },
    users: {
      type: Array,
      default: () => {},
      required: true
    },
    teams: {
      type: Array,
      default: () => {},
      required: true
    },
    q: {
      type: Object,
      default: () => {},
      required: true
    },
    page: {
      type: Number,
      default: 1,
      required: true
    },
    totalPages: {
      type: Number,
      default: 1,
      required: true
    },
    currentPage: {
      type: Number,
      default: 1,
      required: true
    },
    totalCount: {
      type: Number,
      default: 0,
      required: true
    }
  },
  data() {
    return {
      searchData: "",
      tab: 0,
      routes: [
        {
          name: "選手一覧",
        },
        {
          name: "ランキング",
          params: "ratings"
        }
      ]
    }
  },
  computed: {
    searchDataInformation() {
      if (this.q.position === "" && !this.q.teamId) {
        return "標準"
      } else if (this.q.position !== "" && !this.q.teamId) {
        return this.positionTransForm(this.q.position)
      } else if (this.q.position === "" && !!this.q.teamId) {
        const team = this.teams.find(team => team.id === this.q.teamId)
        return team.name
      } else {
        const team = this.teams.find(team => team.id === this.q.teamId)
        const position = this.positionTransForm(this.q.position)
        return `${position} / ${team.name}`
      }
    },
    isWhole() {
      return this.$route.path.includes("whole")
    },
    rankIndex() {
      return [...Array(20)].map((_, i) => (this.currentPage - 1) * 20 + 1 + i * 1)
    }
  },
  mounted() {
    if (this.$route.path.includes("ratings")) this.tab = 1
  },
  methods: {
    pushPlayer() {
      this.tab = 0
      const query = { team: this.$route.query.team, position: this.$route.query.position, page: undefined }
      if (this.isWhole) {
        return this.$router.push({ name: "wholePlayer", query: query }, () => {})
      } else if (!this.isWhole && !this.$route.params.categoryId && !this.$route.params.groupId) {
        return this.$router.push({ name: "leaguePlayer", query: query }, () => {})
      } else if (!this.isWhole && !this.$route.params.groupId) {
        return this.$router.push({ name: "categoryPlayer", query: query }, () => {})
      } else {
        return this.$router.push({ name: "groupPlayer", query: query }, () => {})
      }
    },
    pushRating() {
      this.tab = 1
      const query = { team: this.$route.query.team, position: this.$route.query.position, page: undefined }
      if (this.isWhole) {
        return this.$router.push({ name: "wholeRating", query: query }, () => {})
      } else if (!this.isWhole && !this.$route.params.categoryId && !this.$route.params.groupId) {
        return this.$router.push({ name: "leagueRating", query: query }, () => {})
      } else if (!this.isWhole && !this.$route.params.groupId) {
        return this.$router.push({ name: "categoryRating", query: query }, () => {})
      } else {
        return this.$router.push({ name: "groupRating", query: query }, () => {})
      }
    },
    searchPlayer(q, data) {
      this.searchData = data
      this.$emit("search-player", q)
    },
    positionTransForm(id) {
      let position = ""
      switch (id) {
      case 0:
        position = "GK"
        break
      case 1:
        position = "DF"
        break
      case 2:
        position = "MF"
        break
      case 3:
        position = "FW"
        break
      }
      return position
    },
    pagination(e) {
      this.$emit("update:page", e)
      const query = { team: this.$route.query.team, position: this.$route.query.position, page: e }
      this.$router.push({ name: this.$route.name, query: query }, () => {})
    }
  }
}
</script>