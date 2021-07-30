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
      let name = ""
      if (!this.$route.path.includes("/profile") && this.user.role === "player")  {
        name = "playerProfile"
      } else if (!this.$route.path.includes("/profile") && this.user.role === "reviewer") {
        name = "reviewerProfile"
      } else if (this.$route.path.includes("/profile")) {
        name = "profile"
      }
      return name
    },
  }
}
</script>
