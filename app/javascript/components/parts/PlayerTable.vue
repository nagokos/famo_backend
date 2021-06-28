<template>
  <v-col
    lg="4"
  >
    <v-card
      outlined
      :elevation="isEdit ? 1 : ''"
    >
      <player-table-view
        v-if="!isEdit"
        :profile="profile"
        @click-player="$emit('click-player')"
        @click-edit="changeEdit"
      />
      <player-table-edit
        v-if="isEdit"
        ref="playerTableEdit"
        :profile-edit="profileEdit"
        @click-update="$emit('click-update')"
        @click-cancel="close"
      />
    </v-card>
  </v-col>
</template>

<script>
import PlayerTableView from './PlayerTableView'
import PlayerTableEdit from './PlayerTableEdit'

export default {
  components: {
    PlayerTableView,
    PlayerTableEdit
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