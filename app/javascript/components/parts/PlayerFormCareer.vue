<template>
  <div>
    <ValidationProvider
      v-slot="{ errors }"
      rules="max:50"
      name="前所属"
      vid="career"
    >
      <v-text-field
        :value="career"
        outlined
        dense
        label="前所属"
        background-color="#F2F4F8"
        hint="中学生での所属チーム"
        persistent-hint
        :error-messages="errors"
        @input="$emit('update:career', $event)"
      />
    </ValidationProvider>
  </div>
</template>

<script>
export default {
  props: {
    career: {
      type: String,
      default: "",
      required: false
    }
  }
}
</script>