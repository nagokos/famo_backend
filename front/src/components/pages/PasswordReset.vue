<template>
  <div class="reset">
    <ValidationObserver ref="observer" v-slot="{ handleSubmit }">
      <v-container :class="$vuetify.breakpoint.mobile ? 'px-5' : ''">
        <v-row>
          <template v-if="$route.path.includes('/send_password_reset')">
            <v-col cols="12" class="mt-10">
              <span class="font-weight-bold text-h5">再設定メールの送信</span>
              <p
                :class="
                  $vuetify.breakpoint.mobile
                    ? 'text-caption mt-6'
                    : 'text-subtitle-2 mt-6'
                "
              >
                ご入力のメールアドレスに、パスワード再設定用のメールを送信します。
                <br />
                メールアドレスのURLをクリックして、パスワードの再設定を行ってください。
              </p>
            </v-col>
            <v-col cols="12" class="pt-0">
              <ValidationProvider
                v-if="currentUser"
                vid="email"
                name="メールアドレス"
              >
                <v-text-field
                  outlined
                  dense
                  style="max-width: 400px"
                  readonly
                  :value="workEmail"
                  label="メールアドレス"
                  background-color="#ECEFF1"
                  required
                />
              </ValidationProvider>
              <ValidationProvider
                v-else
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
                  dense
                  style="max-width: 400px"
                  label="メールアドレス"
                  placeholder="例）famo0123@example.com"
                  background-color="#F2F4F8"
                  required
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
          </template>
          <template v-if="$route.path.includes('/password_reset')">
            <v-col cols="12" class="mt-10 pb-0">
              <span class="font-weight-bold text-h5">パスワード再設定</span>
              <p
                :class="
                  $vuetify.breakpoint.mobile
                    ? 'text-caption mt-6'
                    : 'text-subtitle-2 mt-6'
                "
              >
                英字、数字の両方を含めた８文字以上で設定してください
              </p>
            </v-col>
            <v-col cols="12">
              <ValidationProvider
                v-slot="{ errors }"
                vid="password"
                :rules="{
                  required: true,
                  min: 8,
                  formFormat: /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}$/i,
                }"
                name="パスワード"
              >
                <v-text-field
                  v-model="user.password"
                  label="パスワード"
                  :persistent-hint="true"
                  outlined
                  dense
                  style="max-width: 400px"
                  counter
                  type="password"
                  background-color="#F2F4F8"
                  required
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
            <v-col cols="12" class="py-0">
              <ValidationProvider
                v-slot="{ errors }"
                vid="password_confirmation"
                :rules="{
                  required: true,
                  min: 8,
                  formFormat: /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}$/i,
                  passwordConfirmed: 'password',
                }"
                name="パスワード確認"
              >
                <v-text-field
                  v-model="user.passwordConfirmation"
                  label="パスワード確認"
                  outlined
                  dense
                  style="max-width: 400px"
                  type="password"
                  counter
                  background-color="#F2F4F8"
                  required
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
          </template>
          <v-col class="pt-0">
            <v-btn
              :ripple="false"
              width="90"
              dark
              depressed
              color="#3949AB"
              class="font-weight-bold"
              @click="
                $route.path.includes('/password_reset')
                  ? handleSubmit(resetPassword)
                  : handleSubmit(sendEmail)
              "
            >
              {{ $route.path.includes("/password_reset") ? "登録" : "送信" }}
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </ValidationObserver>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      email: "",
      user: {
        password: "",
        passwordConfirmation: "",
      },
    };
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    workEmail() {
      const str = this.currentUser.email;
      const begin = 4;
      const emailLength = this.currentUser.email.length;
      const replace_str = "*".repeat(emailLength - 3 - begin - 1);
      const before = str.slice(0, begin - 1);
      const after = str.slice(begin - 1 + replace_str.length);
      return before + replace_str + after;
    },
  },
  mounted() {
    if (this.$route.path.includes("/password_reset")) {
      if (!document.cookie.includes("reset_token")) {
        this.$router.push({
          name: "passwordReset",
          params: { type: "send_password_reset" },
        });
      }
    }
  },
  methods: {
    getResetToken() {
      const cookies = document.cookie;
      const cookiesArray = cookies.split(";");
      for (const c of cookiesArray) {
        const cArray = c.split("=");
        if (cArray[0] == "reset_token") {
          return cArray[1];
        }
      }
    },
    async sendEmail() {
      if (this.currentUser) this.email = this.currentUser.email;
      try {
        await this.$axios.post("/api/v1/password_resets", {
          email: this.email,
        });
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "再設定メールを送信しました",
        });
      } catch (error) {
        this.$refs.observer.setErrors(error.response.data.errors);
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message,
        });
      }
    },
    async resetPassword() {
      const resetToken = this.getResetToken();
      try {
        await this.$axios.patch(`/api/v1/password_resets/${resetToken}`, {
          user: this.user,
        });
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "パスワードを再設定しました",
        });
        this.$router.push({ name: "top" });
      } catch (error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message,
        });
        this.$router.push({
          name: "passwordReset",
          params: { type: "send_password_reset" },
        });
      }
    },
  },
};
</script>

<style scoped>
.reset {
  max-width: 600px;
  margin: 0 auto;
}
</style>
