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
          :style="!!reviewUser ? 'cursor: pointer;' : ''"
          @click="pushUserPage"
        >
          <v-img
            :src="user.avatar"
          />
        </v-list-item-avatar>
        <v-list-item-content class="mt-1">
          <v-list-item-title :class="$vuetify.breakpoint.mobile ? 'mb-0' : ''">
            <span :class="$vuetify.breakpoint.mobile ? 'text-caption font-weight-bold' : 'text-body-2 font-weight-bold'">
              <span
                v-cloak
                :style="!!reviewUser ? 'cursor: pointer;' : ''"
                @click="pushUserPage"
              >
                {{ fullName }}
              </span>
              <span v-if="user.role === 'player' && !!reviewUser">
                さんのレビュー
              </span>
              <span v-if="user.role === 'reviewer'">
                {{ `さんへのレビュー・${relativeTime}` }}
              </span>
            </span>
          </v-list-item-title>
          <v-list-item-subtitle
            v-if="user.role === 'player'"
            class="pb-0"
          >
            <span
              class="text-caption"
              style="color: rgba(0,0,0,.6)"
            >
              {{ relativeTime }}
            </span>
          </v-list-item-subtitle>
          <v-list-item-subtitle
            v-if="user.role === 'reviewer'"
            class="pb-0"
          >
            <span
              class="text-caption"
              style="color: rgba(0,0,0,.6)"
            >
              {{ review.reviewee.profile.team }}({{ review.reviewee.profile.prefecture.name }}) / {{ review.reviewee.profile.position }}
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
        :value="+review.rate"
        background-color="#ef5350"
        color="#ef5350"
        readonly
        dense
        half-increments
      />
      <span class="ml-1 text-h6 font-weight-bold">
        {{ review.rate }}
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
          @click="$refs.showReviewDialog.open()"
        >
          もっとみる
        </span>
      </p>
    </v-card-text>
    <the-review-delete-dialog
      ref="reviewDeleteDialog"
      @click-delete="deleteReview"
    />
    <the-show-review-dialog
      ref="showReviewDialog"
      :user="user"
      :review="review"
    />
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'
import TheReviewDeleteDialog from "./TheReviewDeleteDialog"
import TheShowReviewDialog from "./TheShowReviewDialog"

export default {
  components: {
    TheReviewDeleteDialog,
    TheShowReviewDialog
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
    relativeTime() {
      return this.$dayjs(this.review.createdAt).fromNow()
    },
    isMyReview() {
      if (!this.reviewUser) return
      return this.review.reviewer.id === this.currentUser.id
    },
    fullName() {
      if (!this.reviewUser) return "退会したユーザー"
      return this.user.role === 'player' ? `${this.review.reviewer.lastName} ${this.review.reviewer.firstName}` :
                                           `${this.review.reviewee.lastName} ${this.review.reviewee.firstName}`
    },
    reviewUser() {
      return this.user.role === 'player' ? this.review.reviewer : this.review.reviewee
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
      if (!this.reviewUser) return
      if (this.currentUser.id === this.reviewUser.id) return this.$router.push({ name: "myReview" })
      if (this.reviewUser.role === "player") {
        const leagueEigo = this.leagueNameEigo(this.reviewUser.profile.league.name)
        this.$router.push({
          name: "playerReview",
          params: { league: leagueEigo, categoryId: this.reviewUser.profile.category.id, groupId: this.reviewUser.profile.groupId, userId: this.reviewUser.id }
        })
      } else {
        this.$router.push({ name: "reviewerReview", params: { userId: this.reviewUser.id } })
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