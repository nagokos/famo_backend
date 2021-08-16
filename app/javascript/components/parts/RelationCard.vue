<template>
  <v-container>
    <v-row>
      <template v-for="user in users">
        <relation-card-item
          v-show="loading"
          ref="relationComp"
          :key="user.id"
          :user="user.user"
          :status="user.status"
          @emit-follow="emitFollow"
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
      <v-col
        v-if="infiniteLoading"
        cols="12"
      >
        <infinite-loading
          spinner="spiral"
          @infinite="infiniteHandler"
        >
          <span slot="no-more">全て表示済みです</span>
          <span slot="no-results" />
        </infinite-loading>
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
      infiniteLoading: false,
      inactiveComp: "",
      users: [],
      page: 1,
      totalCount: 0,
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
    isFollowing() {
      return this.$route.path.includes("/following")
    },
    isMypage() {
      return this.$route.path.includes("/profile")
    },
  },
  created() {
    this.getUsers()
  },
  mounted() {
    this.$emit("reset-ids")
  },
  methods: {
    emitFollow(id) {
      this.$emit("emit-follow", id)
    },
    async infiniteHandler($state) {
      // 全部ロードし終わっていたら$state.complete(), まだあるなら $state.loaded()
      if (this.users.length === this.totalCount) {
        $state.complete()
      } else {
        if (this.isFollowing) {
          await this.getFollowing()
        } else {
          await this.getFollowers()
        }
        $state.loaded()
      }
    },
    switchFollow(ids) {
      if (!this.$refs.relationComp) return
      if (ids.length === 0) return
      const indexArray = ids.map(id => {
        return this.$refs.relationComp.findIndex(el => {
          return el.user.id === id
        })
      })
      indexArray.forEach(index => {
        if (index !== -1) {
          this.$refs.relationComp[index].switchFollow()
        }
      })
      this.$emit("reset-ids")
    },
    async getUsers() {
      if (this.isFollowing) {
        await this.getFollowing()
      } else {
        await this.getFollowers()
      }
      this.loading = true
      this.infiniteLoading = true
    },
    async getFollowing() {
      if (this.isMypage) {
        const response = await this.$axios.get("/api/v1/users/current/following", {
          params: { page: this.page }
        })
        this.totalCount = +response.headers["total-count"]
        this.page = +response.headers["current-page"] + 1
        await Promise.all(response.data.users.map(async resUser => {
          const status = await this.$axios.get(`/api/v1/users/${resUser.id}/relationship/check`)
          const user = { user: resUser, status: status.data.status }
          this.users.push(user)
        }));
      } else {
        const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/following`, {
          params: { page: this.page }
        })
        this.totalCount = +response.headers["total-count"]
        this.page = +response.headers["current-page"] + 1
        await Promise.all(response.data.users.map(async resUser => {
          const status = await this.$axios.get(`/api/v1/users/${resUser.id}/relationship/check`)
          const user = { user: resUser, status: status.data.status }
          this.users.push(user)
        }));
      }
    },
    async getFollowers() {
      if (this.isMypage) {
        const response = await this.$axios.get("/api/v1/users/current/followers", {
          params: { page: this.page }
        })
        this.totalCount = +response.headers["total-count"]
        this.page = +response.headers["current-page"] + 1
        await Promise.all(response.data.users.map(async resUser => {
          const status = await this.$axios.get(`/api/v1/users/${resUser.id}/relationship/check`)
          const user = { user: resUser, status: status.data.status }
          this.users.push(user)
        }));
      } else {
        const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/followers`, {
          params: { page: this.page }
        })
        this.totalCount = +response.headers["total-count"]
        this.page = +response.headers["current-page"] + 1
        await Promise.all(response.data.users.map(async resUser => {
          const status = await this.$axios.get(`/api/v1/users/${resUser.id}/relationship/check`)
          const user = { user: resUser, status: status.data.status }
          this.users.push(user)
        }));
      }
    }
  }
}
</script>