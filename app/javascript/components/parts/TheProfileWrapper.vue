<template>
  <div>
    <div
      class="contents"
    >
      <v-list
        color="#FAFAFA"
      >
        <v-list-item>
          <!-- アバター -->
          <v-list-item-avatar
            size="110"
          >
            <v-img
              :src="user.avatar"
            />
          </v-list-item-avatar>
          <!-- タイトル -->
          <v-list-item-content>
            <profile-title
              v-if="!$vuetify.breakpoint.mobile"
              class="mt-6 py-0"
              :user="user"
            />
          </v-list-item-content>
          <profile-action
            :user="user"
            :isFollow="isFollow"
            :class="{ 'mt-6': !$vuetify.breakpoint.mobile }"
            @click-follow="$emit('click-follow')"
            @click-unfollow="$emit('click-unfollow')"
          />
        </v-list-item>
        <profile-title
          v-if="$vuetify.breakpoint.mobile"
          class="ml-3"
          :user="user"
        />
      </v-list>
      <v-container class="px-4 pt-0">
        <v-row>
          <v-col
            cols="12"
            lg="8"
          >
            <!-- 自己紹介文 -->
            <introduction
              v-if="!introductionForm"
              :user="user"
              @open-form="openIntroduction"
            />
            <!-- 自己紹介編集 -->
            <introduction-edit
              v-if="introductionForm"
              ref="introductionEdit"
              :introduction.sync="userEdit.introduction"
              @send-introduction="$emit('update-introduction', userEdit)"
              @close-form="closeIntroduction"
            />
          </v-col>
          <v-col
            v-if="user.role === 'player' && !$vuetify.breakpoint.mobile"
            cols="4"
          >
            <!-- 選手テーブル -->
            <player-table
              :profile="user.profile"
            />
          </v-col>
        </v-row>
      </v-container>
    </div>
    <div
      class="mx-auto"
      style="max-width: 1018px;"
    >
      <v-divider />
      <!-- タブ -->
      <profile-tab />
    </div>
    <v-divider />
    <div
      class="contents mt-5"
    >
      <v-container>
        <v-row>
          <!-- 選手カード -->
          <v-col
            v-if="!isRelation"
            cols="12"
            md="4"
          />
          <v-col
            v-if="!isRelation"
            cols="12"
            md="8"
          >
            <review-card
              :user="user"
            />
          </v-col>
          <relation-card
            v-if="isRelation"
            :user="user"
          />
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
import ProfileAction from "../parts/ProfileAction"
import ProfileTitle from "../parts/ProfileTitle"
import PlayerTable from "../parts/PlayerTable"
import Introduction from '../parts/Introduction.vue'
import IntroductionEdit from '../parts/IntroductionEdit.vue'
import ProfileTab from "../parts/ProfileTab"
import ReviewCard from "../parts/ReviewCard"
import RelationCard from "../parts/RelationCard"

export default {
  components: {
    PlayerTable,
    ProfileAction,
    ProfileTitle,
    Introduction,
    IntroductionEdit,
    ProfileTab,
    ReviewCard,
    RelationCard,
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
    isFollow: {
      type: Boolean,
      default: false,
      required: false
    }
  },
  data() {
    return {
      introductionForm: false,
      userEdit: { ...this.user }
    }
  },
  computed: {
    isRelation() {
      return this.$route.path.includes('/relation')
    }
  },
  methods: {
    openIntroduction() {
      this.introductionForm = true
      this.userEdit = { ...this.user }
    },
    closeIntroduction() {
      this.introductionForm = false
    },
    introductionErrors(errors) {
      this.$refs.introductionEdit.setErrors(errors)
    }
  }
}
</script>

<style scoped>
  .contents {
    max-width: 1050px;
    margin: 0 auto;
  }
</style>