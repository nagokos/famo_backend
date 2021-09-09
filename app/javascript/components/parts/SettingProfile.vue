<template>
  <div>
    <ValidationObserver
      ref="observer"
      v-slot="{ handleSubmit }"
    >
      <v-form>
        <v-container>
          <v-row>
            <v-col
              cols="12"
              md="3"
              :align="$vuetify.breakpoint.mobile ? 'center' : ''"
            >
              <span
                style="cursor: pointer;"
                @click="$refs.fileInput.$refs.input.click()"
              >
                <v-avatar
                  size="130"
                  @click="isInput = true"
                >
                  <v-img
                    eager
                    :src="avatar"
                  />
                </v-avatar>
                <br>
                <v-file-input
                  v-if="isInput"
                  ref="fileInput"
                  class="d-none"
                  accept="image/*"
                  @change="fileChange($event)"
                />
                <div class="text-center mt-1 text-subtitle-2 grey--text text--darken-1">
                  <span :class="$vuetify.breakpoint.mobile ? '' : 'mr-5'">変更</span>
                </div>
              </span>
            </v-col>
            <v-col
              cols="12"
              md="9"
            >
              <span
                class="font-weight-bold grey--text text--darken-1"
                :style="$vuetify.breakpoint.mobile ? 'font-size: 10px;' : 'font-size: 12px;'"
              >
                メールアドレス変更時には再度アカウント認証が必要になります
                <br>
                選手登録には生年月日が必要です(公開はされません)
                <br>
              </span>
              <ValidationProvider
                v-slot="{ errors }"
                name="名前"
                vid="name"
                rules="required|max:30"
              >
                <v-text-field
                  class="mt-3"
                  :value="name"
                  outlined
                  dense
                  label="名前"
                  required
                  background-color="#F2F4F8"
                  :error-messages="errors"
                  @input="$emit('update:name', $event)"
                />
              </ValidationProvider>
              <v-dialog
                ref="dialog"
                v-model="dateDialog"
                :fullscreen="$vuetify.breakpoint.mobile"
                :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
                width="330px"
              >
                <template #activator="{ on, attrs }">
                  <ValidationProvider
                    v-slot="{ errors }"
                    vid="birth_date"
                    :rules="{ formFormat: /\d{4}-\d{2}-\d{2}/ }"
                    name="生年月日"
                  >
                    <v-text-field
                      :value="birthDate"
                      label="生年月日"
                      outlined
                      dense
                      readonly
                      v-bind="attrs"
                      background-color="#F2F4F8"
                      :error-messages="errors"
                      v-on="on"
                    />
                  </ValidationProvider>
                </template>
                <v-date-picker
                  :value="birthDate"
                  color="primary"
                  :active-picker.sync="activePicker"
                  :max="$dayjs().format('YYYY-MM-DD')"
                  min="1900-01-01"
                  full-width
                  :day-format="date => new Date(date).getDate()"
                  locale="jp-ja"
                  @input="$emit('update:birthDate', $event)"
                >
                  <v-spacer />
                  <v-btn
                    text
                    color="primary"
                    :ripple="false"
                    @click="dateDialog = false"
                  >
                    キャンセル
                  </v-btn>
                  <v-btn
                    text
                    color="primary"
                    :ripple="false"
                    @click="dateDialog = false"
                  >
                    指定
                  </v-btn>
                </v-date-picker>
              </v-dialog>
              <ValidationProvider
                v-slot="{ errors }"
                name="メールアドレス"
                vid="email"
                :rules="{
                  required: true,
                  formFormat: /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/i
                }"
              >
                <v-text-field
                  class="mt-1"
                  :value="email"
                  outlined
                  dense
                  label="メールアドレス"
                  required
                  background-color="#F2F4F8"
                  :error-messages="errors"
                  @input="$emit('update:email', $event)"
                />
              </ValidationProvider>
              <ValidationProvider
                v-slot="{ errors }"
                rules="max:400"
                vid="introduction"
                name="自己紹介"
              >
                <v-textarea
                  class="mt-1"
                  :value="introduction"
                  outlined
                  dense
                  auto-grow
                  label="自己紹介"
                  counter="400"
                  background-color="#F2F4F8"
                  :error-messages="errors"
                  @input="$emit('update:introduction', removeWhiteSpace($event))"
                />
              </ValidationProvider>
            </v-col>
            <v-col
              cols="12"
              class="pt-0"
            >
              <v-btn
                color="#3949AB"
                class="font-weight-bold mt-1"
                large
                dark
                block
                :ripple="false"
                @click="handleSubmit(clickUpdate)"
              >
                更新する
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </ValidationObserver>
    <the-cropper-dialog
      ref="cropperDialog"
      :blob-url="blobUrl"
      :file-name="fileName"
      @set-avatar="setAvatar"
    />
  </div>
</template>
<script>
import TheCropperDialog from "./TheCropperDialog.vue"

export default {
  components: {
    TheCropperDialog
  },
  props: {
    avatar: {
      type: String,
      default: "",
      required: true
    },
    name: {
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
      required: false
    },
    birthDate: {
      type: String,
      default: "",
      required: false
    }
  },
  data() {
    return {
      activePicker: "",
      dateDialog: false,
      blobUrl: "",
      isInput: true,
      fileName: ""
    }
  },
  watch: {
    menu (val) {
      val && setTimeout(() => (this.activePicker = "YEAR"))
    },
    dateDialog (val) {
      val && setTimeout(() => (this.activePicker = "YEAR"))
    }
  },
  methods: {
    fileChange(file) {
      this.isInput = false
      this.fileName = file.name
      this.blobUrl = URL.createObjectURL(file)
      this.$refs.cropperDialog.open()
    },
    removeWhiteSpace(text) {
      return text.replace(/[\s\/]/g, '');
    },
    clickUpdate() {
      this.$emit("click-update")
    },
    setErrors(errors) {
      this.$refs.observer.setErrors(errors)
    },
    setAvatar(file) {
      this.$emit("avatar-change", file)
    }
  }
}
</script>
