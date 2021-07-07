<template>
  <v-tabs
    color="black"
    :fixed-tabs="$vuetify.breakpoint.mobile"
    :class="$vuetify.breakpoint.mobile ? 'px-4' : ''"
    background-color="#FAFAFA"
  >
    <v-tab
      class="mr-2 font-weight-bold"
      v-for="route in routes"
      :key="route.name"
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
          name: "トップ",
        },
        {
          name: "レビュー",
          params: "review"
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