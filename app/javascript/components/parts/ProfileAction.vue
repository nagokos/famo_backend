<template>
  <div :style="$vuetify.breakpoint.mobile ? 'position: relative; top: 27px;' : ''">
    <!-- ログインユーザーの場合 -->
    <v-btn
      :ripple="false"
      class="font-weight-bold px-2 py-5 text-caption"
      width="130"
      :to="{ name: 'mySetting', params: { type: 'profile' } }"
    >
      プロフィール編集
    </v-btn>
  </div>
</template>
