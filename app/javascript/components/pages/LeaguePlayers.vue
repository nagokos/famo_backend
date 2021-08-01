<template>
  <div
    v-if="loading"
    class="league"
  >
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <div class="players">
      <v-container>
        <v-row>
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
                    v-for="category in league.categories"
                    :key="category.id"
                    small
                    :ripple="false"
                    outlined
                  >
                    {{ category.name }}
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
              return-object
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
              class="mt-5"
              background-color="white"
              outlined
              dense
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
            >
              検索する
            </v-btn>
          </v-col>
          <v-col
            cols="12"
            lg="8"
          >
            <div
              class="font-weight-bold"
              style="font-size: 1.8rem"
            >
              {{ league.name }}
            </div>
            <div v-if="$vuetify.breakpoint.mobile">
              詳細条件
            </div>
            <v-tabs
              class="mt-2"
              background-color="#FAFAFA"
              color="black"
            >
              <v-tab
                class="font-weight-bold"
                :ripple="false"
              >
                選手一覧
              </v-tab>
              <v-tab
                class="font-weight-bold"
                :ripple="false"
              >
                ランキング
              </v-tab>
            </v-tabs>
            <v-divider />
            <v-list
              three-line
              class="mt-5"
              color="#FAFAFA"
            >
              <template v-for="(player, index) in players">
                <v-list-item
                  :key="player.id"
                  class="pl-0"
                  inactive
                  :ripple="false"
                  style="cursor: pointer;"
                  @click="pushUserPage(player)"
                >
                  <v-avatar
                    size="130"
                    rounded=""
                  >
                    <v-img
                      :src="player.avatar"
                    />
                  </v-avatar>
                  <v-list-item-content class="ml-5">
                    <v-list-item-title class="font-weight-bold text-h5 mt-2">
                      {{ fullName(player) }}
                    </v-list-item-title>
                    <v-list-item-subtitle
                      class="mt-2"
                      style="margin-left: 1px;"
                    >
                      {{ information(player) }}
                    </v-list-item-subtitle>
                    <v-card-actions class="pl-0">
                      <v-rating
                        :value="3"
                        background-color="#ef5350"
                        color="#ef5350"
                        readonly
                        size="30"
                        dense
                        style="position: relative; right: 3px;"
                      />
                      <span class="ml-1 text-h5 font-weight-bold">
                        3.0
                      </span>
                    </v-card-actions>
                  </v-list-item-content>
                </v-list-item>
                <v-divider
                  :key="index"
                  class="my-5"
                />
              </template>
            </v-list>
          </v-col>
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
import Transform from "../../packs/league-transform"
import TheBreadCrumb from "../globals/TheBreadCrumb"

export default {
  components: {
    TheBreadCrumb
  },
  data() {
    return {
      players: [],
      league: {},
    }
  },
  computed: {
    breadCrumbs() {
      return [
        {
          text: "TOP",
          to: "/",
          disabled: false,
        },
        {
          text: this.league.name,
          to: this.$route.path,
          disabled: false,
        },
      ]
    }
  },
  async created() {
    this.getLeague()
    this.getPlayers()
  },
  methods: {
    async getPlayers() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/leagues/${leagueId}/users`)
    },
    async getLeague() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/leagues/${leagueId}`)
      this.league = response.data.league
    },
  }
}
</script>

<style scoped>
  .league {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>