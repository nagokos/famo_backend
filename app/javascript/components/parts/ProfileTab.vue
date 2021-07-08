<template>
  <v-tabs
    color="black"
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
      :to="{ name: 'profile', params: { type: route.params } }"
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
          params: "relation"
        }
      ]
    }
  }
}
</script>

<style scoped>
  .v-tabs
  >>>
  .v-slide-group__prev {
    display: none !important;
  }
</style>