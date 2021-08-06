<template>
  <v-list
    three-line
    :class="$vuetify.breakpoint.mobile ? '' : 'mt-3'"
    color="#FAFAFA"
  >
    <player-list-item
      v-for="user in users"
      :key="user.id"
      :user="user"
    />
  </v-list>
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