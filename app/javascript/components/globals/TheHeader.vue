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
          @click="pushPage('/login', 'login')"
        >
          <span
            class="text-caption"
            style="color: white;"
          >登録 ｜ ログイン</span>
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
            min-width="170"
            class="py-0"
          >
            <v-col
              cols="12"
              align="center"
              class="px-0"
            >
              <v-btn
                text
                disabled
                class="font-weight-bold px-0 ml-n3"
              >
                <v-avatar
                  class="mr-2"
                >
                  <v-img
                    :src="currentUser.avatar"
                    max-height="35"
                    max-width="35"
                  />
                </v-avatar>
                <span
                  style="color: black;"
                  class="mx-auto text-button font-weight-bold"
                >{{ fullName }}</span>
              </v-btn>
            </v-col>
            <v-divider />
            <v-col
              cols="12"
              align="center"
              class="px-0"
            >
              <v-btn
                text
                block
                @click="pushPage('/profile', 'profile')"
              >
                <v-icon
                  class="mr-2"
                >
                  mdi-face
                </v-icon>
                <span class="mx-auto text-caption font-weight-bold">プロフィール</span>
              </v-btn>
            </v-col>
            <v-col
              cols="12"
              align="center"
              class="px-0 pt-0"
            >
              <v-btn
                text
                block
                @click="logout"
              >
                <v-icon
                  class="mr-2"
                >
                  mdi-logout
                </v-icon>
                <span class="mx-auto text-caption font-weight-bold">ログアウト</span>
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
      return `${this.currentUser.last_name} ${this.currentUser.first_name}`
    }
  },
  methods: {
    pushPage(path, route) {
      if (this.$route.path !== path) {
        this.$router.push({ name: route })
      }
    },
    async logout() {
      await this.$store.dispatch("user/logout")
      location.reload()
    }
  }
}
</script>