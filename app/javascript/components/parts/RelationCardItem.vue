<template>
  <v-col
    cols="12"
    lg="6"
  >
    <v-card outlined>
      <v-card-text class="px-0 py-0">
        <v-list>
          <v-list-item style="min-height: 66px;">
            <v-list-item-avatar
              style="cursor: pointer"
              @click="pushUserPage"
            >
              <v-img
                :src="user.avatar"
              />
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title class="font-weight-bold">
                <span
                  style="cursor: pointer"
                  @click="pushUserPage"
                >
                  {{ fullName }}
                </span>
              </v-list-item-title>
            </v-list-item-content>
            <v-list-item-action>
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
                small
                height="30"
                :outlined="!isFollow"
                :ripple="false"
                color="primary"
                class="px-2"
                @click="isFollow ? unfollow() : follow()"
              >
                <v-icon>
                  {{ isFollow ? "mdi-account-check" : "mdi-account-plus" }}
                </v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>
        </v-list>
      </v-card-text>
    </v-card>
  </v-col>
</template>

<script>
import { mapGetters } from 'vuex'
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
      loading: false,
      isFollow: false,
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    fullName() {
      return `${this.user.lastName} ${this.user.firstName}`
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