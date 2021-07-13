<template>
  <div class="register-login">
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
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
          <login
            ref="login"
            @login-data="sendLoginData"
          />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import TheBreadCrumb from "../globals/TheBreadCrumb"
import Signup from "../parts/Signup"
import Login from "../parts/Login"

export default {
  components: {
    TheBreadCrumb,
    Signup,
    Login
  },
  data() {
    return {
      breadCrumbs: [
        {
          text: "TOP",
          to: "/",
          disabled: false,
        },
        {
          text: "新規登録・ログイン",
          to: "/login",
          disabled: true,
        }
      ]
    }
  },
  methods: {
    async sendLoginData(user) {
      try {
        await this.$store.dispatch("user/loginUser", user)
        await this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "ログインしました"
        })
        this.$router.push({ name: "profile" })
      } catch(error) {
        if (error.response.data.errors) {
          this.$refs.login.setErrors(error.response.data.errors)
        }
        if (error.response.data.status === 'inactive') {
          this.$refs.login.setInActive()
        }
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    }
  }
}
</script>

<style scoped>
  .register-login {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>