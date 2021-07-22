<template>
  <v-app-bar
    app
    flat
    color="#3949AB"
  >
    <v-toolbar
      max-width="1050"
      flat
      color="#3949AB"
      class="mx-auto"
    >
      <v-toolbar-title
        class="font-weight-bold text-h5"
        style="color: white; cursor: pointer;"
        @click="pushPage('/', 'top')"
      >
        Famo
      </v-toolbar-title>
      <v-spacer />
      <v-toolbar-items class="align-center">
        <v-btn
          v-if="!currentUser"
          text
          :ripple="false"
          @click="pushPage('/login', 'login')"
        >
          <span
            class="text-caption"
            style="color: white;"
          >
            登録 ｜ ログイン
          </span>
        </v-btn>
        <v-icon
          v-if="currentUser"
          color="#FAFAFA"
          class="mr-6"
          size="27"
        >
          mdi-magnify
        </v-icon>
        <v-icon
          v-if="currentUser"
          color="#FAFAFA"
          class="mr-6"
          size="27"
        >
          mdi-bell-outline
        </v-icon>
        <v-menu
          v-if="currentUser"
          left
          offset-y
        >
          <template #activator="{ on, attrs }">
            <v-avatar
              v-bind="attrs"
              v-on="on"
            >
              <v-img
                :src="currentUser.avatar"
                max-height="40"
                max-width="40"
              />
            </v-avatar>
          </template>
          <v-list
            min-width="240"
            class="py-0"
          >
            <v-col cols="12">
              <v-btn
                text
                block
                large
                :ripple="false"
                class="justify-start"
                @click="pushPage('/profile', 'profile')"
              >
                <v-avatar
                  style="position: relative; right: 5px;"
                  size="36"
                >
                  <v-img
                    color="#5b7083"
                    :src="currentUser.avatar"
                  />
                </v-avatar>
                <span class="ml-2 mt-1 font-weight-bold">{{ fullName }}</span>
              </v-btn>
            </v-col>
            <v-divider />
            <v-col cols="12">
              <v-btn
                text
                block
                large
                :ripple="false"
                class="justify-start"
                @click="pushPage('/settings/account', 'mySetting', 'account')"
              >
                <v-icon
                  class="mr-2"
                  color="#5b7083"
                >
                  mdi-cog
                </v-icon>
                <span class="text-caption font-weight-bold">
                  アカウント設定
                </span>
              </v-btn>
            </v-col>
            <v-col
              cols="12"
              class="pt-0"
            >
              <v-btn
                text
                block
                large
                :ripple="false"
                class="justify-start"
              >
                <v-icon
                  class="mr-2"
                  color="#5b7083"
                >
                  mdi-comment-question
                </v-icon>
                <span class="text-caption font-weight-bold">
                  お問い合わせ
                </span>
              </v-btn>
            </v-col>
            <v-col
              cols="12"
              class="pt-0"
            >
              <v-btn
                text
                block
                large
                :ripple="false"
                class="justify-start"
                @click="logout"
              >
                <v-icon
                  class="mr-2"
                  color="#5b7083"
                >
                  mdi-logout
                </v-icon>
                <span class="text-caption font-weight-bold">
                  ログアウト
                </span>
              </v-btn>
            </v-col>
          </v-list>
        </v-menu>
      </v-toolbar-items>
    </v-toolbar>
  </v-app-bar>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    fullName() {
      return `${this.currentUser.lastName} ${this.currentUser.firstName}`
    }
  },
  methods: {
    pushPage(path, route, params) {
      if (this.$route.path !== path) {
        this.$router.push({ name: route, params: { type: params } })
      }
    },
    async logout() {
      await this.$store.dispatch("user/logout")
      localStorage.logout = 1
      location.href = "/"
    }
  }
}
</script>