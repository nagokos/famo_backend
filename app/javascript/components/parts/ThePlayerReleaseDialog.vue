<template>
  <v-dialog
    v-model="dialog"
    width="550"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
    @input="close(close)"
  >
    <v-card
      color="#FAFAFA"
    >
      <v-btn
        icon
        :ripple="false"
        @click="close"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
      <v-card-title
        class="pt-0 pb-5 font-weight-bold justify-center text-h5"
      >
        選手登録解除
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
              <v-row
                justify="center"
              >
                <v-col>
                  <v-sheet
                    color="#f1f4f8"
                    rounded
                  >
                    <v-container>
                      <v-col>
                        <div class="font-weight-bold text-subtitle-1">
                          注意事項
                        </div>
                        <ul
                          class="mt-3"
                        >
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
                <v-col
                  cols="12"
                >
                  <div>ただし、今までの評価は削除されないため、再登録後も引き継いだままとなります。</div>
                </v-col>
                <ValidationProvider rules="required">
                  <v-checkbox
                    v-model="checkbox"
                    required
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
                    class="font-weight-bold"
                    @click="releasePlayer"
                  >
                    選手登録を解除
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
      precautions: [
        "選手登録を解除すると評価を受けることができなくなります。",
        "もう一度評価を受けるためには選手登録が必要になります。",
        "選手一覧ページ、ランキングからも削除されます。"
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
    async releasePlayer() {
      try {
        await this.$axios.delete("/api/v1/users/current/profile")
        await this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "選手登録を解除しました"
        })
        this.$emit('update-user')
        this.close()
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    }
  }
}
</script>