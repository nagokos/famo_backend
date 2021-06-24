<template>
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
      @click-close="Object.assign($data, $options.data())"
    />
  </v-dialog>
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
  }
}
</script>