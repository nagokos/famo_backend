<template>
  <v-card
    outlined
    class="mb-8"
  >
    <v-card-title>
      <v-avatar
        class="mr-4"
        style="cursor: pointer;"
        @click="pushUserPage"
      >
        <v-img
          :src="user.avatar"
        />
      </v-avatar>
      <span
        class="font-weight-bold text-subtitle-1"
        style="cursor: pointer;"
        @click="pushUserPage"
      >
        {{ fullName }}
      </span>
    </v-card-title>
    <v-card-text class="pb-0">
      <p class="mb-0">
        {{ review.content }}
      </p>
    </v-card-text>
    <v-card-actions class="mr-4 mb-2">
      <v-spacer />
      <v-rating
        v-model="rate"
        align="right"
        background-color="#ef5350"
        color="#ef5350"
        small
        readonly
        dense
      />
      <span
        class="mt-1 ml-1 font-weight-bold"
      >
        {{ review.rate }}
      </span>
    </v-card-actions>
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