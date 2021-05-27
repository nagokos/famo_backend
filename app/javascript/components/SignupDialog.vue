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
          @click="closeDialog"
        >
          <v-icon
            v-if="registerSelect || sendActivationEmail"
          >
            mdi-close
          </v-icon>
          <v-icon
            v-if="emailRegister"
          >
            mdi-arrow-left
          </v-icon>
        </v-btn>
        <v-card-title
          class="font-weight-black pt-0"
        >
          <span class="mx-auto">新規登録</span>
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

        <the-send-activation-email
          v-if="sendActivationEmail"
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
        </the-send-activation-email>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import TheSendActivationEmail from "./TheSendActivationEmail"
import SignupDialogSelect from "./SignupDialogSelect"
import SignupDialogForm from "./SignupDialogForm"

export default {
  components: {
    TheSendActivationEmail,
    SignupDialogSelect,
    SignupDialogForm
  },
  data() {
    return {
      dialog: false,
      registerSelect: false,
      emailRegister: false,
      sendActivationEmail: false,
      password: "",
      show: false,
      menu: false,
      activePicker: "",
      user: {
        first_name: "",
        last_name: "",
        birth_date: "",
        email: "",
        password: ""
      }
    }
  },
  watch: {
    menu (val) {
      val && setTimeout(() => (this.activePicker = "YEAR"))
    },
  },
  methods: {
    open() {
      this.dialog = true
      this.registerSelect = true
    },
    closeDialog() {
      if (this.emailRegister === true) {
        this.emailRegister = false
        return this.registerSelect = true
      }
      this.dialog = false
      Object.assign(this.$data, this.$options.data())
    },
    signupForm() {
      this.emailRegister = true
      this.registerSelect = false
    },
    save(date) {
      this.$refs.menu.save(date)
    },
    async sendUserData() {
      try {
        const response = await this.$axios.post("/api/v1/users", {
          user: this.user
        })
        this.$refs.observer.reset()
        this.emailRegister = false
        this.sendActivationEmail = true
      } catch(err) {
        console.log(err.response);
        this.$refs.observer.setErrors({
          email: ["このメールアドレスは既に使用されています"]
        })
      }
    },
    async resendEmail() {
      try {
        const response = await this.$axios.post("/api/v1/account_activations", {
          email: this.user.email
        })
        console.log(response);
      } catch(err) {
        console.log(err.response);
      }
    }
  }
}
</script>