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
        class="font-weight-bold white--text"
        :style="$vuetify.breakpoint.mobile ? 'position: absolute; bottom: 93px; left: 18px; z-index: 1;' : 'position: absolute; bottom: 114px; left: 18px; z-index: 1;'"
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
          {{ fullName }}
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
    <v-divider
      :class="$vuetify.breakpoint.mobile ? '' : 'my-5'"
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
    },
    index: {
      type: Number,
      default: () => {},
      required: true
    }
  },
  computed: {
    setColor() {
      if (this.index === 1) return "#dab300"
      if (this.index === 2) return "#C0C0C0"
      if (this.index === 3) return "#816D46"
      else return "#d3b572"
    },
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