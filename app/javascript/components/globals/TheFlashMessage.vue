<template>
  <v-snackbar
    :value="isFlash"
    :top="!$vuetify.breakpoint.mobile"
    right
    transition="scale-transition"
    color="grey darken-4"
    :class="!$vuetify.breakpoint.mobile ? 'mt-5 mr-14' : 'mb-3'"
    min-width="0"
  >
    <v-icon :color="flash.type">
      {{ flash.icon }}
    </v-icon>
    {{ flash.message }}
  </v-snackbar>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({ flash: "flash/flash", isFlash: "flash/isFlash" })
  },
  watch: {
    isFlash(value) {
      if (value) {
        setTimeout(() => {
          this.$store.dispatch("flash/resetFlash")
        }, 7000)
      }
    }
  }
}
</script>

<style scoped>
  .v-snack
  >>>
  .v-snack__content {
    font-weight: bold;
  }
</style>