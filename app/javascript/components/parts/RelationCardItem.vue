<template>
  <v-col
    cols="12"
    lg="6"
  >
    <v-card outlined>
      <v-list-item>
        <v-avatar
          class="my-3 mr-4"
          size="60"
          style="cursor: pointer"
          @click="pushUserPage(user)"
        >
          <v-img
            :src="user.avatar"
          />
        </v-avatar>
        <v-list-item-title class="font-weight-bold text-subtitle-1">
          <span
            style="cursor: pointer"
            @click="pushUserPage(user)"
          >
            {{ fullName(user) }}
          </span>
        </v-list-item-title>
        <v-spacer />
        <v-btn
          v-if="!$vuetify.breakpoint.mobile && currentUser.id !== user.id"
          :ripple="false"
          :outlined="!isFollow"
          depressed
          width="120"
          color="primary"
          class="font-weight-bold px-2 py-5 text-caption mr-2"
          @click="isFollow ? unfollow() : follow()"
        >
          {{ isFollow ? 'フォロー中' : 'フォローする' }}
        </v-btn>
        <v-btn
          v-if="$vuetify.breakpoint.mobile && currentUser.id !== user.id"
          depressed
          height="40"
          :ripple="false"
          :outlined="!isFollow"
          color="primary"
          class="px-2"
          @click="isFollow ? unfollow() : follow()"
        >
          <v-icon>
            {{ isFollow ? 'mdi-account-check' : 'mdi-account-plus' }}
          </v-icon>
        </v-btn>
      </v-list-item>
    </v-card>
  </v-col>
</template>

<script>
import { mapGetters } from 'vuex'
import Transform from "../../packs/league-transform"

export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
  },
  data() {
    return {
      isFollow: false,
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    fullName: () => {
      return(user) => {
        return `${user.lastName} ${user.firstName}`
      }
    }
  },
  created() {
    this.checkFollow()
  },
  methods: {
    switchFollow() {
      this.isFollow = !this.isFollow
    },
    pushUserPage() {
      if (this.currentUser.id === this.user.id) {
        this.$router.push({ name: "profile" })
      } else {
        this.$router.push({ name: "userProfile", params: { userId: this.user.id } })
      }
    },
    async checkFollow() {
      const response = await this.$axios.get(`/api/v1/users/${this.user.id}/relationships/check`)
      this.isFollow = response.data.status
    },
    async follow() {
      try {
        await this.$axios.post(`/api/v1/users/${this.user.id}/relationships`)
        this.isFollow = true
        this.$emit("check-follow")
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    },
    async unfollow() {
      try {
        await this.$axios.delete(`/api/v1/users/${this.user.id}/relationships`)
        this.isFollow = false
        this.$emit("check-follow")
      } catch(error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message
        })
      }
    },
  }
}
</script>