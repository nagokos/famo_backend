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
          アカウント設定
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
      <!-- プロフィール -->
      <v-col class="pt-0">
        <setting-account
          v-if="$route.path === '/settings/account'"
          :user="currentUser"
          @update-user="fetchCurrentUser"
        />
      </v-col>
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
      v-model="dialog"
      width="500"
      :persistent="true"
      scrollable
    >
      <send-activation-email
        :email="currentUser.email"
        @click-close="dialog = false"
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
      dialog: false,
      userEdit: {},
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    fullName() {
      return `${this.currentUser.lastName} ${this.currentUser.firstName}`
    },
    breadCrumbs() {
      return [
        {
          text: "TOP",
          to: "/",
          disabled: false
        },
        {
          text: this.fullName,
          to: "/profile",
          disabled: false
        },
        {
          text: "アカウント設定",
          to: `/settings/${this.$route.params.type}`,
          disabled: true
        },
      ]
    }
  },
  created() {
    this.dupUser()
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
      const response = await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
      if (response.errors) return this.$refs.profileEdit.setErrors(response.errors)
      if (response.activationState === "pending") {
        this.dialog = true
      }
    },
  }
}
</script>