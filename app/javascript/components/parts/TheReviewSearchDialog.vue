<template>
  <v-dialog
    v-model="dialog"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
  >
    <v-card color="#FAFAFA">
      <v-btn
        icon
        :ripple="false"
        @click="dialog = false"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
      <v-card-title class="font-weight-bold px-9 pb-0">
        並び替え
        <v-spacer />
        <v-btn
          :ripple="false"
          small
          class="font-weight-bold"
          @click="resetSearch"
        >
          すべてクリア
        </v-btn>
      </v-card-title>
      <v-card-text class="px-9 pb-0">
        <v-radio-group
          mandatory
          hide-details
          :value="sort"
        >
          <v-radio
            v-for="order in orders"
            :key="order.name"
            :label="order.name"
            :value="order.value"
            class="mb-4"
            @click="$emit('update:sort', order.value)"
          />
        </v-radio-group>
      </v-card-text>
      <v-card-title class="font-weight-bold px-9 pb-0">
        試合日を指定
      </v-card-title>
      <v-card-text class="px-9 pb-0">
        <v-dialog
          ref="dialog"
          v-model="dateDialog"
          fullscreen
          width="290px"
        >
          <template #activator="{ on, attrs }">
            <v-text-field
              :value="gameDate"
              class="mt-4"
              readonly
              placeholder="試合日"
              outlined
              dense
              hide-details
              :append-icon="gameDate === '' ? '' : 'mdi-close'"
              background-color="white"
              v-bind="attrs"
              @click:append="$emit('update:gameDate', '')"
              v-on="on"
            />
          </template>
          <v-date-picker
            :value="gameDate"
            :max="$dayjs().format('YYYY-MM-DD')"
            color="primary"
            min="1900-01-01"
            full-width
            :day-format="date => new Date(date).getDate()"
            locale="jp-ja"
            @input="$emit('update:gameDate', $event)"
          >
            <v-spacer />
            <v-btn
              text
              color="primary"
              :ripple="false"
              @click="dateCancel"
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
        <v-btn
          class="font-weight-bold mt-7"
          dark
          block
          large
          :ripple="false"
          color="#3949AB"
          @click="reviewFilter"
        >
          適用する
        </v-btn>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    sort: {
      type: String,
      default: "created",
      required: true
    },
    gameDate: {
      type: String,
      default: "",
      required: true
    },
    gameDates: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      dialog: false,
      dateDialog: false,
      menu: false,
      orders: [
        {
          name: "投稿日順",
          value: "created"
        },
        {
          name: "試合日順(新)",
          value: "new_game"
        },
        {
          name: "試合日順(古)",
          value: "old_game"
        },
        {
          name: "評価点順",
          value: "rating"
        }
      ]
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    dateCancel() {
      this.$emit("update:gameDate", "")
      this.dateDialog = false
    },
    reviewFilter() {
      this.$emit("search")
      this.dialog = false
    },
    resetSearch() {
      this.$emit("update:sort", "created")
      this.$emit("update:gameDate", "")
    }
  }
}
</script>