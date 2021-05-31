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
          <v-card
            class="mt-13"
            height="550"
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
                          vid="email"
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
                          vid="password"
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
                          v-if="active"
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
                        <v-btn
                          v-if="!active"
                          depressed
                          x-large
                          block
                          class="font-weight-black"
                          disabled
                          max-width="264"
                        >
                          アカウントを認証してください
                        </v-btn>
                        <p
                          class="mb-0 mt-2"
                          style="font-size: 10px"
                        >
                          ＊ ログインできない場合は
                          <strong
                            style="cursor: pointer; color: red;"
                            @click="openLoginHelp"
                          >
                            こちら
                          </strong>
                          をクリック
                        </p>
                      </v-col>
                      <v-col
                        align="center"
                        cols="12 pb-0"
                      >
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
  .login {
    max-width: 310px;
  }
</style>