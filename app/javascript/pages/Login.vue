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
                  @click="openRegister"
                >
                  新規会員登録
                </v-btn>
              </v-col>
              <v-col>
                <p style="font-size: 8px;">
                  ＊会員登録することでFamoの利用規約・プライバシーポリシーに同意するものとします。
                </p>
                <p style="font-size: 8px;">
                  ＊アカウント認証メールが届かない方は
                  <strong @click="openActivationEmail" style="cursor: pointer; color: red;">こちら</strong>
                  をクリック
                </p>
              </v-col>
            </div>
          </v-card>
        </v-col>
        <v-col
          cols="12"
          md="6"
        >
          <v-card
            class="mt-13"
            height="530"
          >
            <v-card-title style="justify-content: center;">
              <span class="font-weight-black">ログイン</span>
            </v-card-title>
            <v-divider />
            <div class="login mx-auto mt-12">
              <ValidationObserver
                ref="observer"
                v-slot="{ handleSubmit }"
              >
                <v-form>
                  <v-container>
                    <v-row>
                      <v-col
                        cols="12"
                        align="center"
                      >
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="required"
                          name="メールアドレス"
                        >
                          <v-text-field
                            v-model="email"
                            label="メールアドレス"
                            outlined
                            background-color="#ECEFF1"
                            required
                            :error-messages="errors"
                          />
                        </ValidationProvider>
                      </v-col>
                      <v-col
                        cols="12"
                        class="pt-0"
                      >
                        <ValidationProvider
                          v-slot="{ errors }"
                          rules="required"
                          name="パスワード"
                        >
                          <v-text-field
                            v-model="password"
                            :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
                            :type="show ? 'text' : 'password'"
                            label="パスワード"
                            outlined
                            counter
                            background-color="#ECEFF1"
                            required
                            :error-messages="errors"
                            @click:append="show = !show"
                          />
                        </ValidationProvider>
                      </v-col>
                      <v-col
                        cols="12"
                        class="pt-0"
                      >
                        <v-btn
                          dark
                          depressed
                          x-large
                          block
                          color="black"
                          class="font-weight-black"
                          @click="handleSubmit(sendLoginData)"
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
                </v-form>
              </ValidationObserver>
            </div>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <signup-dialog
      ref="signupDialog"
    />
    <resend-activation-email-dialog
      ref="activationEmailDialog"
    />
  </div>
</template>

<script>
import SignupDialog from "../components/SignupDialog"
import ResendActivationEmailDialog from "../components/ResendActivationEmailDialog"

export default {
  components: {
    SignupDialog,
    ResendActivationEmailDialog
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
    },
    openActivationEmail() {
      this.$refs.activationEmailDialog.open()
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
    margin-top: 110px;
  }
  .login {
    max-width: 300px;
  }
</style>