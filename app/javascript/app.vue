<template>
  <v-app>
    <the-header />
    <router-view />
  </v-app>
</template>

<script>
import TheHeader from "./components/shared/TheHeader"

export default {
  components: {
    TheHeader
  },
  data() {
    return {
    }
  }
}
</script>
