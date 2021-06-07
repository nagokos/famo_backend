<template>
  <v-speed-dial
    v-model="fab"
    bottom
    fixed
    right
  >
    <template #activator>
      <v-btn
        v-model="fab"
        fab
        bottom
        right
        dark
        x-large
        color="#EF5350"
      >
        <v-icon v-if="fab">
          mdi-close
        </v-icon>
        <v-icon v-else>
          mdi-account-circle
        </v-icon>
      </v-btn>
    </template>
    <v-btn
      fab
      dark
      color="green"
    >
      <v-icon>mdi-pencil</v-icon>
    </v-btn>
    <v-btn
      fab
      dark
      outlined
      color="primary"
    >
      <v-icon>mdi-account-plus</v-icon>
    </v-btn>
  </v-speed-dial>
</template>

<script>
export default {
  data() {
    return {
      fab: false
    }
  }
}
</script>