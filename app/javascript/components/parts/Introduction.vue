<template>
  <p
    class="text-caption"
    style="color: #616161; overflow-wrap: break-word;"
  >
    {{ user.introduction }}
    <v-btn
      :small="user.introduction !== ''"
      text
      color="primary"
      @click="$emit('open-form')"
    >
      {{ user.introduction ? "編集" : "自己紹介を追加" }}
    </v-btn>
  </p>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  }
}
</script>