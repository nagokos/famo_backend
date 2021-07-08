<template>
  <div>
    <ValidationProvider
      v-slot="{ errors }"
      rules="required"
      name="ポジション"
      vid="position"
    >
      <v-select
        :value="position"
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
  </div>
</template>

<script>
export default {
  props: {
    position: {
      type: String,
      default: "",
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