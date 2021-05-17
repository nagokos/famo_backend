<template>
  <v-app-bar
    app
    flat
    color="#3949AB"
  >
    <v-toolbar
      max-width="1050"
      flat
      color="#3949AB"
      class="mx-auto"
    >
      <v-toolbar-title
        class="font-weight-bold text-h5"
        style="color: white; cursor: pointer;"
        @click="toTopPage"
      >
        Famo
      </v-toolbar-title>
      <v-spacer />
      <v-toolbar-items>
        <v-btn
          text
          @click="toLoginPage"
        >
          <span
            class="caption"
            style="text-transform: none; color: white;"
          >登録 ｜ ログイン</span>
        </v-btn>
      </v-toolbar-items>
    </v-toolbar>
  </v-app-bar>
</template>

<script>
export default {
  methods: {
    toTopPage() {
      if (this.$route.path !== "/") {
        this.$router.push({ name: "top" })
      }
    },
    toLoginPage() {
      if (this.$route.path !== "/login") {
        this.$router.push({ name: "login" })
      }
    }
  }
}
</script>