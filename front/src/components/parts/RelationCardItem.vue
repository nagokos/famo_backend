<template>
  <v-col cols="12" lg="6">
    <v-card outlined>
      <v-list-item>
        <v-avatar
          class="my-3 mr-4"
          size="60"
          style="cursor: pointer"
          @click="pushUserPage(user)"
        >
          <v-img :src="user.avatar" />
        </v-avatar>
        <v-list-item-title class="font-weight-bold text-subtitle-1">
          <span style="cursor: pointer" @click="pushUserPage(user)">
            {{ user.name }}
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
          {{ isFollow ? "フォロー中" : "フォローする" }}
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
            {{ isFollow ? "mdi-account-check" : "mdi-account-plus" }}
          </v-icon>
        </v-btn>
      </v-list-item>
    </v-card>
  </v-col>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true,
    },
    status: {
      type: Boolean,
      default: false,
      required: true,
    },
  },
  data() {
    return {
      isFollow: this.status,
    };
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
  },
  methods: {
    switchFollow() {
      this.isFollow = !this.isFollow;
    },
    pushUserPage(user) {
      if (this.currentUser.id === user.id)
        return this.$router.push({ name: "myReview" });
      if (user.role === "player") {
        const leagueEigo = this.leagueNameEigo(user.profile.league.name);
        this.$router.push({
          name: "playerReview",
          params: {
            league: leagueEigo,
            categoryId: user.profile.category.id,
            groupId: user.profile.groupId,
            userId: user.id,
          },
        });
      } else {
        this.$router.push({
          name: "reviewerReview",
          params: { userId: user.id },
        });
      }
    },
    async follow() {
      try {
        if (!this.currentUser) {
          this.$router.push({ name: "login" });
          return this.$store.dispatch("flash/setFlash", {
            type: "error",
            message: "ログインしてください",
          });
        }
        await this.$axios.post(`/api/v1/users/${this.user.id}/relationships`);
        this.isFollow = true;
        this.$emit("emit-follow", this.user.id);
      } catch (error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message,
        });
      }
    },
    async unfollow() {
      try {
        if (!this.currentUser) {
          this.$router.push({ name: "login" });
          return this.$store.dispatch("flash/setFlash", {
            type: "error",
            message: "ログインしてください",
          });
        }
        await this.$axios.delete(`/api/v1/users/${this.user.id}/relationships`);
        this.isFollow = false;
        this.$emit("emit-follow", this.user.id);
      } catch (error) {
        this.$store.dispatch("flash/setFlash", {
          type: "error",
          message: error.response.data.message,
        });
      }
    },
  },
};
</script>
