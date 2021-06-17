<template>
  <v-dialog
    v-model="dialog"
    width="550"
    :persistent="true"
    scrollable
  >
    <v-card>
      <v-btn
        icon
        @click="close"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
      <v-card-title
        class="pt-0 font-weight-bold justify-center"
      >
        プロフィール編集
      </v-card-title>
      <v-divider />
      <v-card-text
        v-if="form"
        :style="$vuetify.breakpoint.mobile ? 'height: 450px' : ''"
        :class="$vuetify.breakpoint.mobile ? 'px-2' : ''"
      >
        <ValidationObserver
          ref="observer"
          v-slot="{ handleSubmit }"
        >
          <v-form>
            <v-container>
              <v-row>
                <v-col
                  cols="12"
                  class="pb-0"
                >
                  <span
                    class="font-weight-bold text-h6"
                    style="color: black;"
                  >
                    プロフィール写真
                  </span>
                </v-col>
                <v-col
                  align="center"
                  cols="12"
                  class="mt-2 pb-3"
                >
                  <v-avatar
                    size="140"
                    style="cursor: pointer;"
                    @click="$refs.fileInput.$refs.input.click()"
                  >
                    <v-img
                      :src="avatar"
                    />
                  </v-avatar>
                  <br>
                  <v-file-input
                    ref="fileInput"
                    style="display: none;"
                  />
                </v-col>
                <v-col cols="12">
                  <span
                    class="font-weight-bold text-h6"
                    style="color: black;"
                  >
                    基本情報
                  </span>
                  <br>
                  <span class="text-caption font-weight-bold">*メールアドレス変更時には再度アカウント認証が必要になります。</span>
                </v-col>
                <v-col
                  cols="6"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="性"
                    rules="required|max:30"
                  >
                    <v-text-field
                      :value="lastName"
                      outlined
                      dense
                      label="性"
                      required
                      background-color="#ECEFF1"
                      :error-messages="errors"
                      @input="$emit('update:lastName', $event)"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  cols="6"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="名"
                    rules="required|max:30"
                  >
                    <v-text-field
                      :value="firstName"
                      outlined
                      dense
                      label="名"
                      required
                      background-color="#ECEFF1"
                      :error-messages="errors"
                      @input="$emit('update:firstName', $event)"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  class="pt-0"
                  cols="12"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="メールアドレス"
                    vid="email"
                    :rules="{ required: true, formFormat: /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/i }"
                  >
                    <v-text-field
                      :value="email"
                      outlined
                      dense
                      label="メールアドレス"
                      required
                      background-color="#ECEFF1"
                      :error-messages="errors"
                      @input="$emit('update:email', $event)"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  class="pt-0"
                  cols="12"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="max:400"
                    name="自己紹介"
                  >
                    <v-textarea
                      :value="introduction"
                      outlined
                      dense
                      label="自己紹介"
                      counter="400"
                      :error-messages="errors"
                      @input="$emit('update:introduction', $event)"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <v-btn
                    color="#3949AB"
                    class="font-weight-bold"
                    large
                    dark
                    block
                    depressed
                    @click="handleSubmit(clickUpdate)"
                  >
                    更新する
                  </v-btn>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </ValidationObserver>
      </v-card-text>
      <send-activation-email
        v-if="sendEmail"
        :email="email"
      />
    </v-card>
  </v-dialog>
</template>

<script>
import SendActivationEmail from "./SendActivationEmail"

export default {
  components : {
    SendActivationEmail
  },
  props: {
    avatar: {
      type: String,
      default: "",
      required: true
    },
    lastName: {
      type: String,
      default: "",
      required: true
    },
    firstName: {
      type: String,
      default: "",
      required: true
    },
    email: {
      type: String,
      default: "",
      required: true
    },
    introduction: {
      type: String,
      default: "",
      required: true
    }
  },
  data() {
    return {
      dialog: false,
      form: false,
      sendEmail: false
    }
  },
  methods: {
    open() {
      this.dialog = true
      this.form = true
    },
    close() {
      this.dialog = false
      this.sendEmail = false
      this.$emit("click-close")
    },
    clickUpdate() {
      this.$emit("click-update")
    },
    sendActivationEmail() {
      this.form = false
      this.sendEmail = true
    },
    dupEmail() {
      this.$refs.observer.setErrors({
        email: ["このメールアドレスは既に使用されています"]
      })
    }
  }
}
</script>
