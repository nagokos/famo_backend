<template>
  <v-list-item
    :key="user.id"
    class="pl-0"
    inactive
    :ripple="false"
    style="cursor: pointer;"
    @click="pushUserPage"
  >
    <v-icon
      v-if="$route.path.includes('ratings')"
      size="45"
      :color="setColor"
      :style="$vuetify.breakpoint.mobile ? 'position: absolute; bottom: 82px; z-index: 1;' : 'position: absolute; bottom: 102px; z-index: 1;'"
    >
      mdi-bookmark
    </v-icon>
    <span
      v-if="$route.path.includes('ratings')"
      :class="index >= 100 ? 'font-weight-bold text-caption white--text' : 'font-weight-bold white--text'"
      :style="rankStyle"
    >
      {{ index }}
    </span>
    <v-avatar
      :size="$vuetify.breakpoint.mobile ? 100 : 130"
      rounded
    >
      <v-img
        :src="user.avatar"
      />
    </v-avatar>
    <v-list-item-content class="ml-5">
      <v-list-item-title :class="$vuetify.breakpoint.mobile ? 'font-weight-bold text-h6 mt-6' : 'font-weight-bold text-h5 mt-4'">
        {{ user.name }}
      </v-list-item-title>
      <v-list-item-subtitle
        :class="$vuetify.breakpoint.mobile ? 'text-caption mt-1' : 'mt-2'"
        style="margin-left: 1px;"
      >
        {{ information }}
      </v-list-item-subtitle>
      <v-card-actions
        class="pl-0"
        :style="$vuetify.breakpoint.mobile ? 'position: relative; bottom: 5px;' : ''"
      >
        <v-rating
          :value="+user.profile.rate"
          background-color="#ef5350"
          color="#ef5350"
          readonly
          :size="$vuetify.breakpoint.mobile ? 20 : 30"
          dense
          :half-increments="true"
          style="position: relative; right: 3px;"
        />
        <span
          :class="$vuetify.breakpoint.mobile ? 'text-subtitle-1 font-weight-bold' : 'ml-1 text-h5 font-weight-bold'"
          :style="$vuetify.breakpoint.mobile ? '' : 'margin-top: 2px;'"
        >
          {{ user.profile.rate }}
        </span>
      </v-card-actions>
    </v-list-item-content>
  </v-list-item>
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
    index: {
      type: Number,
      default: () => {},
      required: true
    }
  },
  computed: {
    rankStyle() {
    if (!this.$vuetify.breakpoint.mobile && this.index < 10) {
      return "position: absolute; bottom: 114px; left: 18px; z-index: 1;"
    } else if (!this.$vuetify.breakpoint.mobile && this.index >= 10 && this.index < 100) {
      return "position: absolute; bottom: 114px; left: 14px; z-index: 1;"
    } else if (!this.$vuetify.breakpoint.mobile && this.index >= 100) {
      return "position: absolute; bottom: 114px; left: 12px; z-index: 1;"
    } else if (this.$vuetify.breakpoint.mobile && this.index < 10) {
       return "position: absolute; bottom: 93px; left: 18px; z-index: 1;"
    } else if (this.$vuetify.breakpoint.mobile && this.index >= 10 && this.index < 100) {
      return "position: absolute; bottom: 93px; left: 14px; z-index: 1;"
    } else {
      return "position: absolute; bottom: 93px; left: 12px; z-index: 1;"
    }
    },
    setColor() {
      if (this.index === 1) return "#dab300"
      if (this.index === 2) return "#C0C0C0"
      if (this.index === 3) return "#816D46"
      else return "#d3b572"
    },
    ...mapGetters({ currentUser: "user/currentUser" }),
    information() {
      if (this.$vuetify.breakpoint.mobile && this.$vuetify.breakpoint.width <= 320) {
        const information = `${this.user.profile.team} / ${this.user.profile.position}`
        return information.length >= 16 ? `${information.substr(0, 12)}...` : information
      } else if (this.$vuetify.breakpoint.mobile && this.$vuetify.breakpoint.width > 320) {
        return `${this.user.profile.team} / ${this.user.profile.position}`
      } else {
        return `${this.user.profile.team}(${this.user.profile.prefecture.name}) / ${this.user.profile.position}`
      }
    }
  },
  methods: {
    pushUserPage() {
      const leagueEigo = this.leagueNameEigo(this.user.profile.league.name)
      if (this.currentUser.id === this.user.id) {
        this.$router.push({ name: "myReview" })
      } else {
        this.$router.push({
          name: "playerReview",
          params: { league: leagueEigo, categoryId: this.user.profile.category.id, groupId: this.user.profile.groupId, userId: this.user.id }
        })
      }
    },
  }
}
</script>