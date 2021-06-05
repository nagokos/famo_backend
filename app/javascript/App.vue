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
import TheHeader from "./components/globals/TheHeader"
import TheFooter from "./components/globals/TheFooter"

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
