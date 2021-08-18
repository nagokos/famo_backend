<template>
  <v-dialog
    v-model="dialog"
    width="550"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
    @input="close(close)"
  >
    <v-card color="#FAFAFA">
      <v-btn
        icon
        :ripple="false"
        @click="close"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
      <v-card-title class="pt-0 pb-5 font-weight-bold justify-center text-h5">
        アカウント削除
      </v-card-title>
      <v-divider />
      <v-card-text
        :class="$vuetify.breakpoint.mobile ? 'px-1 pt-1' : 'pt-8'"
      >
        <ValidationObserver
          v-slot="{ invalid }"
        >
          <v-form>
            <v-container>
              <v-row justify="center">
                <v-col cols="12">
                  <v-sheet
                    color="#f1f4f8"
                    rounded
                  >
                    <v-container>
                      <v-col>
                        <div class="font-weight-bold text-subtitle-1">
                          注意事項
                        </div>
                        <ul class="mt-3">
                          <li
                            v-for="precaution in precautions"
                            :key="precaution"
                            class="mt-1"
                          >
                            {{ precaution }}
                          </li>
                        </ul>
                      </v-col>
                    </v-container>
                  </v-sheet>
                </v-col>
                <ValidationProvider rules="required">
                  <v-checkbox
                    v-model="checkbox"
                    class="mt-7"
                    value="1"
                    label="上記の注意事項を確認しました"
                  />
                </ValidationProvider>
                <v-col
                  align="center"
                  cols="12"
                >
                  <v-btn
                    :disabled="invalid"
                    large
                    :ripple="false"
                    color="red"
                    :dark="!invalid"
                    width="300"
                    :loading="loading"
                    class="font-weight-bold"
                    @click="clickDelete"
                  >
                    アカウントを削除
                  </v-btn>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </ValidationObserver>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      checkbox: null,
      loading: false,
      precautions: [
        "アカウントを削除すると、あなたのプロフィール情報、つながり、選手情報が全て削除されます。",
        "Famoで投稿した評価はサイトに残り続けます。",
        "アカウントは復旧することができません。"
      ]
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    close() {
      this.dialog = false
      this.checkbox = null
    },
    clickDelete() {
      this.loading = true
      this.$emit("delete-user")
    }
  }
}
</script>