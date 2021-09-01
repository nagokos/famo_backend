<template>
  <v-footer
    color="white"
  >
    <div
      class="mx-auto"
      style="width: 1050px;"
    >
      <v-container>
        <v-row>
          <v-col
            cols="12"
            class="text-h6"
          >
            <span
              style="cursor: pointer;"
              @click="$router.push({ name: 'top' }, () => {})"
            >
              Famo
            </span>
          </v-col>
          <v-col cols="12">
            <span
              class="text-caption blue--text text--darken-2"
              style="cursor: pointer;"
              @click="contact"
            >お問い合わせ</span>
            <br v-if="$vuetify.breakpoint.mobile">
            <span
              class="text-caption blue--text text--darken-2"
              style="cursor: pointer;"
              @click="$router.push({ name: 'terms' }, () => {})"
            >利用規約</span>
            <br v-if="$vuetify.breakpoint.mobile">
            <span
              class="text-caption blue--text text--darken-2"
              style="cursor: pointer;"
              @click="$router.push({ name: 'privacy' }, () => {})"
            >プライパシーポリシー</span>
          </v-col>
        </v-row>
      </v-container>
    </div>
  </v-footer>
</template>
<script>
export default {
  methods: {
    contact() {
      window.open("https://forms.gle/dCQkKciZmr4ACiAg7", "_blank")
    }
  }
}
</script>