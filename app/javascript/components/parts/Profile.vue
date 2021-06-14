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
          @click-edit="$emit('click-edit')"
          :user="user"
        />
      </v-list-item>
      <profile-title
        class="ml-3"
        v-if="$vuetify.breakpoint.mobile"
        :user="user"
      />
    </v-list>
    <!-- 自己紹介文 -->
    <v-container class="px-4 pt-0">
      <v-row>
        <v-col
          cols="12"
          lg="8"
        >
          <p
            class="text-caption"
            style="color: #616161;"
          >
            {{ user.introduction }}
          </p>
        </v-col>
        <v-col
        class="pl-10"
          v-if="!$vuetify.breakpoint.mobile"
          cols="4"
        >
          <profile-card />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import ProfileAction from "./ProfileAction"
import ProfileTitle from "./ProfileTitle"
import ProfileCard from "./ProfileCard"

export default {
  components: {
    ProfileAction,
    ProfileTitle,
    ProfileCard
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
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