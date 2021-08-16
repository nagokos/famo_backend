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
      <v-card-title class="font-weight-bold px-9">
        絞り込み
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
      <v-card-text>
        <v-container>
          <v-row>
            <v-col
              class="font-weight-bold pb-1"
              cols="12"
            >
              ポジション
            </v-col>
            <v-col
              class="py-0"
              cols="12"
            >
              <v-select
                v-model="positionData"
                outlined
                dense
                :items="positions"
                item-text="name"
                item-value="value"
              />
            </v-col>
            <v-col
              class="font-weight-bold pt-0 pb-1"
              cols="12"
            >
              チーム
            </v-col>
            <v-col
              class="py-0"
              cols="12"
            >
              <v-select
                v-model="teamData"
                outlined
                dense
                :items="teams"
                item-value="id"
                item-text="name"
              />
            </v-col>
            <v-col cols="12">
              <v-btn
                class="font-weight-bold"
                dark
                block
                large
                color="#3949AB"
                @click="searchPlayer"
              >
                検索する
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    teams: {
      type: Array,
      default: () => {},
      required: true
    },
    teamId: {
      type: [String, Number],
      default: () => {},
      required: true
    },
    position: {
      type: [String, Number],
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      dialog: false,
      teamData: this.teamId,
      positionData: this.position,
      positions: [
        {
          name: "指定なし",
          value: ""
        },
        {
          name: "GK",
          value: 0
        },
        {
          name: "DF",
          value: 1
        },
        {
          name: "MF",
          value: 2
        },
        {
          name: "FW",
          value: 3
        }
      ]
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    close() {
      this.teamData = this.teamId,
      this.positionData = this.position,
      this.dialog = false
    },
    searchPlayer() {
      this.$emit("update:teamId", this.teamData)
      this.$emit("update:position", this.positionData)
      this.dialog = false
      this.$emit("search-player")
    },
    resetSearch() {
      this.positionData = ""
      this.teamData = ""
    },
  }
}
</script>