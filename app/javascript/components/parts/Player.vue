<template>
  <v-col
    lg="4"
  >
    <player-table
      v-if="!$vuetify.breakpoint.mobile"
      :profile="profile"
      @click-player="$emit('click-player')"
    />
    <player-Card
      v-if="$vuetify.breakpoint.mobile"
      :profile="profile"
      @click-player="$emit('click-player')"
    />
  </v-col>
</template>

<script>
import PlayerTable from './PlayerTable'
import PlayerCard from './PlayerCard'

export default {
  components: {
    PlayerTable,
    PlayerCard,
  },
  props: {
    profile: {
      type: Object,
      default: () => {},
      required: false
    },
  }
}
</script>