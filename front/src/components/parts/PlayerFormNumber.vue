<template>
  <div>
    <ValidationProvider
      v-slot="{ errors }"
      rules="required|numeric"
      name="公式戦"
      vid="official_number"
    >
      <v-text-field
        :value="officialNumber"
        label="公式戦"
        background-color="#F2F4F8"
        outlined
        dense
        required
        hint="※ 必須項目です"
        persistent-hint
        type="number"
        :error-messages="errors"
        @input="$emit('update:officialNumber', $event)"
      />
    </ValidationProvider>
    <ValidationProvider
      v-slot="{ errors }"
      rules="numeric"
      name="練習試合"
      vid="practice_number"
    >
      <v-text-field
        :value="practiceNumber"
        class="mt-1"
        label="練習試合"
        outlined
        dense
        background-color="#F2F4F8"
        persistent-hint
        type="number"
        :error-messages="errors"
        @input="$emit('update:practiceNumber', $event)"
      />
    </ValidationProvider>
  </div>
</template>

<script>
export default {
  props: {
    officialNumber: {
      type: String,
      default: "",
      required: true,
    },
    practiceNumber: {
      type: String,
      default: "",
      required: false,
    },
  },
};
</script>
