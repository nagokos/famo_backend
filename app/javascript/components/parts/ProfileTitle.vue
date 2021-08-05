<template>
  <div>
    <v-list-item-title
      class="font-weight-bold text-h5"
      style="margin-left: 2px;"
    >
      {{ fullName }}
    </v-list-item-title>
    <v-list-item-title>
      <v-rating
        :value="+user.profile.rate"
        background-color="#EF5350"
        color="#EF5350"
        class="mr-1 float-left"
        readonly
        dense
        :half-increments="true"
      />
      <span
        class="text-h5 font-weight-bold"
        style="position: relative; bottom: 2px;"
      >
        {{ user.profile.rate }}
      </span>
    </v-list-item-title>
  </div>
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
  computed: {
    fullName() {
      return `${this.user.lastName} ${this.user.firstName}`
    }
  }
}
</script>