<template>
  <div :style="$vuetify.breakpoint.mobile ? '' : 'max-width: 290px;'">
    <v-card outlined>
      <v-card-text class="pb-0 mt-2 ml-1 font-weight-bold black--text text-subtitle-1">
        並び替え
      </v-card-text>
      <v-card-text class="py-0 ml-1 mb-1">
        <v-radio-group
          mandatory
          :value="sort"
        >
          <v-radio
            v-for="order in orders"
            :key="order.name"
            :label="order.name"
            :value="order.value"
            @click="sortChange(order.value)"
          />
        </v-radio-group>
      </v-card-text>
    </v-card>
    <v-card
      color="#f1f4f8"
      outlined
      class="mt-6"
    >
      <v-card-text>
        <v-icon color="primary">
          mdi-calendar-today
        </v-icon>
        <span
          class="font-weight-bold black--text"
          style="position: relative; top: 1px;"
        >
          試合日を指定
        </span>
      </v-card-text>
    </v-card>
    <v-dialog
      ref="dialog"
      v-model="dialog"
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
        :day-format="date => new Date(date).getDate()"
        locale="jp-ja"
        :allowed-dates="allowedDates"
        @input="$emit('update:gameDate', $event)"
      >
        <v-spacer />
        <v-btn
          text
          color="primary"
          :ripple="false"
          @click="cancel"
        >
          キャンセル
        </v-btn>
        <v-btn
          text
          color="primary"
          :ripple="false"
          @click="dialog = false"
        >
          指定
        </v-btn>
      </v-date-picker>
    </v-dialog>
    <span
      class="text-caption"
      style="color: rgba(0, 0, 0, .6)"
    >※レビューのある日のみ選択できます</span>
    <v-btn
      block
      dark
      large
      class="font-weight-bold mt-3"
      color="#3949AB"
      :ripple="false"
      @click="clickSearch"
    >
      検索する
    </v-btn>
  </div>
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
      default: () => {""},
      required: true
    }
  },
  data() {
    return {
      dialog: false,
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
    sortChange(value) {
      this.$emit("update:sort", value)
      this.$emit("search")
    },
    clickSearch() {
      this.$emit("search")
    },
    cancel() {
      this.$emit("update:gameDate", "")
      this.dialog = false
    },
    allowedDates(val) {
      return this.gameDates.includes(val)
    }
  }
}
</script>