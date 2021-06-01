<template>
  <div class="register-login">
    <v-container>
      <v-row>
        <v-col
          cols="12"
          md="6"
        >
          <signup />
        </v-col>
        <v-col
          cols="12"
          md="6"
        >
          <login />
        </v-col>
      </v-row>
    </v-container>
    <the-login-help-dialog
      ref="loginHelpDialog"
    />
  </div>
</template>

<script>
import Signup from "../components/Signup"
import TheLoginHelpDialog from "../components/TheLoginHelpDialog"

export default {
  components: {
    Signup,
    TheLoginHelpDialog
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
    openRegister() {
      this.$refs.signupDialog.open()
    },
    openActivationEmail() {
      this.$refs.activationEmailDialog.open()
    },
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
  .register-login {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>