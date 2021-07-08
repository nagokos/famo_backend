<template>
  <ValidationObserver
    ref="observer"
    v-slot="{ handleSubmit }"
  >
    <v-card outlined>
      <v-card-text class="py-0">
        <v-form>
          <ValidationProvider
            v-slot="{ errors }"
            rules="max:400"
            name="自己紹介"
            vid="introduction"
          >
            <v-textarea
              :value="introduction"
              counter="400"
              :error-messages="errors"
              @input="$emit('update:introduction', $event)"
            />
          </ValidationProvider>
        </v-form>
      </v-card-text>
      <v-card-actions class="pt-0">
        <v-spacer />
        <v-btn
          color="primary"
          text
          :ripple="false"
          @click="$emit('close-form')"
        >
          キャンセル
        </v-btn>
        <v-btn
          color="primary"
          text
          :ripple="false"
          @click="handleSubmit(sendIntroduction)"
        >
          更新
        </v-btn>
      </v-card-actions>
    </v-card>
  </ValidationObserver>
</template>

<script>
export default {
  props: {
    introduction: {
      type: String,
      default: "",
      required: false
    }
  },
  methods: {
    sendIntroduction() {
      this.$emit("send-introduction")
    },
    setErrors(errors) {
      this.$refs.observer.setErrors(errors)
    }
  }
}
</script>