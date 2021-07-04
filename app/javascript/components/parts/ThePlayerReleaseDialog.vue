<template>
  <v-dialog
    v-model="dialog"
    width="550"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
  >
    <v-card
      color="#FAFAFA"
    >
      <v-btn
        icon
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
        <ValidationObserver>
          <v-form
            ref="form"
          >
            <v-container>
              <v-row justify="center">
                <v-col>
                  <v-sheet
                    color="#f1f4f8"
                    rounded
                  >
                    <v-container>
                      <v-col>
                        <div class="font-weight-bold text-subtitle-1">注意事項</div>
                        <ul class="mt-3">
                          <li class="mt-1" v-for="precaution in precautions" :key="precaution">
                            {{ precaution }}
                          </li>
                        </ul>
                      </v-col>
                    </v-container>
                  </v-sheet>
                </v-col>
                <v-col cols="12">
                  <div>ただし、今までの評価は、マイページや他ユーザーページから閲覧することができます。</div>
                  <div class="mt-1">また、選手レートもリセットされません。</div>
                </v-col>
                <v-checkbox @click="checkbox = !checkbox" label="上記の注意事項等を確認しました"></v-checkbox>
                <v-col align="center" cols="12">
                  <v-btn @click="releasePlayer" :disabled="checkbox" large color="red" :dark="!checkbox" width="300" class="font-weight-bold">選手登録を解除</v-btn>
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
      checkbox: true,
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
      this.$refs.form.reset()
      this.checkbox = true
    },
    async releasePlayer() {
      await this.$axios.delete("/api/v1/profile")
      this.$emit('update-user')
      this.dialog = false
    }
  }
}
</script>