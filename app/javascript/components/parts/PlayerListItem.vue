<template>
  <div>
    <v-list-item
      :key="user.id"
      class="pl-0"
      inactive
      :ripple="false"
      style="cursor: pointer;"
      @click="pushUserPage"
    >
      <v-avatar
        size="130"
        rounded
      >
        <v-img
          :src="user.avatar"
        />
      </v-avatar>
      <v-list-item-content class="ml-5">
        <v-list-item-title class="font-weight-bold text-h5 mt-2">
          {{ fullName }}
        </v-list-item-title>
        <v-list-item-subtitle
          class="mt-2"
          style="margin-left: 1px;"
        >
          {{ information }}
        </v-list-item-subtitle>
        <v-card-actions class="pl-0">
          <v-rating
            :value="3"
            background-color="#ef5350"
            color="#ef5350"
            readonly
            size="30"
            dense
            style="position: relative; right: 3px;"
          />
          <span class="ml-1 text-h5 font-weight-bold">
            3.0
          </span>
        </v-card-actions>
      </v-list-item-content>
    </v-list-item>
    <v-divider
      class="my-4"
    />
  </div>
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
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    fullName() {
      return `${this.user.lastName} ${this.user.firstName}`
    },
    information() {
      return `${this.user.profile.team}(${this.user.profile.prefecture.name}) ${this.user.profile.position} / ${this.user.profile.officialNumber}`
    }
  },
  methods: {
    pushUserPage() {
      const leagueEigo = Transform.leagueNameEigo(this.user.profile.league.name)
      if (this.currentUser.id === this.user.id) {
        this.$router.push({ name: "profile" })
      } else {
        this.$router.push({
          name: "playerProfile",
          params: { league: leagueEigo, categoryId: this.user.profile.category.id, groupId: this.user.profile.groupId, userId: this.user.id }
        })
      }
    },
  }
}
</script>