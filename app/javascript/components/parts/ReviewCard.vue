<template>
  <v-card
    outlined
    class="mb-8"
  >
    <v-list class="pb-0">
      <v-list-item>
        <v-list-item-avatar
          size="45"
          class="mr-2"
          :style="!!reviewUserId ? 'cursor: pointer;' : ''"
          @click="pushUserPage"
        >
          <v-img
            :src="user.avatar"
          />
        </v-list-item-avatar>
        <v-list-item-content class="mt-1">
          <v-list-item-title>
            <span :class="$vuetify.breakpoint.mobile ? 'text-body-2 font-weight-bold' : 'text-body-2 font-weight-bold'">
              <span
                v-cloak
                :style="!!reviewUserId ? 'cursor: pointer;' : ''"
                @click="pushUserPage"
              >
                {{ fullName }}
              </span>
              <span v-if="user.role === 'player' && !!reviewUserId">
                さんのレビュー
              </span>
              <span v-if="user.role === 'reviewer'">
                さんへのレビュー
              </span>
            </span>
          </v-list-item-title>
          <v-list-item-subtitle
            v-if="user.role === 'reviewer'"
            class="pb-0"
          >
            <span
              class="text-caption"
              style="color: rgba(0,0,0,.6)"
            >
              {{ review.reviewee.team }} / {{ review.reviewee.position }}
            </span>
          </v-list-item-subtitle>
        </v-list-item-content>
        <v-menu
          v-if="isMyReview"
          v-model="menu"
          :close-on-content-click="false"
          left
          :nudge-left="privacySelect ? '65' : ''"
          min-width="160"
        >
          <template #activator="{ on, attrs }">
            <v-btn
              :ripple="false"
              icon
              back
              v-bind="attrs"
              v-on="on"
              @click="open"
            >
              <v-icon>
                mdi-dots-horizontal
              </v-icon>
            </v-btn>
          </template>
          <v-list
            v-if="menuSelect"
            class="py-4"
          >
            <v-list-item
              v-for="(item, index) in items"
              :key="index"
            >
              <v-list-item-title class="text-subtitle-2">
                <v-btn
                  large
                  :ripple="false"
                  block
                  text
                  class="justify-start"
                  @click="changeMenu(item.value)"
                >
                  <v-icon
                    :color="item.value === 0 ? 'red' : ''"
                    class="mr-1"
                    size="20"
                  >
                    {{ item.icon }}
                  </v-icon>
                  <span :style="item.value === 0 ? 'color: red;' : ''">
                    {{ item.title }}
                  </span>
                </v-btn>
              </v-list-item-title>
            </v-list-item>
          </v-list>
          <v-list
            v-if="privacySelect"
            min-width="225"
          >
            <v-col
              align="center"
              class="font-weight-bold"
              cols="12"
            >
              公開設定
            </v-col>
            <v-divider
              class="mb-1"
            />
            <v-list-item
              v-for="setting in settings"
              :key="setting.title"
              class="my-3"
            >
              <v-btn
                text
                class="justify-start"
                block
                large
                :value="review.privacy"
                :ripple="false"
                @click="changePrivacy(setting)"
              >
                <v-icon
                  class="mr-1"
                >
                  {{ setting.icon }}
                </v-icon>
                <span>
                  {{ setting.title }}
                </span>
                <v-spacer />
                <v-icon
                  v-if="setting.value === review.privacy"
                  color="primary"
                  class="ml-2"
                >
                  mdi-check
                </v-icon>
              </v-btn>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-list-item>
    </v-list>
    <v-card-actions class="pl-3 py-0">
      <v-rating
        :value="review.rate"
        background-color="#ef5350"
        color="#ef5350"
        readonly
        dense
      />
      <span class="ml-1 text-h6 font-weight-bold">
        {{ review.rate.toFixed(1) }}
      </span>
      <span
        v-if="!$vuetify.breakpoint.mobile"
        class="text-caption mt-1 ml-3"
        style="color: rgba(0,0,0,.6)"
      >
        試合日 {{ review.gameDate }}
      </span>
    </v-card-actions>
    <v-card-text class="mb-2 pt-1">
      <span
        v-if="$vuetify.breakpoint.mobile"
        class="text-caption"
        style="color: rgba(0,0,0,.6)"
      >
        試合日 {{ review.gameDate }}
      </span>
      <p class="mb-0 mt-2">
        {{ review.content.length >= 350 ? `${review.content.substr(0, 350)}...` : review.content }}
        <span
          v-if="review.content.length >= 350"
          class="text-caption mt-1 ml-3 blue--text text--darken-2"
          style="cursor: pointer;"
        >
          もっとみる
        </span>
      </p>
    </v-card-text>
    <the-review-delete-dialog
      ref="reviewDeleteDialog"
      @click-delete="deleteReview"
    />
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'
import TheReviewDeleteDialog from "./TheReviewDeleteDialog.vue"

export default {
  components: {
    TheReviewDeleteDialog
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
    review: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      menu: false,
      menuSelect: true,
      privacySelect: false,
      settings: [
        {
          title: "公開",
          value: "published",
          icon: "mdi-earth"
        },
        {
          title: "評価選手のみ",
          value: "player_only",
          icon: "mdi-soccer"
        }
      ]
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    isMyReview() {
      return this.review.reviewer.id === this.currentUser.id
    },
    fullName() {
      return this.user.role === 'player' ? this.review.reviewer.fullName : this.review.reviewee.fullName
    },
    reviewUserId() {
      return this.user.role === 'player' ? this.review.reviewer.id : this.review.reviewee.id
    },
    items() {
      return [
        {
          title: "削除",
          value: 0,
          icon: "mdi-delete"
        },
        {
          title: "公開設定",
          value: 1,
          icon: this.review.privacy === "published" ? "mdi-earth" : "mdi-soccer"
        }
      ]
    }
  },
  methods: {
    open() {
      this.menuSelect = true
      this.privacySelect = false
    },
    changeMenu(value) {
      switch(value) {
      case 0:
        this.menu = false
        this.$refs.reviewDeleteDialog.open()
        break
      case 1:
        this.menuSelect = false
        this.privacySelect = true
        break
      }
    },
    pushUserPage() {
      if (!this.reviewUserId) return
      if (this.currentUser.id === this.reviewUserId) {
        this.$router.push({ name: "profile" })
      } else {
        this.$router.push({ name: "userProfile", params: { userId: this.reviewUserId } })
      }
    },
    async changePrivacy(setting) {
      try {
        this.$set(this.review, 'privacy', setting.value)
        await this.$axios.patch(`/api/v1/users/current/reviews/${this.review.id}`, {
          review: this.review
        })
        this.menu = false
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: `${setting.title}に設定しました`
        })
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "もう一度選択してください"
        })
      }
    },
    async deleteReview() {
      try {
        await this.$axios.delete(`/api/v1/users/current/reviews/${this.review.id}`)
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "レビューを削除しました"
        })
        this.$refs.reviewDeleteDialog.close()
        this.$emit("delete-review", this.review)
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: "レビューを削除できませんでした"
        })
      }
    }
  }
}
</script>