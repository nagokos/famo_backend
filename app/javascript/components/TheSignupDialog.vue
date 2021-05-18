<template>
  <div class="text-center">
    <v-dialog
      v-model="dialog"
      width="500"
      :persistent="true"
    >
      <v-card>
        <v-card-title
          class="font-weight-black"
          style="justify-content: center;"
        >
          新規登録
        </v-card-title>
        <v-divider />

        <v-container v-if="!emailRegister">
          <v-row>
            <v-col
              cols="12"
              align="center"
              class="mt-10"
            >
              <v-btn
                width="250"
                x-large
                class="font-weight-bold"
                @click="signupForm"
              >
                <v-icon
                  color="#EF5350"
                  class="mr-2"
                >
                  mdi-email
                </v-icon>
                メールアドレスで登録
              </v-btn>
            </v-col>
            <v-col
              cols="12"
              align="center"
            >
              <v-btn
                width="250"
                x-large
                class="font-weight-bold"
              >
                <v-img
                  src="/img/line.png"
                  class="mr-2"
                  max-width="25"
                  max-height="25"
                />
                LINEで登録
              </v-btn>
            </v-col>
            <v-col
              cols="12"
              align="center"
              class="mb-14"
            >
              <v-btn
                width="250"
                x-large
                class="font-weight-bold"
                style="text-transform: none;"
              >
                <v-img
                  src="/img/facebook.png"
                  class="mr-2"
                  max-width="25"
                  max-height="25"
                />
                FaceBookで登録
              </v-btn>
            </v-col>
          </v-row>
        </v-container>

        <v-card-text
          v-if="emailRegister"
          class="pb-0"
        >
          <v-container>
            <v-row>
              <v-col
                cols="6"
                class="mt-3"
              >
                <v-text-field
                  v-model="user.last_name"
                  outlined
                  dense
                  label="性"
                  placeholder="例）中山"
                />
              </v-col>
              <v-col
                cols="6"
                class="mt-3"
              >
                <v-text-field
                  v-model="user.first_name"
                  outlined
                  dense
                  placeholder="例）太郎"
                  label="名"
                />
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
                    <v-text-field
                      v-model="user.birth_date"
                      label="生年月日"
                      outlined
                      dense
                      readonly
                      v-bind="attrs"
                      v-on="on"
                    />
                  </template>
                  <v-date-picker
                    v-model="user.birth_date"
                    :active-picker.sync="activePicker"
                    :max="new Date().toISOString().substr(0, 10)"
                    min="1950-01-01"
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
                <v-text-field
                  v-model="user.email"
                  outlined
                  dense
                  label="メールアドレス"
                  placeholder="例）famo0123@example.com"
                />
              </v-col>
              <v-col
                cols="12"
                class="pt-0"
              >
                <v-text-field
                  v-model="user.password"
                  :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
                  :type="show ? 'text' : 'password'"
                  label="パスワード"
                  hint="６文字以上で入力してください"
                  outlined
                  dense
                  counter
                  @click:append="show = !show"
                />
              </v-col>
              <v-col class="pt-0 mb-8">
                <v-btn
                  color="#3949AB"
                  large
                  dark
                  block
                  depressed
                  @click="sendUserData"
                >
                  登録する
                </v-btn>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      emailRegister: false,
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
    },
    signupForm() {
      this.emailRegister = true
    },
    save(date) {
      this.$refs.menu.save(date)
    },
    async sendUserData() {
      console.log(this.user);
    }
  }
}
</script>