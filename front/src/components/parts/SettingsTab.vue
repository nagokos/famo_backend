<template>
  <v-tabs background-color="#FAFAFA" @change="$emit('data-reset', $event)">
    <v-tab
      v-for="route in routes"
      :key="route.params"
      :ripple="false"
      exact
      :to="{ name: 'mySetting', params: { type: route.params } }"
      class="font-weight-bold"
    >
      {{ route.name }}
    </v-tab>
  </v-tabs>
</template>

<script>
export default {
  data() {
    return {
      routes: [
        {
          name: "アカウント",
          params: "account",
        },
        {
          name: "プロフィール",
          params: "profile",
        },
        {
          name: "選手登録",
          params: "player",
        },
      ],
    };
  },
};
</script>

<style scoped>
.v-tabs >>> .v-slide-group__prev {
  display: none !important;
}
</style>
