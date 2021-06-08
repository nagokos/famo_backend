<template>
  <v-card
    height="550"
    elevation="1"
    outlined
  >
    <v-card-title style="justify-content: center;">
      <span class="font-weight-black">ログイン</span>
    </v-card-title>
    <v-divider />
    <div class="login mx-auto mt-12">
      <login-form
        @click-login-help="$refs.loginHelpDialog.open()"
      />
    </div>
    <login-help-dialog
      ref="loginHelpDialog"
    />
  </v-card>
</template>

<script>
import LoginForm from "./LoginForm"
import LoginHelpDialog from "./LoginHelpDialog"

export default {
  components: {
    LoginHelpDialog,
    LoginForm
  }
}
</script>

<style scoped>
  .login {
    max-width: 310px;
  }
</style>