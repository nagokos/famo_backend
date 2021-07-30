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
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      routes: [
        {
          name: "レビュー"
        },
        {
          name: "フォロー",
          params: "following"
        },
        {
          name: "フォロワー",
          params: "followers"
        }
      ]
    }
  },
  computed: {
    setName() {
      if (!this.$route.path.includes("/profile") && this.user.role === "player") {
        return "playerProfile"
      } else if (!this.$route.path.includes("/profile") && this.user.role === "reviewer") {
        return "reviewerProfile"
      } else if (this.$route.path.includes("/profile")) {
        return "profile"
      }
    },
  }
}
</script>
