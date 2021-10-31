<template>
  <v-app>
    <the-header />
    <v-main style="background: #FAFAFA;">
      <the-flash-message />
      <not-found v-if="isNotFound" />
      <router-view
        v-if="!isNotFound"
        class="mb-16"
      />
    </v-main>
    <the-footer />
  </v-app>
</template>

<script>
import TheHeader from "./components/globals/TheHeader"
import TheFlashMessage from "./components/globals/TheFlashMessage"
import TheFooter from "./components/globals/TheFooter"
import NotFound from "./components/pages/NotFound"
import { mapGetters } from 'vuex'

export default {
  components: {
    TheHeader,
    TheFlashMessage,
    TheFooter,
    NotFound
  },
  computed: {
    ...mapGetters({ isNotFound: "notFound/isNotFound" })
  },
  watch: {
    $route() {
      this.$store.dispatch("notFound/setNotFound", false)
    }
  }
}
</script>
