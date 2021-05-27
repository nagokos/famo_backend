<template>
  <v-dialog
    v-model="dialog"
    width="500"
    :persistent="true"
  >
    <v-card>
      <v-card-title>
        <span class="mx-auto">認証メール再送信</span>
      </v-card-title>
      <v-divider />
      <v-card-text class="pt-6 pb-0">
        <ValidationObserver ref="observer" v-slot="{ handleSubmit }">
          <v-form>
            <v-container>
              <v-row>
                <v-col cols="12" class="pb-0">
                  <ValidationProvider
                    vid="email"
                    :rules="{
                      required: true,
                      formFormat: /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/i
                     }"
                    name="メールアドレス"
                    v-slot="{ errors }"
                  >
                    <v-text-field
                      v-model="email"
                      outlined
                      label="メールアドレス"
                      dense
                      background-color="#ECEFF1"
                      required
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col align="right" cols="12" class="pt-0">
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="handleSubmit(sendEmail)"
                  >
                    送信
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
      email: ""
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    async sendEmail() {
      try {
        await this.$axios.post("/api/v1/account_activations", {
          email: this.email
        })
        Object.assign(this.$data, this.$options.data())
      } catch(err) {
        this.$refs.observer.setErrors({
          email: ["ユーザーが見つかりませんでした"]
        })
      }
    }
  }
}
</script>