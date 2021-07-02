<template>
  <div>
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
    <div class="settings">
      <v-col cols="12">
        <div class="font-weight-bold" style="font-size: 30px;">アカウント設定</div>
      </v-col>
      <v-col cols="12" >
        <v-tabs background-color="#FAFAFA">
          <v-tab
            v-for="setting in settings"
            :key="setting.params"
            :to="{ name: 'mySetting', params: { type: setting.params } }"
            class="font-weight-bold"
          >
            {{ setting.name }}
          </v-tab>
        </v-tabs>
        <v-divider></v-divider>
      </v-col>
      <the-profile-edit
        ref="profileEdit"
        class="mt-3"
        v-bind.sync="userEdit"
        @click-update="updateProfile"
      />
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
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import SendActivationEmail from "../parts/SendActivationEmail"
import TheBreadCrumb from "../globals/TheBreadCrumb"
import TheProfileEdit from "../parts/TheProfileEdit"

export default {
  components: {
    TheBreadCrumb,
    TheProfileEdit,
    SendActivationEmail
  },
  data() {
    return {
      dialog: false,
      userEdit: {},
      settings: [
        {
          name: "プロフィール",
          params: "profile"
        },
        {
          name: "選手情報",
          params: "player"
        }
      ]
    }
  },
  created() {
    this.userEdit = { ...this.currentUser }
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
  methods: {
    async updateProfile() {
      const response = await this.$store.dispatch("user/updateCurrentUser", this.userEdit)
      console.log(response);
      if (response.errors) return this.$refs.profileEdit.setErrors(response.errors)
      if (response.activationState === "pending") {
        this.dialog = true
      }
    },
  }
}
</script>

