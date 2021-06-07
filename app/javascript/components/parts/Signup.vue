<template>
  <v-card
    class="mt-13"
    height="550"
    elevation="1"
    outlined
  >
    <v-card-title style="justify-content: center;">
      <span class="font-weight-black">新規登録</span>
    </v-card-title>
    <v-divider />
    <div class="signup mx-auto">
      <v-col
        align="center"
      >
        <p
          style="color: #616161; font-size: 15px;"
        >
          アカウントをお持ちでない方は<br>新規登録をしてください
        </p>
        <v-btn
          dark
          x-large
          block
          color="#EF5350"
          class="font-weight-black"
          @click="openSignupDialog"
        >
          新規会員登録
        </v-btn>
      </v-col>
      <v-col>
        <p style="font-size: 8px;">
          ＊会員登録することでFamoの利用規約・プライバシーポリシーに同意するものとします。
        </p>
        <p style="font-size: 8px;">
          ＊アカウント認証メールが届かない・再取得される方は
          <br>
          <strong
            style="cursor: pointer; color: red;"
            @click="openActivationEmail"
          >こちら</strong>
          をクリック
        </p>
      </v-col>
    </div>
    <signup-dialog
      ref="signupDialog"
    />
    <the-resend-activation-email-dialog
      ref="activationEmailDialog"
    />
  </v-card>
</template>

<script>
import SignupDialog from "./SignupDialog"
import TheResendActivationEmailDialog from "./TheResendActivationEmailDialog"

export default {
  components: {
    SignupDialog,
    TheResendActivationEmailDialog
  },
  methods: {
    openSignupDialog() {
      this.$refs.signupDialog.open()
    },
    openActivationEmail() {
      this.$refs.activationEmailDialog.open()
    }
  }
}
</script>

<style scoped>
  .signup {
    max-width: 300px;
    margin-top: 125px;
  }
</style>