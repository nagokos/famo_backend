<template>
  <v-col
    cols="12"
    lg="8"
  >
    <div
      class="font-weight-bold"
      style="font-size: 1.8rem"
    >
      {{ $route.path.includes("/whole") ? "全国" : league.name }}
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
      class="mt-2"
      color="#FAFAFA"
    >
      <player-list-item
        v-for="user in users"
        :key="user.id"
        :user="user"
      />
    </v-list>
  </v-col>
</template>

<script>
import PlayerListItem from "../parts/PlayerListItem.vue"

export default {
  components: {
    PlayerListItem
  },
  props: {
    league: {
      type: Object,
      default: () => {},
      required: true
    },
    users: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  methods: {
    pushUserPage(user) {
      if (this.currentUser.id === user.id) {
        this.$router.push({ name: "profile" })
      } else {
        this.$router.push({
          name: "playerProfile",
          params: { league: this.$route.params.league, categoryId: user.profile.category.id, groupId: user.profile.groupId, userId: user.id }
        })
      }
    },
  }
}
</script>