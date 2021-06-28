<template>
  <v-col cols="12">
    <span
      class="font-weight-bold text-h6 black--text"
    >
      ポジション編集
    </span>
    <ValidationProvider
      v-slot="{ errors }"
      rules="required"
      name="ポジション"
    >
      <v-select
        :value="position"
        class="mt-4"
        outlined
        dense
        label="ポジション"
        :items="positions"
        required
        background-color="#F2F4F8"
        :error-messages="errors"
        @change="$emit('update:position', $event)"
      />
    </ValidationProvider>
  </v-col>
</template>

<script>
export default {
  props: {
    position: {
      type: String,
      default: "GK",
      required: true
    }
  },
  data() {
    return {
      positions: ["GK", "DF", "MF", "FW"]
    }
  }
}
</script>