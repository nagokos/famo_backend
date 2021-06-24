<template>
  <v-tabs
    color="black"
    :fixed-tabs="$vuetify.breakpoint.mobile"
    :class="$vuetify.breakpoint.mobile ? 'px-4' : ''"
    background-color="#FAFAFA"
  >
    <v-tab
      class="mr-5 font-weight-bold"
      @click="$emit('click-user')"
    >
      ユーザー情報
    </v-tab>
    <v-tab
      class="font-weight-bold"
      @click="$emit('click-review')"
    >
      レビュー一覧
    </v-tab>
  </v-tabs>
</template>