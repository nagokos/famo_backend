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
      <span class="mt-1 ml-1 font-weight-bold">{{ rating }}</span>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      rating: 3.1
    }
  },
  computed: {
    fullName() {
      return `${this.user.last_name} ${this.user.first_name}`
    }
  }
}
</script>