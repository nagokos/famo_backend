<template>
  <div class="register-login">
    <v-container>
      <v-row>
        <v-col
          cols="12"
          md="6"
        >
          <v-card
            class="mt-13"
          >
            <v-card-title style="justify-content: center;">
              <span class="font-weight-black">新規登録</span>
            </v-card-title>
            <v-divider />
            <v-container>
              <v-row>
                <v-col align="center">
                  <div class="signup">
                    <p
                      class="mt-10"
                      style="color: #616161; font-size: 15px;"
                    >
                      アカウントをお持ちでない方は<br>新規登録をしてください
                    </p>
                    <v-btn
                      depressed
                      dark
                      x-large
                      block
                      color="#EF5350"
                      class="mb-13 font-weight-black"
                      @click="openRegister"
                    >
                      新規会員登録
                    </v-btn>
                  </div>
                </v-col>
              </v-row>
            </v-container>
          </v-card>
        </v-col>
        <v-col
          cols="12"
          md="6"
        >
          <v-card
            class="mt-13"
          >
            <v-card-title style="justify-content: center;">
              <span class="font-weight-black">ログイン</span>
            </v-card-title>
            <v-divider />
            <v-container>
              <v-row>
                <v-col align="center">
                  <div class="signup">
                    <p
                      class="mt-10"
                      style="color: #616161; font-size: 15px;"
                    >
                      アカウントをお持ちでない方は新規登録をしてください
                    </p>
                    <v-btn
                      outlined
                      depressed
                      dark
                      x-large
                      block
                      color="black"
                      class="mb-13 font-weight-black"
                    >
                      ログイン
                    </v-btn>
                  </div>
                </v-col>
              </v-row>
            </v-container>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <the-signup-dialog
      ref="signupDialog"
    />
  </div>
</template>

<script>
import TheSignupDialog from "../components/TheSignupDialog"

export default {
  components: {
    TheSignupDialog
  },
  methods: {
    openRegister() {
      this.$refs.signupDialog.open()
    }
  }
}
</script>

<style scoped>
  .register-login {
    max-width: 1050px;
    margin: 0 auto;
  }
  .signup {
    max-width: 300px;
  }
</style>