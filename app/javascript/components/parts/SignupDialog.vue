<template>
  <div class="text-center">
    <v-dialog
      v-model="dialog"
      width="500"
      :persistent="true"
    >
      <signup-dialog-select
        v-if="registerSelect"
        @email-register="showForm"
        @click-close="dialog = false"
      />
      <signup-dialog-form
        v-if="emailRegister"
        @create-user="showSendEmail"
        @click-back="closeForm"
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
                  class="font-weight-bold black--text"
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
      emailRegister: false,
      sendEmail: false,
      email: ""
    }
  },
  methods: {
    open() {
      this.dialog = true
      this.registerSelect = true
    },
    showForm() {
      this.emailRegister = true
      this.registerSelect = false
    },
    closeForm() {
      this.emailRegister = false
      this.registerSelect = true
    },
    showSendEmail(email) {
      this.emailRegister = false
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