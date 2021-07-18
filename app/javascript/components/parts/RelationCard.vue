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
                  @click.once="getFollowerData"
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
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-col>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  computed: {
    fullName() {
      return `${this.user.last_name} ${this.user.first_name}`
    }
  }
}
</script>