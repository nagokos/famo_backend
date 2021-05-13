<template>
  <v-app>
    <the-header />
      <v-main>
        <router-view />
      </v-main>
    <the-footer />
  </v-app>
</template>

<script>
import TheHeader from "./components/shared/TheHeader"
import TheFooter from "./components/shared/TheFooter"

export default {
  components: {
    TheHeader,
    TheFooter
  },
  data() {
    return {
    }
  }
}
</script>
