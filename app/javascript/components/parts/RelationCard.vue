<template>
  <v-col cols="12">
    <v-card
      outlined
    >
      <v-col cols="12">
        <v-card-title class="font-weight-bold text-h5 pb-0">
          つながり
        </v-card-title>
      </v-col>
      <v-card-text :class="$vuetify.breakpoint.mobile ? 'px-0 pt-0' : 'pt-0'">
        <v-container>
          <v-row>
            <v-col cols="12">
              <v-tabs
                :grow="$vuetify.breakpoint.mobile"
                :centered="$vuetify.breakpoint.mobile"
              >
                <v-tab
                  v-for="route in routes"
                  :key="route.params"
                  :to="{ name: isMypage ? 'profile' : 'userProfile', params: { type: route.params } }"
                  class="font-weight-bold"
                  @click.once="setFollowers"
                >
                  {{ route.name }}
                </v-tab>
              </v-tabs>
            </v-col>
            <template v-for="follow in following">
              <relation-card-item
                v-show="$route.path.includes('/following') && loading"
                ref="followComp"
                :key="`follow-${follow.id}`"
                :user="follow"
                @check-follow="followerCheck(follow.id)"
              />
            </template>
            <template v-for="follower in followers">
              <relation-card-item
                v-show="$route.path.includes('/followers') && loading"
                ref="followerComp"
                :key="`follower-${follower.id}`"
                :user="follower"
                @check-follow="follwCheck(follower.id)"
              />
            </template>
            <v-col
              v-if="!loading"
              cols="12"
              align="center"
            >
              <v-progress-circular
                indeterminate
                color="primary"
              />
            </v-col>
            <v-col cols="12" align="center" class="text-h6" v-if="$route.path.includes('/following') && following.length === 0">
              フォローしていません
            </v-col>
            <v-col cols="12" align="center" class="text-h6" v-if="$route.path.includes('/followers') && followers.length === 0">
              フォロワーがいません
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-col>
</template>

<script>
import RelationCardItem from './RelationCardItem'

export default {
  components: {
    RelationCardItem,
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      loading: false,
      following: [],
      followers: [],
      routes: [
        {
          name: "フォロー",
          params: "following"
        },
        {
          name: "フォロワー",
          params: "followers"
        }
      ]
    }
  },
  computed: {
    isMypage() {
      return this.$route.path.includes("/profile")
    }
  },
  mounted() {
    if (!this.$route.path.includes("/following")) {
      this.$router.push({ name: this.setName, params: { type: "following" } })
    }
    this.setFollowing()
  },
  methods: {
    followerCheck(id) {
      if (this.followers.length !== 0) {
        const index = this.$refs.followerComp.findIndex(el => {
          return el.user.id === id
        })
        if (index !== -1) {
          this.$refs.followerComp[index].switchFollow()
        }
      }
    },
    follwCheck(id) {
      if (this.following.length !== 0) {
        const index = this.$refs.followComp.findIndex(el => {
          return el.user.id === id
        })
        if (index !== -1) {
          this.$refs.followComp[index].switchFollow()
        }
      }
    },
    async setFollowing() {
      await this.getFollowing()
      if (this.following.length !== 0) {
        await this.$refs.followComp[this.following.length - 1].checkFollow()
      }
      this.loading = true
    },
    async setFollowers() {
      if (this.$route.path.includes("/followers")) {
        this.loading = false
        await this.getFollowers()
        if (this.followers.length !== 0) {
          await this.$refs.followerComp[this.followers.length - 1].checkFollow()
        }
        this.loading = true
      }
    },
    async getFollowing() {
      if (this.isMypage) {
        const response = await this.$axios.get("/api/v1/users/current/following")
        this.following = response.data.users
      } else {
        const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/following`)
        this.following = response.data.users
      }
    },
    async getFollowers() {
      if (this.isMypage) {
        const response = await this.$axios.get("/api/v1/users/current/followers")
        this.followers = response.data.users
      } else {
        const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/followers`)
        this.followers = response.data.users
      }
    }
  }
}
</script>