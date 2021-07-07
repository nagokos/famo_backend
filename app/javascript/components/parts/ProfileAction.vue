<template>
  <div :style="$vuetify.breakpoint.mobile ? 'position: relative; top: 27px;' : ''">
    <!-- ログインユーザーの場合 -->
    <v-btn
      :ripple="false"
      class="font-weight-bold px-2 py-5 text-caption"
      large
      :to="{ name: 'mySetting', params: { type: 'profile' } }"
    >
      <v-icon>
        mdi-pencil-outline
      </v-icon>
      プロフィール編集
    </v-btn>
  </div>
</template>
