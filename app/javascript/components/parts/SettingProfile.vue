<template>
  <ValidationObserver
    ref="observer"
    v-slot="{ handleSubmit }"
  >
    <v-form>
      <v-container>
        <v-row>
          <v-col
            cols="12"
            md="3"
            :align="$vuetify.breakpoint.mobile ? 'center' : ''"
          >
            <v-avatar
              size="130"
              style="cursor: pointer;"
              @click="$refs.fileInput.$refs.input.click()"
            >
              <v-img
                :src="avatar"
              />
            </v-avatar>
            <br>
            <v-file-input
              ref="fileInput"
              class="d-none"
            />
          </v-col>
          <v-col
            cols="12"
            md="9"
          >
            <span
              class="font-weight-bold grey--text text--darken-1"
              :style="$vuetify.breakpoint.mobile ? 'font-size: 10px;' : 'font-size: 12px;'"
            >
              メールアドレス変更時には再度アカウント認証が必要になります
            </span>
            <ValidationProvider
              v-slot="{ errors }"
              name="性"
              vid="last_name"
              rules="required|max:30"
            >
              <v-text-field
                class="mt-3"
                :value="lastName"
                outlined
                dense
                label="性"
                required
                background-color="#F2F4F8"
                :error-messages="errors"
                @input="$emit('update:lastName', $event)"
              />
            </ValidationProvider>
            <ValidationProvider
              v-slot="{ errors }"
              name="名"
              vid="first_name"
              rules="required|max:30"
            >
              <v-text-field
                :value="firstName"
                outlined
                dense
                label="名"
                required
                background-color="#F2F4F8"
                :error-messages="errors"
                @input="$emit('update:firstName', $event)"
              />
            </ValidationProvider>
            <ValidationProvider
              v-slot="{ errors }"
              name="メールアドレス"
              vid="email"
              :rules="{
                required: true,
                formFormat: /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/i
              }"
            >
              <v-text-field
                class="mt-1"
                :value="email"
                outlined
                dense
                label="メールアドレス"
                required
                background-color="#F2F4F8"
                :error-messages="errors"
                @input="$emit('update:email', $event)"
              />
            </ValidationProvider>
            <ValidationProvider
              v-slot="{ errors }"
              rules="max:400"
              vid="introduction"
              name="自己紹介"
            >
              <v-textarea
                class="mt-1"
                :value="introduction"
                outlined
                dense
                label="自己紹介"
                counter="400"
                background-color="#F2F4F8"
                :error-messages="errors"
                @input="$emit('update:introduction', $event)"
              />
            </ValidationProvider>
          </v-col>
          <v-col
            cols="12"
            class="pt-0"
          >
            <v-btn
              color="#3949AB"
              class="font-weight-bold mt-1"
              large
              dark
              block
              :ripple="false"
              @click="handleSubmit(clickUpdate)"
            >
              更新する
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-form>
  </ValidationObserver>
</template>

<script>
export default {
  props: {
    avatar: {
      type: String,
      default: "",
      required: true
    },
    lastName: {
      type: String,
      default: "",
      required: true
    },
    firstName: {
      type: String,
      default: "",
      required: true
    },
    email: {
      type: String,
      default: "",
      required: true
    },
    introduction: {
      type: String,
      default: "",
      required: false
    }
  },
  methods: {
    clickUpdate() {
      this.$emit("click-update")
    },
    setErrors(errors) {
      this.$refs.observer.setErrors(errors)
    }
  }
}
</script>
