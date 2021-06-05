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
  </div>
</template>

<script>
import Signup from "../parts/Signup"
import Login from "../parts/Login"

export default {
  components: {
    Signup,
    Login
  },
}
</script>

<style scoped>
  .register-login {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>