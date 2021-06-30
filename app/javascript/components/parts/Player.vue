<template>
  <v-col
    lg="4"
  >
    <player-table
      v-if="!isEdit && !$vuetify.breakpoint.mobile"
      :profile="profile"
      @click-player="$emit('click-player')"
      @click-edit="changeEdit"
    />
    <player-Card
      v-if="!isEdit && $vuetify.breakpoint.mobile"
      :profile="profile"
      @click-player="$emit('click-player')"
      @click-edit="changeEdit"
    />
    <player-edit
      v-if="isEdit"
      ref="playerTableEdit"
      :profile-edit="profileEdit"
      @click-update="$emit('click-update')"
      @click-cancel="close"
    />
  </v-col>
</template>

<script>
import PlayerTable from './PlayerTable'
import PlayerCard from './PlayerCard'
import PlayerEdit from './PlayerEdit'

export default {
  components: {
    PlayerTable,
    PlayerCard,
    PlayerEdit
  },
  props: {
    profile: {
      type: Object,
      default: () => {},
      required: false
    },
    profileEdit: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      isEdit: false,
    }
  },
  methods: {
    changeEdit(name) {
      this.isEdit = true
      this.$nextTick(() => {
        this.$refs.playerTableEdit.change(name)
      })
      this.$emit("click-edit")
    },
    close() {
      this.isEdit = false
    },
    setErrors(errors) {
      this.$refs.playerTableEdit.setErrors(errors)
    }
  }
}
</script>