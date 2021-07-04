<template>
  <v-tabs
    background-color="#FAFAFA"
    @change="$emit('data-reset', $event)"
  >
    <v-tab
      v-for="setting in settings"
      :key="setting.params"
      :to="{ name: 'mySetting', params: { type: setting.params } }"
      class="font-weight-bold"
    >
      {{ setting.name }}
    </v-tab>
  </v-tabs>
</template>

<script>
export default {
  data() {
    return {
      settings: [
        {
          name: "プロフィール",
          params: "profile"
        },
        {
          name: "選手登録",
          params: "player"
        }
      ]
    }
  }
}
</script>