<template>
  <v-card
    color="#FAFAFA"
  >
    <v-btn
      icon
      @click="$emit('click-close')"
    >
      <v-icon>
        mdi-close
      </v-icon>
    </v-btn>
    <v-card-title
      class="pt-0 pb-5 font-weight-bold justify-center text-h6"
    >
      認証メール送信
    </v-card-title>
    <v-divider />
    <v-card-text>
      <v-container>
        <v-row>
          <v-col
            cols="12"
            class="pb-0 mt-6"
            align="center"
          >
            <p
              class="font-weight-bold black--text"
            >
              ご登録のアドレスにアカウント<br v-if="$vuetify.breakpoint.mobile">認証メールを送信しました
            </p>
          </v-col>
          <v-col
            cols="12"
            class="pt-0"
          >
            <v-sheet
              class="d-flex"
              rounded
              color="#f1f4f8"
              height="50"
            >
              <v-col
                cols="12"
                align="center"
              >
                <p>{{ email }}</p>
              </v-col>
            </v-sheet>
          </v-col>
          <v-col
            cols="12"
            class="py-0"
          >
            <p style="font-size: 10px;">
              ＊リンクをクリックしてアカウントを認証してください。
              <br>
              ＊リンクの有効期限は２４時間以内です。
            </p>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-divider
          class="mt-n3"
        />
        <v-row>
          <v-col
            cols="12"
            class="mt-6 pb-0"
            align="center"
          >
            <p
              class="font-weight-bold black--text"
            >
              メールが届かない方はこちら
            </p>
          </v-col>
          <v-col class="pt-0">
            <v-btn
              block
              depressed
              outlined
              @click="resendEmail"
            >
              再度送信
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    email: {
      type: String,
      required: true
    }
  },
  methods: {
    async resendEmail() {
      try {
        await this.$axios.post("/api/v1/account_activations", {
          email: this.email
        })
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "認証メールを送信しました"
        })
      } catch(err) {
        console.log(err.response.data.email);
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: err.response.data.email
        })
      }
    }
  }
}
</script>