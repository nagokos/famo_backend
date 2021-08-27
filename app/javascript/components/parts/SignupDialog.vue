<template>
  <v-dialog
    v-model="dialog"
    width="500"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
    :persistent="true"
  >
    <signup-dialog-select
      v-if="registerSelect"
      @email-register="showForm"
      @line-agree="lineAgree"
      @click-close="dialog = false"
    />
    <signup-dialog-form
      v-if="emailRegister"
      @create-user="showSendEmail"
      @click-back="closeForm"
    />
    <signup-dialog-line
      v-if="line"
      @click-back="closeLine"
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
import SignupDialogLine from "./SignupDialogLine"

export default {
  components: {
    SendActivationEmail,
    SignupDialogSelect,
    SignupDialogForm,
    SignupDialogLine
  },
  data() {
    return {
      dialog: false,
      registerSelect: false,
      line: false,
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
    lineAgree() {
      this.line = true
      this.registerSelect = false
    },
    closeForm() {
      this.emailRegister = false
      this.registerSelect = true
    },
    closeLine() {
      this.line = false
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