<template>
  <div class="text-center">
    <v-dialog
      v-model="dialog"
      width="500"
      :persistent="true"
    >
      <v-card>
        <v-btn
          icon
          @click="close"
        >
          <v-icon
            v-if="registerSelect || sendEmail"
          >
            mdi-close
          </v-icon>
          <v-icon
            v-if="signupForm"
          >
            mdi-arrow-left
          </v-icon>
        </v-btn>
        <v-card-title
          class="pt-0 font-weight-black justify-center"
        >
          新規登録
        </v-card-title>
        <v-divider />

        <signup-dialog-select
          v-if="registerSelect"
          @email-register="showForm"
        />

        <signup-dialog-form
          v-if="signupForm"
          @create-user="showSendEmail"
        />

        <send-activation-email
          v-if="sendEmail"
          :email="email"
        >
          <template #resend>
            <v-container>
              <v-divider
                class="mt-n3"
              />
              <v-row>
                <v-col
                  cols="12"
                  class="mt-6 pb-0"
                  align="center"
                >
                  <p
                    class="font-weight-bold"
                    style="color: black"
                  >
                    メールが届かない方はこちら
                  </p>
                </v-col>
                <v-col class="pt-0">
                  <v-btn
                    block
                    depressed
                    outlined
                    @click="resendEmail"
                  >
                    再度送信
                  </v-btn>
                </v-col>
              </v-row>
            </v-container>
          </template>
        </send-activation-email>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import SendActivationEmail from "./SendActivationEmail"
import SignupDialogSelect from "./SignupDialogSelect"
import SignupDialogForm from "./SignupDialogForm"

export default {
  components: {
    SendActivationEmail,
    SignupDialogSelect,
    SignupDialogForm
  },
  data() {
    return {
      dialog: false,
      registerSelect: false,
      signupForm: false,
      sendEmail: false,
      email: ""
    }
  },
  methods: {
    open() {
      this.dialog = true
      this.registerSelect = true
    },
    close() {
      if (this.signupForm) {
        this.signupForm = false
        return this.registerSelect = true
      }
      Object.assign(this.$data, this.$options.data())
    },
    showForm() {
      this.signupForm = true
      this.registerSelect = false
    },
    showSendEmail(email) {
      this.signupForm = false
      this.sendEmail = true
      this.email = email
    },
    async resendEmail() {
      await this.$axios.post("/api/v1/account_activations", {
        email: this.email
      })
    }
  }
}
</script>