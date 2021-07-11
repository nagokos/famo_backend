<template>
  <div :style="$vuetify.breakpoint.mobile ? 'position: relative; top: 27px;' : ''">
    <!-- ログインユーザーの場合 -->
    <v-btn
      v-if="isMypage"
      :ripple="false"
      class="font-weight-bold px-2 py-5 text-caption"
      width="130"
      :to="{ name: 'mySetting', params: { type: 'profile' } }"
    >
      プロフィール編集
    </v-btn>
    <template
      v-if="!isMypage && user.role === 'player'"
    >
      <v-btn
        icon
        large
        :ripple="false"
        color="primary"
        outlined
        class="font-weight-bold px-2 py-5 text-caption mr-2"
      >
        <v-icon>
          mdi-account-plus
        </v-icon>
      </v-btn>
      <v-btn
        class="font-weight-bold text-caption px-2 py-5"
        dark
        large
        :ripple="false"
        width="130"

        color="primary"
      >
        レビューを書く
      </v-btn>
    </template>
    <template
      v-if="!isMypage && user.role === 'reviewer'"
    >
      <v-btn
        class="font-weight-bold px-2 py-5 text-capitalize"
        dark
        :ripple="false"
        color="primary"
        outlined
        width="90"
        rounded
      >
        Follow
      </v-btn>
    </template>
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
      console.log(this.user);
      return this.$route.path.includes("/profile")
    }
  }
}
</script>
