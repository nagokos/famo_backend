<template>
  <div>
    <p
      v-if="isMypage"
      class="text-caption"
      style="color: #616161; overflow-wrap: break-word;"
    >
      {{ user.introduction }}
      <v-btn
        :small="user.introduction ? true : false"
        text
        :ripple="false"
        color="primary"
        @click="$emit('open-form')"
      >
        {{ user.introduction ? "編集" : "自己紹介を追加" }}
      </v-btn>
    </p>
    <p
      v-if="!isMypage"
      class="text-caption"
      style="color: #616161; overflow-wrap: break-word;"
    >
      {{ user.introduction ? user.introduction : `${this.fullName}です。よろしくお願いします。` }}
    </p>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  computed: {
    isMypage() {
      return this.$route.path.includes("/profile")
    },
    fullName() {
      return `${this.user.lastName}${this.user.firstName}`
    }
  }
}
</script>