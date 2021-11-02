<template>
  <v-dialog v-model="dialog" width="500" :persistent="true">
    <v-card v-if="form">
      <v-btn icon :ripple="false" @click="close">
        <v-icon> mdi-close </v-icon>
      </v-btn>
      <v-card-title class="pt-0 font-weight-bold justify-center">
        認証メール再送信
      </v-card-title>
      <v-divider />
      <v-card-text class="pt-6 pb-0">
        <ValidationObserver ref="observer" v-slot="{ handleSubmit }">
          <v-form>
            <v-container>
              <v-row>
                <v-col cols="12" class="pb-0">
                  <ValidationProvider
                    v-slot="{ errors }"
                    vid="email"
                    :rules="{
                      required: true,
                      formFormat:
                        /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/i,
                    }"
                    name="メールアドレス"
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
                    :ripple="false"
                    @click="handleSubmit(sendEmailData)"
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
    <send-activation-email
      v-if="sendEmail"
      :email="email"
      @click-close="close"
    />
  </v-dialog>
</template>

<script>
import SendActivationEmail from "./SendActivationEmail";

export default {
  components: {
    SendActivationEmail,
  },
  data() {
    return {
      dialog: false,
      email: "",
      form: true,
      sendEmail: false,
    };
  },
  methods: {
    open() {
      this.dialog = true;
    },
    close() {
      if (this.form) this.$refs.observer.reset();
      Object.assign(this.$data, this.$options.data());
    },
    async sendEmailData() {
      try {
        await this.$axios.post("/api/v1/account_activations", {
          email: this.email,
        });
        await this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "認証メールを送信しました",
        });
        this.form = false;
        this.sendEmail = true;
      } catch (error) {
        await this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: Object.values(error.response.data.errors)[0],
        });
        this.$refs.observer.setErrors(error.response.data.errors);
      }
    },
  },
};
</script>
