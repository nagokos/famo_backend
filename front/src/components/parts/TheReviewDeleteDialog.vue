<template>
  <v-dialog
    v-model="dialog"
    :width="$vuetify.breakpoint.mobile ? 290 : 350"
    @input="close(close)"
  >
    <v-card color="#FAFAFA">
      <v-card-title
        :class="
          $vuetify.breakpoint.mobile
            ? 'justify-center font-weight-bold text-subtitle-1'
            : 'justify-center font-weight-bold'
        "
      >
        <span class="mt-3">レビューを削除しますか？</span>
      </v-card-title>
      <v-card-text :class="$vuetify.breakpoint.mobile ? 'px-0' : ''">
        <v-form>
          <v-container>
            <v-row justify="center">
              <v-col
                :class="
                  $vuetify.breakpoint.mobile ? 'pb-0 text-caption' : 'pb-0'
                "
                align="center"
                cols="12"
              >
                <p>これは、元に戻すことはできません。</p>
              </v-col>
              <v-col cols="6" class="pr-0" align="center">
                <v-btn
                  large
                  :ripple="false"
                  rounded
                  depressed
                  class="font-weight-bold"
                  @click="close"
                >
                  キャンセル
                </v-btn>
              </v-col>
              <v-col cols="6" class="pl-0" align="center">
                <v-btn
                  large
                  :ripple="false"
                  color="red"
                  dark
                  depressed
                  min-width="116"
                  rounded
                  class="font-weight-bold"
                  @click="$emit('click-delete')"
                >
                  削除
                </v-btn>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
    };
  },
  methods: {
    open() {
      this.dialog = true;
    },
    close() {
      this.dialog = false;
    },
  },
};
</script>
