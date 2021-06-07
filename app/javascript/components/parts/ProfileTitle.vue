<template>
  <div :class="$vuetify.breakpoint.mobile ? 'ml-3' : ''">
    <v-list-item-title
      class="font-weight-black text-h5"
      style="margin-left: 2px;"
    >
      <v-tooltip bottom>
        <template #activator="{ on, attrs }">
          <v-icon
            v-bind="attrs"
            v-on="on"
          >
            mdi-soccer
          </v-icon>
        </template>
        プレイヤー
      </v-tooltip>
      <span style="position: relative; top: 2px;">{{ fullName }}</span>
    </v-list-item-title>
    <v-list-item-title
      class="mt-1"
    >
      <v-rating
        v-model="rating"
        background-color="#ef5350"
        color="#ef5350"
        class="mr-1 float-left"
        readonly
        dense
        :half-increments="true"
      />
      <span
        class="text-h5 font-weight-bold"
        style="position: relative; bottom: 2px;"
      >{{ rating }}</span>
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