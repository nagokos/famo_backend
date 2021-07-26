<template>
  <v-card
    height="550"
    elevation="1"
    outlined
  >
    <v-card-title class="font-weight-bold justify-center">
      ログイン
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
                    v-model="user.email"
                    label="メールアドレス"
                    outlined
                    background-color="#F2F4F8"
                    required
                    :error-messages="errors"
                  />
                </ValidationProvider>
              </v-col>
              <v-col
                cols="12"
                class="py-0"
              >
                <ValidationProvider
                  v-slot="{ errors }"
                  vid="password"
                  rules="required"
                  name="パスワード"
                >
                  <v-text-field
                    v-model="user.password"
                    :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
                    :type="show ? 'text' : 'password'"
                    label="パスワード"
                    outlined
                    counter
                    background-color="#F2F4F8"
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
                  :dark="!inActive"
                  x-large
                  block
                  :ripple="false"
                  :disabled="inActive"
                  color="black"
                  class="font-weight-bold"
                  @click="handleSubmit(sendLoginData)"
                >
                  {{ inActive ? "アカウントを認証してください" : "ログイン" }}
                </v-btn>
                <p
                  class="mb-0 mt-2"
                  style="font-size: 10px"
                >
                  ＊ ログインできない場合は
                  <strong
                    style="cursor: pointer;"
                    class="red--text"
                    @click="$refs.loginHelpDialog.open()"
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
                class="pt-1"
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
                class="pt-1"
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
    <login-help-dialog
      ref="loginHelpDialog"
    />
  </v-card>
</template>

<script>
import LoginHelpDialog from "./LoginHelpDialog"

export default {
  components: {
    LoginHelpDialog,
  },
  data() {
    return {
      inActive: false,
      show: false,
      user: {
        email: "",
        password: ""
      }
    }
  },
  methods: {
    sendLoginData() {
      this.$emit("login-data", this.user)
    },
    setErrors(errors) {
      this.$refs.observer.setErrors(errors)
    },
    setInActive() {
      this.inActive = true
    }
  }
}
</script>

<style scoped>
  .login {
    max-width: 310px;
  }
</style>