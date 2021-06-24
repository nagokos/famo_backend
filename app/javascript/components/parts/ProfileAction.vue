<template>
  <div :style="$vuetify.breakpoint.mobile ? 'position: relative; top: 27px;' : ''">
    <!-- ログインユーザーの場合 -->
    <v-btn
      rounded
      class="font-weight-bold px-2 py-5 text-caption"
      outlined
      x-large
      color="primary"
      @click="$emit('click-edit')"
    >
      <v-icon>
        mdi-pencil-outline
      </v-icon>
      プロフィール編集
    </v-btn>
  </div>
</template>
