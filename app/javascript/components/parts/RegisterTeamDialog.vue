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
        class="pt-0 pb-5 font-weight-bold justify-center text-h5"
      >
        チーム登録
      </v-card-title>
      <v-divider />
      <v-card-text>
        <ValidationObserver
          ref="observer"
          v-slot="{ handleSubmit }"
        >
          <v-form ref="form">
            <v-container>
              <v-row>
                <v-col
                  class="mt-3"
                  cols="12"
                >
                  <span
                    class="font-weight-bold black--text"
                    :style="$vuetify.breakpoint.mobile ? 'font-size: 10px;' : 'font-size: 12px'"
                  >
                    ＊大会に記載しているチーム名で登録してください。
                    <br>
                    ＊〇〇高校、〇〇U-18、〇〇ユースの形で登録してください。
                    <br>
                    ＊2nd、3rdなどの区別はしないでください。
                  </span>
                </v-col>
                <v-col cols="12">
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="required"
                    name="都道府県"
                    vid="prefecture"
                  >
                    <v-select
                      v-model="team.prefectureId"
                      outlined
                      dense
                      label="都道府県"
                      required
                      :items="prefectures"
                      item-value="id"
                      item-text="name"
                      background-color="#F2F4F8"
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="required"
                    vid="name"
                    name="チーム"
                  >
                    <v-text-field
                      v-model="team.name"
                      outlined
                      dense
                      required
                      label="チーム"
                      background-color="#F2F4F8"
                      :error-messages="errors"
                    />
                  </ValidationProvider>
                </v-col>
                <v-col
                  cols="12"
                  class="pt-0"
                >
                  <ValidationProvider
                    v-slot="{ errors }"
                    rules="required"
                    name="選択"
                    vid="kind"
                  >
                    <v-select
                      v-model="team.kind"
                      outlined
                      dense
                      label="選択"
                      :items="kinds"
                      item-value="id"
                      item-text="name"
                      required
                      background-color="#F2F4F8"
                      :error-messages="errors"
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
                    @click="handleSubmit(sendTeamData)"
                  >
                    登録する
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
  props: {
    prefectures: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      dialog: false,
      team: {
        prefectureId: "",
        name: "",
        kind: "",
      },
      kinds: [
        {
          id: 0,
          name: "高体連"
        },
        {
          id: 1,
          name: "ユースチーム"
        }
      ]
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    close() {
      this.$refs.form.reset()
      this.$refs.observer.reset()
      this.dialog = false
    },
    async sendTeamData() {
      try {
        const response = await this.$axios.post("/api/v1/teams", {
          team: this.team
        })
        this.$refs.form.reset()
        this.dialog = false
        this.$emit("create-team", response.data)
      } catch(err) {
        this.$refs.observer.setErrors(err.response.data.errors)
      }
    }
  }
}
</script>