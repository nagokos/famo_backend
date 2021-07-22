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
          style="cursor: pointer;"
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
                style="cursor: pointer;"
                @click="pushUserPage"
              >
                {{ fullName }}
              </span>
              <span v-if="user.role === 'player'">
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
  </v-card>
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
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    rate() {
      return +this.review.rate
    },
    fullName() {
      return this.user.role === 'player' ? this.review.reviewer.fullName : this.review.reviewee.fullName
    },
    reviewUserId() {
      return this.user.role === 'player' ? this.review.reviewer.id : this.review.reviewee.id
    },
  },
  methods: {
    pushUserPage() {
      if (this.currentUser.id === this.reviewUserId) {
        this.$router.push({ name: "profile" })
      } else {
        this.$router.push({ name: "userProfile", params: { userId: this.reviewUserId } })
      }
    },
  }
}
</script>