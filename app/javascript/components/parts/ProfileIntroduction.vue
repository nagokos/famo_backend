<template>
  <v-col
    cols="12"
    lg="8"
  >
    <template v-if="!form">
      <p
        class="text-caption"
        style="color: #616161; overflow-wrap: break-word;"
      >
        {{ user.introduction }}
        <v-btn
          v-if="user.introduction"
          small
          text
          depressed
          color="primary"
          @click="open"
        >
          編集
        </v-btn>
        <v-btn
          v-else
          text
          depressed
          color="primary"
          @click="open"
        >
          自己紹介を追加
        </v-btn>
      </p>
    </template>
    <template v-if="form">
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
              @click="close"
            >
              キャンセル
            </v-btn>
            <v-btn
              color="primary"
              text
              @click="handleSubmit(clickUpdate)"
            >
              更新
            </v-btn>
          </v-card-actions>
        </v-card>
      </ValidationObserver>
    </template>
  </v-col>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
    introduction: {
      type: String,
      default: "",
      required: true
    }
  },
  data() {
    return {
      form: false,
    }
  },
  methods: {
    open() {
      this.form = true
      this.$emit("click-introduction")
    },
    close() {
      this.form = false
    },
    clickUpdate() {
      this.$emit("click-update")
    }
  }
}
</script>