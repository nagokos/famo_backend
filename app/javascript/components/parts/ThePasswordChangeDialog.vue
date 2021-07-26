<template>
  <v-dialog
    v-model="dialog"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
    width="500"
    @input="close(close)"
  >
    <v-card color="#FAFAFA">
      <v-btn
        icon
        :ripple="false"
        @click="close"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
      <v-card-title class="pt-0 pb-5 font-weight-bold justify-center text-h5">
        パスワード変更
      </v-card-title>
      <v-divider />
      <v-card-text class="mt-8">
        <ValidationObserver
          ref="observer"
          v-slot="{ handleSubmit }"
        >
          <v-form ref="form">
            <v-container>
              <v-row>
                <v-col
                  cols="12"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    vid="current_password"
                    :rules="{ required: true, min: 8, formFormat: /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}$/i }"
                    name="現在のパスワード"
                  >
                    <v-text-field
                      v-model="currentPassword"
                      label="現在のパスワード"
                      outlined
                      dense
                      counter
                      background-color="#F2F4F8"
                      required
                      type="password"
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  cols="12"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    vid="password"
                    :rules="{ required: true, min: 8, formFormat: /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}$/i }"
                    name="新しいパスワード"
                  >
                    <v-text-field
                      v-model="user.password"
                      label="新しいパスワード"
                      placeholder="８文字以上の半角英数字"
                      hint="＊英字、数字の両方を含めてください"
                      :persistent-hint="true"
                      outlined
                      dense
                      counter
                      type="password"
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
                    vid="password_confirmation"
                    :rules="{ required: true, min: 8, formFormat: /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}$/i, passwordConfirmed: 'password' }"
                    name="パスワード確認"
                  >
                    <v-text-field
                      v-model="user.passwordConfirmation"
                      label="パスワード確認"
                      outlined
                      dense
                      type="password"
                      counter
                      background-color="#F2F4F8"
                      required
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  class="pt-0"
                  cols="12"
                >
                  <span
                    class="text-caption blue--text text--darken-2"
                    style="cursor: pointer;"
                    @click="$router.push({ name: 'passwordReset', params: { type: 'send_password_reset' } })"
                  >
                    現在のパスワードをお忘れですか？
                  </span>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <v-btn
                    color="#3949AB"
                    class="font-weight-bold"
                    large
                    dark
                    block
                    :ripple="false"
                    @click="handleSubmit(changePassword)"
                  >
                    変更する
                  </v-btn>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </ValidationObserver>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      currentPassword: "",
      user: {
        password: "",
        passwordConfirmation: ""
      }
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    close() {
      this.$refs.observer.reset()
      this.$refs.form.reset()
      this.dialog = false
    },
    async changePassword() {
      try {
        await this.$axios.patch("/api/v1/users/current/password_changes", {
          currentPassword: this.currentPassword,
          user: this.user
        })
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "パスワードを変更しました"
        })
        this.close()
      } catch(error) {
        this.$refs.observer.setErrors(error.response.data.errors)
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    }
  }
}
</script>