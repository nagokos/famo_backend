<template>
  <v-menu 
    v-model="notificationMenu"
    offset-y 
    left
    :close-on-content-click="false"
    :max-width="$vuetify.breakpoint.mobile ? 270 : 300"
    min-width="270"
  >
    <template #activator="{ on, attrs }">
      <v-badge
        bordered
        color="error"
        class="mr-6"
        dot
        overlap
        :value="badge"
      >
        <v-icon
          color="#FAFAFA"
          size="27"
          v-bind="attrs"
          v-on="on"
        >
          mdi-bell-outline
        </v-icon>
      </v-badge>
    </template>
    <v-list 
      :max-height="$vuetify.breakpoint.mobile ? 400 : 600"
      class="py-0"
      style="overflow-y: auto;"
    >
      <v-subheader class="py-7">
        <v-col cols="5">
          <span class="font-weight-bold black--text">お知らせ</span>
        </v-col>
        <v-col
          cols="7"
          align="end"
        >
          <span 
            class="text-caption blue--text text--darken-2" 
            style="cursor: pointer;"
            @click="updateNotifications"
          >
            すべて既読にする
          </span>
        </v-col>
      </v-subheader>
      <v-divider />
      <v-col 
        v-if="notifications.length === 0" 
        class="py-10" 
        align="center"
      >
        <div 
          class="font-weight-bold grey--text text--lighten-1"
        >
          お知らせはありません
        </div>
      </v-col>
      <template 
        v-for="notification in notifications" 
        v-else
      >
        <v-list-item 
          :key="`item-${notification.id}`"
          :ripple="false"
          class="py-3" 
          :style="notification.checked ? 'cursor: pointer; background: #F5F5F5;' : 'cursor: pointer;'"
          @click="updateNotification(notification)"
        >
          <v-avatar class="mr-1">
            <v-img
              :src="notification.visitor.avatar"
              max-height="40"
              max-width="40"
            />
          </v-avatar>
          <v-list-item-content>
            <span class="text-caption">{{ notificationText(notification) }}</span>
          </v-list-item-content>
        </v-list-item>
        <v-divider :key="notification.id" />
      </template>
      <v-list-item
        v-if="seeMore"
        class="py-1"
        style="cursor: pointer;"
        @click="getNotifications"
      >
        <v-list-item-content>
          <div class="text-caption text-center blue--text text--darken-2">
            もっと見る
          </div>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-menu>
</template>

<script>
export default {
  data() {
    return {
      notifications: [],
      page: 0,
      notificationMenu: false,
      badge: false,
      seeMore: true
    }
  },
  computed: {
    notificationText: () => {
      return(notification) => {
        if (notification.action === "created") {
          return `${notification.visitor.name}さんから、レビューが届きました。`
        }
      }
    }
  },
  created() {
    this.getNotifications()
  },
  methods: {
     async getNotifications() {
      this.page += 1
      const response = await this.$axios.get("/api/v1/users/current/notifications", {
        params: {
          page: this.page
        }
      })
      response.data.notifications.forEach(notification => this.notifications.push(notification))
      this.checkNotifications()
      if (response.headers["current-page"] === response.headers["total-pages"]) this.seeMore = false
    },
    async updateNotification(notification) {
      const response = await this.$axios.patch(`/api/v1/users/current/notifications/${notification.id}`)
      const index = this.notifications.findIndex(notification => notification.id === response.data.notification.id)
      this.notifications.splice(index, 1, response.data.notification)
      this.notificationMenu = false
      this.$router.push({ name: "myReview" }, () => {})
      this.checkNotifications()
    },
    async updateNotifications() {
      this.page = 1
      const response = await this.$axios.patch("/api/v1/users/current/notifications/0", {
        params: {
          page: this.page,
        }
      })
      this.notifications = response.data.notifications
      this.seeMore = true
      this.checkNotifications()
    },
    async checkNotifications() {
      const response = await this.$axios.get("/api/v1/users/current/notifications/check")
      this.badge = response.data
    }
  }
}
</script>