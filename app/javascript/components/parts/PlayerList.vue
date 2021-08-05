<template>
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