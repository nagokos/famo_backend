<template>
  <v-app>
    <the-header />
      <v-main style="background: #FAFAFA;">
        <the-flash-message />
        <router-view />
      </v-main>
    <the-footer />
  </v-app>
</template>

<script>
import TheHeader from "./components/globals/TheHeader"
import TheFlashMessage from "./components/globals/TheFlashMessage"
import TheFooter from "./components/globals/TheFooter"

export default {
  components: {
    TheHeader,
    TheFlashMessage,
    TheFooter
  },
}
</script>
