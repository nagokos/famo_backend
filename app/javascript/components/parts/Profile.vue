<template>
  <div class="profile-top">
    <v-list
      color="#FAFAFA"
    >
      <v-list-item>
        <!-- アバター -->
        <v-list-item-avatar
          :size="$vuetify.breakpoint.mobile ? '110' : '100'"
        >
          <v-img
            :src="user.avatar"
          />
        </v-list-item-avatar>
        <v-list-item-content>
          <profile-title
            v-if="!$vuetify.breakpoint.mobile"
            class="ml-3"
            :user="user"
          />
        </v-list-item-content>
        <!-- プロフィールアクション -->
        <profile-action
          :user="user"
          @click-edit="$emit('click-edit')"
        />
      </v-list-item>
      <profile-title
        v-if="$vuetify.breakpoint.mobile"
        class="ml-3"
        :user="user"
      />
    </v-list>
    <!-- 自己紹介文 -->
    <v-container class="px-4 pt-0">
      <v-row>
        <profile-introduction
          ref="profileIntroduction"
          :user="user"
          v-bind.sync="userEdit"
          @click-introduction="$emit('click-introduction')"
          @click-update="$emit('click-update')"
        />
        <profile-card
          v-if="!$vuetify.breakpoint.mobile"
          :profile="profile"
          @click-player="$emit('click-player')"
        />
      </v-row>
    </v-container>
  </div>
</template>

<script>
import ProfileAction from "./ProfileAction"
import ProfileTitle from "./ProfileTitle"
import ProfileCard from "./ProfileCard"
import ProfileIntroduction from './ProfileIntroduction.vue'

export default {
  components: {
    ProfileAction,
    ProfileTitle,
    ProfileCard,
    ProfileIntroduction
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
    userEdit: {
      type: Object,
      default: () => {},
      required: true
    },
    profile: {
      type: Object,
      default: () => {},
      required: false
    }
  },
  methods: {
    close() {
      this.$refs.profileIntroduction.close()
    }
  }
}
</script>

<style scoped>
  .profile-top {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>