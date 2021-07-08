<template>
  <v-card
    outlined
    class="mb-8"
  >
    <v-card-title>
      <v-avatar class="mr-4">
        <v-img
          :src="user.avatar"
        />
      </v-avatar>
      <v-icon
        small
        class="mr-1"
      >
        mdi-soccer
      </v-icon>
      <span class="font-weight-bold text-subtitle-1">{{ fullName }}</span>
    </v-card-title>
    <v-card-text class="pb-0">
      <p class="mb-0">
        とても良いプレーでした。とても良いプレーでしたとても良いプレとても良いプレーでした
      </p>
    </v-card-text>
    <v-card-actions class="mr-4 mb-2">
      <v-spacer />
      <v-rating
        v-model="rating"
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