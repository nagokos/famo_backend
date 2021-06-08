<template>
  <div class="profile-top">
    <v-list
      color="#FAFAFA"
    >
      <v-list-item>
        <!-- モバイル用アバター -->
        <v-badge
          v-if="$vuetify.breakpoint.mobile"
          bottom
          icon="mdi-pencil-outline"
          dark
          overlap
          color="success"
          offset-x="38"
          offset-y="35"
        >
          <v-list-item-avatar
            size="110"
            class="ml-n1"
          >
            <v-img
              :src="user.avatar"
            />
          </v-list-item-avatar>
        </v-badge>
        <!-- PC用アバター -->
        <v-list-item-avatar
          v-if="!$vuetify.breakpoint.mobile"
          size="100"
        >
          <v-img
            :src="user.avatar"
          />
        </v-list-item-avatar>
        <v-list-item-content class="mt-2">
          <profile-title
            v-if="!$vuetify.breakpoint.mobile"
            :user="user"
          />
          <profile-card
            v-if="$vuetify.breakpoint.mobile"
          />
        </v-list-item-content>
        <!-- プロフィールアクション -->
        <profile-action
          :user="user"
        />
      </v-list-item>
      <profile-title
        v-if="$vuetify.breakpoint.mobile"
        :user="user"
      />
    </v-list>
    <!-- 自己紹介文 -->
    <v-container class="px-4 pt-0">
      <v-row>
        <v-col
          cols="12"
          lg="9"
        >
          <p
            class="text-caption"
            style="color: #616161;"
          >
            〇〇高校の中山太郎です。MFでプレイしています。。よろしくお願いします。
          </p>
        </v-col>
        <v-col
          v-if="!$vuetify.breakpoint.mobile"
          cols="3"
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