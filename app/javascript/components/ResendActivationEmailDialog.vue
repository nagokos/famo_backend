<template>
  <v-dialog
    v-model="dialog"
    width="500"
  >
    <v-card>
      <v-card-title>
        <span class="mx-auto">認証メール再送信</span>
      </v-card-title>
      <v-divider />
      <v-card-text class="pt-6 pb-0">
        <v-container>
          <v-row>
            <v-col cols="12" class="pb-0">
              <v-text-field
                outlined
                label="メールアドレス"
                dense
                background-color="#ECEFF1"
                required
              />
            </v-col>
            <v-col align="right" cols="12" class="pt-0">
              <v-btn
                color="blue darken-1"
                text
              >
                送信
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false
    }
  },
  methods: {
    open() {
      this.dialog = true
    }
  }
}
</script>