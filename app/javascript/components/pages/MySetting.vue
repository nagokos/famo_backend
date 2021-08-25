<template>
  <div>
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <div class="settings">
      <v-col cols="12">
        <div
          class="font-weight-bold"
          style="font-size: 30px;"
        >
          設定
        </div>
      </v-col>
      <v-col
        cols="12"
        class="pt-0"
      >
        <settings-tab
          @data-reset="reset"
        />
        <v-divider />
      </v-col>
      <!-- アカウント -->
      <v-col class="pt-0">
        <setting-account
          v-if="$route.path === '/settings/account'"
          :user="currentUser"
          @update-user="fetchCurrentUser"
          @delete-user="deleteUser"
        />
      </v-col>
      <!-- プロフィール -->
      <setting-profile
        v-if="$route.path === '/settings/profile'"
        ref="profileEdit"
        v-bind.sync="userEdit"
        @click-update="updateProfile"
      />
      <!-- 選手情報 -->
      <setting-player
        v-if="$route.path === '/settings/player'"
        ref="playerEdit"
        :user="currentUser"
        @fetch-user="fetchCurrentUser"
      />
    </div>
    <!-- メール送信モーダル -->
    <v-dialog
      v-model="activationDialog"
      width="500"
      :persistent="true"
      scrollable
    >
      <send-activation-email
        :email="currentUser.email"
        @click-close="activationDialog = false"
      />
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import SettingsTab from "../parts/SettingsTab"
import SettingAccount from "../parts/SettingAccount"
import SettingProfile from "../parts/SettingProfile"
import SettingPlayer from "../parts/SettingPlayer"
import TheBreadCrumb from "../globals/TheBreadCrumb"
import SendActivationEmail from "../parts/SendActivationEmail"

export default {
  components: {
    SettingsTab,
    SettingAccount,
    SettingProfile,
    SettingPlayer,
    TheBreadCrumb,
    SendActivationEmail,
  },
  data() {
    return {
      activationDialog: false,
      userEdit: {},
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    breadCrumbs() {
      return [
        {
          text: "TOP",
          to: "/",
          disabled: false
        },
        {
          text: this.currentUser.name,
          to: "/profile",
          disabled: false
        },
        {
          text: "設定",
          to: `/settings/${this.$route.params.type}`,
          disabled: true
        },
      ]
    }
  },
  created() {
    this.dupUser()
  },
  mounted() {
    if (this.$route.params.type.includes("account") || this.$route.params.type.includes("profile") || this.$route.params.type.includes("player")) return
    this.$store.dispatch("notFound/setNotFound", true)
  },
  methods: {
    dupUser() {
      this.userEdit = { ...this.currentUser }
    },
    reset(event) {
      switch (event) {
      case "/settings/profile":
        this.dupUser()
        break
      }
    },
    fetchCurrentUser() {
      this.$store.dispatch("user/getCurrentUserFromAPI")
    },
    async updateProfile() {
      try {
        const response = await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
        if (response.activationState === "pending") {
          this.activationDialog = true
        }
        this.$store.dispatch("flash/setFlash", {
          type: "success",
          message: "更新しました"
        })
      } catch(error) {
        if (error.response.data.errors) {
          this.$refs.profileEdit.setErrors(error.response.data.errors)
        }
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    },
    async deleteUser() {
      try {
        await this.$store.dispatch("user/deleteCurrentUser")
        localStorage.delete = 1
        location.href = "/"
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    }
  }
}
</script>

<style scoped>
  .settings {
    max-width: 700px;
    margin: 0 auto;
  }
</style>