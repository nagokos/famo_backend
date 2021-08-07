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
      class="mt-2"
      background-color="#FAFAFA"
      color="black"
    >
      <v-tab
        exact
        class="font-weight-bold"
        :ripple="false"
        :to="{ name: playerName }"
      >
        選手一覧
      </v-tab>
      <v-tab
        exact
        class="font-weight-bold"
        :ripple="false"
        :to="{ name: ratingName }"
      >
        ランキング
      </v-tab>
    </v-tabs>
    <v-divider />
    <v-card-actions
      v-if="$vuetify.breakpoint.mobile"
      class="pb-0 mt-2"
    >
      <span class="font-weight-bold">
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
      <player-list-item
        v-for="user in users"
        :key="user.id"
        :user="user"
      />
    </v-list>
    <the-area-change-dialog
      ref="areaChangeDialog"
    />
    <the-player-search-dialog
      ref="playerSearchDialog"
      :teams="teams"
      @search-player="searchPlayer"
    />
  </v-col>
</template>

<script>
import PlayerListItem from "../parts/PlayerListItem.vue"

export default {
  components: {
    PlayerListItem
  },
  props: {
    users: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
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
}
</script>