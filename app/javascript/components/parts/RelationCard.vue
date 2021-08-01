<template>
  <v-container>
    <v-row>
      <template v-for="user in users">
        <relation-card-item
          v-show="loading"
          ref="relationComp"
          :key="user.id"
          :user="user"
          @check-follow="checkFollow"
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
      <v-col
        v-if="loading && $route.path.includes('/following') && users.length === 0"
        cols="12"
        align="center"
        class="text-h6"
      >
        フォローしていません
      </v-col>
      <v-col
        v-if="loading && $route.path.includes('/followers') && users.length === 0"
        cols="12"
        align="center"
        class="text-h6"
      >
        フォロワーはいません
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import RelationCardItem from './RelationCardItem'

export default {
  components: {
    RelationCardItem
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
    setName() {
      return this.isMypage ? 'profile' : 'userProfile'
    },
    isMypage() {
      return this.$route.path.includes("/profile")
    }
  },
  created() {
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