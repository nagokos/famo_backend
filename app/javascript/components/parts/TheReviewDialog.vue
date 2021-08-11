<template>
  <v-dialog
    v-model="dialog"
    width="600"
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
      <v-card-title class="pt-0 pb-5 font-weight-bold justify-center text-h5">
        レビュー
      </v-card-title>
      <v-divider />
      <ValidationObserver
        ref="observer"
        v-slot="{ handleSubmit }"
      >
        <v-card-text class="mt-3">
          <ValidationProvider
            v-slot="{ errors }"
            rules="required|max:10000"
            vid="content"
            name="本文"
          >
            <v-textarea
              v-model="review.content"
              auto-grow
              counter="10000"
              :error-messages="errors"
              placeholder="プレーはどうでしたか？(10,000文字以内)"
            />
          </ValidationProvider>
          <v-col class="pl-0 text-h6 font-weight-bold pb-0">
            評価点
          </v-col>
          <div class="text-center mt-5 mb-5">
            <v-col
              cols="12"
              class="pt-0"
            >
              <v-icon
                class="mb-2 mr-6"
                style="cursor: pointer;"
                @click="countDown"
              >
                mdi-minus-circle
              </v-icon>
              <span class="text-h5 font-weight-bold">{{ review.rate.toFixed(1) }}</span>
              <v-icon
                class="mb-2 ml-6"
                style="cursor: pointer;"
                @click="countUp"
              >
                mdi-plus-circle
              </v-icon>
            </v-col>
            <v-rating
              v-model="review.rate"
              :ripple="false"
              color="yellow darken-3"
              empty-icon="$ratingFull"
              background-color="grey darken-1"
              :half-increments="review.rate > 1"
              large
              @input="checkRate"
            />
          </div>
        </v-card-text>
        <v-divider />
        <v-card-actions class="justify-space-between">
          <!-- 試合日 -->
          <v-menu
            ref="menu"
            v-model="menu"
            top
            :close-on-content-click="false"
            transition="scale-transition"
            min-width="auto"
          >
            <template #activator="{ on, attrs }">
              <v-btn
                :ripple="false"
                color="primary"
                v-bind="attrs"
                text
                rounded
                v-on="on"
              >
                <v-icon class="mr-1">
                  mdi-calendar
                </v-icon>
                <span
                  v-if="review.gameDate === ''"
                  class="text-caption"
                >
                  試合日
                </span>
                <span
                  v-if="review.gameDate !== ''"
                  class="text-caption"
                >
                  {{ review.gameDate }}
                </span>
              </v-btn>
            </template>
            <v-date-picker
              v-model="review.gameDate"
              :max="$dayjs().format('YYYY-MM-DD')"
              min="1900-01-01"
              color="primary"
              :day-format="date => new Date(date).getDate()"
              locale="jp-ja"
            >
              <v-spacer />
              <v-btn
                text
                color="primary"
                :ripple="false"
                @click="menu = false"
              >
                キャンセル
              </v-btn>
              <v-btn
                text
                :ripple="false"
                color="primary"
                @click="$refs.menu.save(review.gameDate)"
              >
                指定
              </v-btn>
            </v-date-picker>
          </v-menu>
          <!-- プライバシー設定 -->
          <v-menu
            top
            offset-y
          >
            <template #activator="{ on, attrs }">
              <v-btn
                v-bind="attrs"
                text
                rounded
                :ripple="false"
                color="primary"
                class="ml-1"
                v-on="on"
              >
                <template v-if="review.privacy == 0">
                  <v-icon class="mr-1">
                    mdi-earth
                  </v-icon>
                  <span class="text-caption">公開</span>
                </template>
                <template v-if="review.privacy == 1">
                  <v-icon class="mr-1">
                    mdi-soccer
                  </v-icon>
                  <span class="text-caption">評価選手のみ</span>
                </template>
              </v-btn>
            </template>
            <v-list>
              <v-col
                align="center"
                class="py-1 text-caption font-weight-bold"
                cols="12"
              >
                公開設定
              </v-col>
              <v-divider
                class="mb-1"
              />
              <v-list-item
                v-for="item in items"
                :key="item.title"
              >
                <v-btn
                  text
                  class="justify-start"
                  left
                  block
                  @click="setPrivacy(item.value)"
                >
                  <v-icon
                    color="primary"
                    class="mr-1"
                    small
                  >
                    {{ item.icon }}
                  </v-icon>
                  <span class="text-caption">
                    {{ item.title }}
                  </span>
                </v-btn>
              </v-list-item>
            </v-list>
          </v-menu>
          <v-spacer />
          <v-btn
            color="primary"
            class="font-weight-bold"
            :ripple="false"
            @click="handleSubmit(sendReviewData)"
          >
            投稿
          </v-btn>
        </v-card-actions>
      </ValidationObserver>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      menu: false,
      activePicker: "",
      review: {
        content: "",
        rate: 3,
        gameDate: "",
        privacy: 0,
      },
      items: [
        {
          title: "公開",
          value: 0,
          icon: "mdi-earth"
        },
        {
          title: "評価選手のみ",
          value: 1,
          icon: "mdi-soccer"
        }
      ],
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    close() {
      Object.assign(this.$data, this.$options.data())
      this.$refs.observer.reset()
    },
    checkRate() {
      if (this.review.rate < 1) {
        this.review.rate = 1
      }
    },
    setPrivacy(value) {
      this.review.privacy = value
    },
    countUp() {
      if (this.review.rate === 5) return
      this.review.rate += 0.1
      this.review.rate = Math.round(this.review.rate * 10) / 10
    },
    countDown() {
      if (this.review.rate === 1) return
      this.review.rate -= 0.1
      this.review.rate = Math.round(this.review.rate * 10) / 10
    },
    async sendReviewData() {
      if (this.review.gameDate === "") {
        return this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "試合日を選択してください"
        })
      }
      try {
        const response = await this.$axios.post(`/api/v1/users/${this.$route.params.userId}/reviews`, {
          review: this.review
        })
        await this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "レビューを投稿しました"
        })
        this.close()
        this.$emit("create-review", response.data.review)
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
        if (!error.response.data.errors) return
        if (Object.keys(error.response.data.errors).includes("game_date")) {
          return this.$store.dispatch("flash/setFlash", {
            type: "error",
            message: "その試合日のレビューは既に存在します"
          })
        }
      }
    }
  }
}
</script>