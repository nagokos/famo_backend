<template>
  <v-card-text
    class="pb-0"
  >
    <ValidationObserver
      ref="observer"
      v-slot="{ handleSubmit }"
    >
      <v-form>
        <v-container>
          <v-row>
            <v-col
              cols="6"
              class="mt-3"
            >
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:30"
                name="性"
              >
                <v-text-field
                  v-model="user.last_name"
                  outlined
                  dense
                  label="性"
                  placeholder="例）中山"
                  background-color="#ECEFF1"
                  required
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
            <v-col
              cols="6"
              class="mt-3"
            >
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:30"
                name="名"
              >
                <v-text-field
                  v-model="user.first_name"
                  outlined
                  dense
                  placeholder="例）太郎"
                  label="名"
                  background-color="#ECEFF1"
                  required
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
            <v-col
              cols="12"
              class="pt-0"
            >
              <v-menu
                ref="menu"
                v-model="menu"
                :close-on-content-click="false"
                transition="scale-transition"
                min-width="auto"
              >
                <template #activator="{ on, attrs }">
                  <ValidationProvider
                    v-slot="{ errors }"
                    :rules="{ required: true, formFormat: /\d{4}-\d{2}-\d{2}/ }"
                    name="生年月日"
                  >
                    <v-text-field
                      v-model="user.birth_date"
                      label="生年月日"
                      outlined
                      dense
                      readonly
                      v-bind="attrs"
                      background-color="#ECEFF1"
                      required
                      :error-messages="errors"
                      v-on="on"
                    />
                  </ValidationProvider>
                </template>
                <v-date-picker
                  v-model="user.birth_date"
                  :active-picker.sync="activePicker"
                  :max="new Date().toISOString().substr(0, 10)"
                  min="1900-01-01"
                  :day-format="date => new Date(date).getDate()"
                  locale="jp-ja"
                  @change="save"
                />
              </v-menu>
            </v-col>
            <v-col
              cols="12"
              class="pt-0"
            >
              <ValidationProvider
                v-slot="{ errors }"
                vid="email"
                :rules="{
                  required: true,
                  formFormat: /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/i
                }"
                name="メールアドレス"
              >
                <v-text-field
                  v-model="user.email"
                  outlined
                  dense
                  label="メールアドレス"
                  placeholder="例）famo0123@example.com"
                  background-color="#ECEFF1"
                  required
                  :error-messages="errors"
                />
              </ValidationProvider>
            </v-col>
            <v-col
              cols="12"
              class="pt-0"
            >
              <ValidationProvider
                v-slot="{ errors }"
                :rules="{ required: true, min: 8, formFormat: /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}$/i }"
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
                  dense
                  counter
                  background-color="#ECEFF1"
                  required
                  :error-messages="errors"
                  @click:append="show = !show"
                />
              </ValidationProvider>
            </v-col>
            <v-col class="pt-0 mb-8">
              <v-btn
                color="#3949AB"
                class="font-weight-bold"
                large
                dark
                block
                depressed
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
</template>

<script>
export default {
  data() {
    return {
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
    save(date) {
      this.$refs.menu.save(date)
    },
    async sendUserData() {
      try {
        await this.$axios.post("/api/v1/users", {
          user: this.user
        })
        this.signupForm = false
        this.$emit("create-user", this.user.email)
      } catch(err) {
        this.$refs.observer.setErrors({
          email: ["このメールアドレスは既に使用されています"]
        })
      }
    }
  }
}
</script>