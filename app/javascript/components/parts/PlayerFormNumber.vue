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
        hint="公式戦での背番号を入力して下さい"
        persistent-hint
        type="number"
        :error-messages="errors"
        @input="$emit('update:officialNumber', $event)"
      />
    </ValidationProvider>
    <ValidationProvider
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
        hint="練習試合での背番号を入力して下さい"
        persistent-hint
        type="number"
        @input="$emit('update:practiceNumber', $event)"
      />
    </ValidationProvider>
  </div>
</template>

<script>
export default {
  props: {
    officialNumber: {
      type: [Number, String],
      default: "",
      required: true
    },
    practiceNumber: {
      type: [Number, String],
      default: "",
      required: false
    }
  }
}
</script>