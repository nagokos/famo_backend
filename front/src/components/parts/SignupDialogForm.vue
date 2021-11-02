<template>
  <v-card color="#FAFAFA">
    <v-btn icon :ripple="false" @click="$emit('click-back')">
      <v-icon> mdi-arrow-left </v-icon>
    </v-btn>
    <v-card-title class="pt-0 pb-5 font-weight-bold justify-center text-h6">
      メールアドレス登録
    </v-card-title>
    <v-divider />
    <v-card-text class="pb-0">
      <ValidationObserver ref="observer" v-slot="{ handleSubmit }">
        <v-form>
          <v-container>
            <v-row>
              <v-col cols="12" class="mt-5">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required|max:30"
                  vid="name"
                  name="名前"
                >
                  <v-text-field
                    v-model="user.name"
                    outlined
                    label="お名前"
                    placeholder="例）中山太朗"
                    background-color="#F2F4F8"
                    required
                    :error-messages="errors"
                  />
                </ValidationProvider>
              </v-col>
              <v-col cols="12" class="pt-0">
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
                    v-model="user.email"
                    outlined
                    label="メールアドレス"
                    placeholder="例）famo0123@example.com"
                    background-color="#F2F4F8"
                    required
                    :error-messages="errors"
                  />
                </ValidationProvider>
              </v-col>
              <v-col cols="12" class="pt-0">
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
                    :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
                    :type="show ? 'text' : 'password'"
                    label="パスワード"
                    placeholder="８文字以上の半角英数字"
                    hint="＊英字、数字の両方を含めてください"
                    :persistent-hint="true"
                    outlined
                    counter
                    background-color="#F2F4F8"
                    required
                    :error-messages="errors"
                    @click:append="show = !show"
                  />
                </ValidationProvider>
              </v-col>
              <v-col class="pt-0 mb-4">
                <v-btn
                  color="#3949AB"
                  class="font-weight-bold"
                  large
                  block
                  :ripple="false"
                  :dark="!isSignup"
                  :disabled="isSignup"
                  :loading="isSignup"
                  @click="handleSubmit(sendUserData)"
                >
                  登録する
                </v-btn>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
      </ValidationObserver>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  data() {
    return {
      show: false,
      isSignup: false,
      activePicker: "",
      user: {
        name: "",
        email: "",
        password: "",
      },
    };
  },
  methods: {
    async sendUserData() {
      this.isSignup = true;
      try {
        await this.$axios.post("/api/v1/users", {
          user: this.user,
        });
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "認証メールを送信しました",
        });
        this.$emit("create-user", this.user.email);
      } catch (error) {
        this.isSignup = false;
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "フォームに不備があります",
        });
        this.$refs.observer.setErrors(error.response.data.errors);
      }
    },
  },
};
</script>
