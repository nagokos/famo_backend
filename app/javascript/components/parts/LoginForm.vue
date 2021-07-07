<template>
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
                background-color="#F2F4F8"
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
              :disabled="inActive"
              color="black"
              class="font-weight-black"
              @click="handleSubmit(sendLoginData)"
            >
              {{ inActive ? "アカウントを認証してください" : "ログイン"  }}
            </v-btn>
            <p
              class="mb-0 mt-2"
              style="font-size: 10px"
            >
              ＊ ログインできない場合は
              <strong
                style="cursor: pointer; color: red;"
                @click="$emit('click-login-help')"
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
</template>

<script>
export default {
  data() {
    return {
      inActive: false,
      show: false,
      email: "",
      password: ""
    }
  },
  methods: {
    async sendLoginData() {
      try {
        await this.$axios.post("/api/v1/login", {
          email: this.email,
          password: this.password,
        })
        await this.$store.dispatch("user/getCurrentUserFromAPI")
        await this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "ログインしました"
        })
        this.$router.push({ name: "profile" })
      } catch(err) {
        if (err.response.data.key === "inactive") {
          this.inActive = true
          return this.$store.dispatch("flash/setFlash", {
                    type: "error",
                    message: "アカウントを認証してください"
                  })
        }
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "フォームに不備があります"
        })
        this.$refs.observer.setErrors(err.response.data)
      }
    }
  }
}
</script>