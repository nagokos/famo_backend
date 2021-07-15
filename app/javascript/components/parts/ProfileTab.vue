<template>
  <v-tabs
    :fixed-tabs="$vuetify.breakpoint.mobile"
    background-color="#FAFAFA"
    :class="$vuetify.breakpoint.mobile ? 'px-4' : ''"
  >
    <v-tab
      v-for="route in routes"
      :key="route.name"
      exact
      :ripple="false"
      class="font-weight-bold"
      :to="{ name: setName, params: { type: route.params } }"
    >
      {{ route.name }}
    </v-tab>
  </v-tabs>
</template>

<script>
export default {
  data() {
    return {
      routes: [
        {
          name: "レビュー"
        },
        {
          name: "つながり",
          params: "following"
        }
      ]
    }
  },
  computed: {
    setName() {
      return this.$route.path.includes("/profile") ? "profile" : "userProfile"
    }
  },
  watch: {
    $route() {
      if (this.$route.path.includes("/following")) {
        this.routes[1].params = "following"
      } else if (this.$route.path.includes("/followers")) {
        this.routes[1].params = "followers"
      }
    }
  }
}
</script>
