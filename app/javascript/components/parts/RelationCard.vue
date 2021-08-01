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
      inactiveComp: "",
      users: [],
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
    switchFollow(ids) {
      if (!this.$refs.relationComp) return
      if (ids.length === 0) return
      let indexArray = []
      ids.filter(comp => {
        const index = this.$refs.relationComp.findIndex(el => {
          return el.user.id === comp
        })
        indexArray.push(index)
      })
      console.log(indexArray);
      indexArray.forEach(index => {
        if (index !== -1) {
          this.$refs.relationComp[index].switchFollow()
        }
      })
      this.$emit("reset-ids")
    },
    checkFollow(id) {
      this.$emit("check-follow", id)
    },
    async getUsers() {
      if (this.isFollowing) {
        await this.getFollowing()
      } else {
        await this.getFollowers()
      }
      if (!this.$refs.relationComp) return this.loading = true
      await this.$refs.relationComp[this.$refs.relationComp.length - 1].checkFollow()
      this.loading = true
    },
    async getFollowing() {
      if (this.isMypage) {
        const response = await this.$axios.get("/api/v1/users/current/following")
        this.users = response.data.users
      } else {
        const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/following`)
        this.users = response.data.users
      }
    },
    async getFollowers() {
      if (this.isMypage) {
        const response = await this.$axios.get("/api/v1/users/current/followers")
        this.users = response.data.users
      } else {
        const response = await this.$axios.get(`/api/v1/users/${this.$route.params.userId}/followers`)
        this.users = response.data.users
      }
    }
  }
}
</script>