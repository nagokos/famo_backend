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
            height="530"
          >
            <v-card-title style="justify-content: center;">
              <span class="font-weight-black">新規登録</span>
            </v-card-title>
            <v-divider />
            <div class="signup">
              <v-col
                align="center"
                class="register-area"
              >
                <p
                  class="mb-5"
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
              </v-col>
            </div>
          </v-card>
        </v-col>
        <v-col
          cols="12"
          md="6"
        >
          <v-card
            class="mt-13 pb-4"
            height="530"
          >
            <v-card-title style="justify-content: center;">
              <span class="font-weight-black">ログイン</span>
            </v-card-title>
            <v-divider />
            <div class="signup">
              <v-container class="mt-12">
                <v-row>
                  <v-col
                    cols="12"
                    align="center"
                  >
                    <v-text-field
                      v-model="email"
                      label="メールアドレス"
                      outlined
                      background-color="#ECEFF1"
                    />
                  </v-col>
                  <v-col
                    cols="12"
                    class="pt-0"
                  >
                    <v-text-field
                      v-model="password"
                      :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
                      :type="show ? 'text' : 'password'"
                      label="パスワード"
                      hint="６文字以上で入力してください"
                      outlined
                      background-color="#ECEFF1"
                      @click:append="show = !show"
                    />
                  </v-col>
                  <v-col
                    cols="12"
                    class="pt-0"
                  >
                    <v-btn
                      outlined
                      depressed
                      x-large
                      block
                      color="black"
                      class="font-weight-black"
                      @click="sendLoginData"
                    >
                      ログイン
                    </v-btn>
                  </v-col>
                  <v-col cols="12 pb-0">
                    <p class="caption">
                      - 他サイトのアカウントで登録済みの方はこちら -
                    </p>
                  </v-col>
                  <v-col
                    cols="6"
                    align="center"
                  >
                    <v-avatar
                      size="55"
                      class="ml-14"
                    >
                      <v-img
                        src="/img/line.png"
                      />
                    </v-avatar>
                  </v-col>
                  <v-col
                    cols="6"
                    align="center"
                  >
                    <v-avatar
                      size="55"
                      class="mr-14"
                    >
                      <v-img
                        src="/img/facebook.png"
                      />
                    </v-avatar>
                  </v-col>
                </v-row>
              </v-container>
            </div>
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
  data() {
    return {
      show: false,
      email: "",
      password: ""
    }
  },
  methods: {
    openRegister() {
      this.$refs.signupDialog.open()
    },
    async sendLoginData() {
      try {
        await this.$axios.post("/api/v1/login", {
          email: this.email,
          password: this.password,
        })
        await this.$store.dispatch("user/getCurrentUserFromAPI")
      } catch(err) {
        console.log(err.response);
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
  .signup {
    max-width: 300px;
    margin: 0 auto;
  }
  .register-area {
    margin-top: 150px;
  }
</style>