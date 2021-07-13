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
        :ripple="false"
        rounded
        :outlined="!isFollow"
        depressed
        width="80"
        color="primary"
        class="font-weight-bold px-2 py-5 text-caption mr-2 text-capitalize"
        @click="$emit(isFollow ? 'click-unfollow' : 'click-follow')"
      >
       {{ isFollow ? 'Following' : 'Follow' }}
      </v-btn>
      <v-btn
        class="font-weight-bold text-caption px-2 py-5"
        dark
        :ripple="false"
        width="120"
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
        rounded
        :outlined="!isFollow"
        depressed
        width="80"
        color="primary"
        class="font-weight-bold px-2 py-5 text-caption mr-2 text-capitalize"
        @click="$emit(isFollow ? 'click-unfollow' : 'click-follow')"
      >
       {{ isFollow ? 'Following' : 'Follow' }}
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
