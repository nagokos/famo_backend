<template>
  <v-card
    class="mt-13"
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
import LoginHelpDialog from './LoginHelpDialog'

export default {
  components: {
    LoginHelpDialog
  },
  data() {
    return {
      active: true,
      show: false,
      email: "",
      password: ""
    }
  },
  methods: {
    openLoginHelp() {
      this.$refs.loginHelpDialog.open()
    },
    async sendLoginData() {
      try {
        await this.$axios.post("/api/v1/login", {
          email: this.email,
          password: this.password,
        })
        await this.$store.dispatch("user/getCurrentUserFromAPI")
      } catch(err) {
        if (err.response.data.key === 'inactive') {
          return this.active = false
        }
        this.$refs.observer.setErrors(err.response.data)
      }
    }
  },
}
</script>

<style scoped>
  .login {
    max-width: 310px;
  }
</style>