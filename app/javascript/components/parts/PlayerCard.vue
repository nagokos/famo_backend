<template>
  <v-col cols="12">
    <v-card
      elevation="1"
      outlined
      justify-space-between
    >
      <player-card-view
        v-if="!isEdit"
        :profile="profile"
        @click-player="$emit('click-player')"
        @click-edit="changeEdit"
      />
      <player-card-edit
        v-if="isEdit"
        ref="playerCardEdit"
        :profile-edit="profileEdit"
        @click-update="$emit('click-update')"
        @click-cancel="close"
      />
    </v-card>
  </v-col>
</template>

<script>
import PlayerCardView from "./PlayerCardView"
import PlayerCardEdit from "./PlayerCardEdit"

export default {
  components: {
    PlayerCardView,
    PlayerCardEdit
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
      isEdit: false
    }
  },
  methods: {
    changeEdit(name) {
      this.isEdit = true
      this.$nextTick(() => {
        this.$refs.playerCardEdit.change(name)
      })
      this.$emit("click-edit")
    },
    close() {
      this.isEdit = false
    },
    setErrors(errors) {
      this.$refs.playerCardEdit.setErrors(errors)
    }
  }
}
</script>