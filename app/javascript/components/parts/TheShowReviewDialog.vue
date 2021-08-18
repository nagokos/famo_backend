<template>
  <v-dialog
    v-model="dialog"
    :width="review.content.length > 700 ? 600 : 500"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="$vuetify.breakpoint.mobile ? 'dialog-bottom-transition' : 'dialog-transition'"
    scrollable
  >
    <v-card outlined>
      <v-list class="pb-0">
        <v-list-item class="px-6">
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
          <v-btn
            :ripple="false"
            small
            icon
            @click="dialog = false"
          >
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-list-item>
      </v-list>
      <v-card-actions class="px-5 pt-0">
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
      <v-card-text class="pb-2">
        <span
          v-if="$vuetify.breakpoint.mobile"
          class="text-caption"
          style="color: rgba(0,0,0,.6)"
        >
          試合日 {{ review.gameDate }}
        </span>
        <p class="text-justify">
          {{ review.content }}
        </p>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
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
      dialog: false
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
  },
  methods: {
    open() {
      this.dialog = true
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
  }
}
</script>