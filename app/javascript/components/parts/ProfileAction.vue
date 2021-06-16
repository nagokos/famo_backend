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
    <!-- 他のユーザーの場合 -->
    <!-- <template
    >
      <v-btn
        class="mr-1"
        outlined
        color="primary"
        fab
      >
        <v-icon>
          mdi-account-plus
        </v-icon>
      </v-btn>
      <v-btn
        rounded
        x-large
        depressed
        color="primary"
        dark
        class="font-weight-bold text-capitalize"
      >
        Review
      </v-btn>
    </template> -->
  </div>
</template>