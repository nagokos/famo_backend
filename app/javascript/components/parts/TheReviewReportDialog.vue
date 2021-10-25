<template>
  <v-dialog
    v-model="dialog"
    width="400"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
    :persistent="true"
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
      <v-card-title class="pt-0 pb-5 justify-center font-weight-bold">
        レビューの報告
      </v-card-title>
      <v-divider />
      <v-container class="px-8">
        <v-row>
          <v-col class="pb-0">
            <v-radio-group
              v-model="radioGroup"
              hide-details
            >
              <v-radio
                v-for="item in items"
                :key="item.id"
                :label="item.body"
                :value="item.id"
              />
            </v-radio-group>
            <v-text-field 
              v-if="radioGroup === 2"
              hint="適切だと思う点数を入力してください"
            />
          </v-col>
        </v-row>
      </v-container>
      <v-card-actions class="pb-3">
        <v-spacer />
        <v-btn
          :ripple="false"
          text
          @click="close"
        >
          キャンセル
        </v-btn>
        <v-btn
          :ripple="false"
          text
          color="primary"
        >
          送信
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    review: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      dialog: false,
      radioGroup: 1,
      items: [
        {
          id: 1,
          body: "誹謗中傷、嫌がらせなど"
        },
        {
          id: 2,
          body: "評価点が不適切"
        }
      ]
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    close() {
      this.dialog = false
      Object.assign(this.$data, this.$options.data())
    }
  }
}
</script>

