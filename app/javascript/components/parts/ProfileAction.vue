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
        v-if="!$vuetify.breakpoint.mobile"
        :ripple="false"
        :outlined="!isFollow"
        depressed
        width="120"
        color="primary"
        class="font-weight-bold px-2 py-5 text-caption mr-2"
        @click="$emit(isFollow ? 'click-unfollow' : 'click-follow')"
      >
        {{ isFollow ? 'フォロー中' : 'フォローする' }}
      </v-btn>
      <v-btn
        v-if="$vuetify.breakpoint.mobile"
        depressed
        height="40"
        :ripple="false"
        :outlined="!isFollow"
        color="primary"
        class="px-2"
        @click="$emit(isFollow ? 'click-unfollow' : 'click-follow')"
      >
        <v-icon>
          {{ isFollow ? 'mdi-account-check' : 'mdi-account-plus' }}
        </v-icon>
      </v-btn>
      <v-btn
        class="font-weight-bold px-2 py-5"
        dark
        depressed
        :ripple="false"
        :width="$vuetify.breakpoint.mobile ? 100 : 120"
        :style="$vuetify.breakpoint.mobile ? 'font-size: 10px;' : 'font-size: 12px;'"
        color="primary"
      >
        レビューを書く
      </v-btn>
    </template>
    <template
      v-if="!isMypage && user.role === 'reviewer'"
    >
      <v-btn
        :ripple="false"
        :outlined="!isFollow"
        depressed
        width="120"
        color="primary"
        class="font-weight-bold px-2 py-5 text-caption mr-2"
        @click="$emit(isFollow ? 'click-unfollow' : 'click-follow')"
      >
        {{ isFollow ? 'フォロー中' : 'フォローする' }}
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
    },
    isFollow: {
      type: Boolean,
      default: false,
      required: true
    }
  },
  computed: {
    isMypage() {
      return this.$route.path.includes("/profile")
    }
  },
}
</script>
