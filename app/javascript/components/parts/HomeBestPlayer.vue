<template>
  <div>
    <v-window
      v-if="!$vuetify.breakpoint.mobile"
      v-model="onboarding"
    >
      <v-window-item
        v-for="(data, index) in users"
        :key="index"
      >
        <v-container class="px-1">
          <v-row
            style="max-width: 1050px; margin: 0 auto"
          >
            <v-col
              v-for="user in data"
              :key="user.id"
              class="px-2"
              style="max-width: 208px;"
            >
              <v-card
                :ripple="false"
                outlined
                elevation="1"
                min-height="285"
                max-height="285"
                min-width="190"
                max-width="190"
                @click="pushUserPage(user)"
                style="cursor: pointer; z-index: 1;"
              >
                <v-img
                  :src="user.avatar"
                  min-height="150"
                  min-width="190"
                  max-width="190"
                  max-height="150"
                />
                <v-card-title class="text-subtitle-2 font-weight-bold pb-1">
                  {{ user.name }}
                </v-card-title>
                <v-card-text class="mb-1">
                  <v-card-subtitle class="px-0 pt-0 text-caption">
                    {{ information(user) }}
                  </v-card-subtitle>
                  <v-row
                    align="center"
                    class="mx-0"
                  >
                    <v-card-actions class="px-0">
                      <v-rating
                        :value="+user.profile.rate"
                        color="amber"
                        dense
                        background-color="amber"
                        half-increments
                        readonly
                        size="14"
                      />
                      <span class="text-caption ml-1">{{ user.profile.rate }}</span>
                    </v-card-actions>
                  </v-row>
                </v-card-text>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </v-window-item>
    </v-window>
    <v-card-actions v-if="!$vuetify.breakpoint.mobile" style="position: relative; bottom: 200px;">
      <v-btn
        v-if="!!users.length && onboarding !== 0"
        fab
        max-height="50"
        max-width="50"
        style="position: relative; right: 60px;"
        @click="prev"
      >
        <v-icon>
          mdi-chevron-left
        </v-icon>
      </v-btn>
      <v-spacer />
      <v-btn
        v-if="!!users.length && onboarding !== users.length - 1"
        fab
        max-height="50"
        max-width="50"
        style="position: relative; left: 60px;"
        @click="next"
      >
        <v-icon>
          mdi-chevron-right
        </v-icon>
      </v-btn>
    </v-card-actions>
    <v-slide-group
      v-if="$vuetify.breakpoint.mobile"
      class="mb-16"
    >
      <v-slide-item
         v-for="(user, index) in users"
        :key="user.id"
      >
        <v-container>
          <v-row>
            <v-col style="max-width: 208px;" :class="index + 1 === users.length ? '' : 'pr-0'">
              <v-card
                :ripple="false"
                outlined
                elevation="1"
                min-height="265"
                max-height="265"
                min-width="180"
                max-width="180"
                @click="pushUserPage(user)"
                style="cursor: pointer; z-index: 1;"
              >
                <v-img
                  :src="user.avatar"
                  min-height="130"
                  min-width="180"
                  max-width="180"
                  max-height="130"
                />
                <v-card-title class="text-subtitle-2 font-weight-bold pb-1">
                  {{ user.name }}
                </v-card-title>
                <v-card-text class="mb-1">
                  <v-card-subtitle class="px-0 pt-0 text-caption">
                    {{ information(user) }}
                  </v-card-subtitle>
                  <v-row
                    align="center"
                    class="mx-0"
                  >
                    <v-card-actions class="px-0">
                      <v-rating
                        :value="+user.profile.rate"
                        color="amber"
                        dense
                        background-color="amber"
                        half-increments
                        readonly
                        size="14"
                      />
                      <span class="text-caption ml-1">{{ user.profile.rate }}</span>
                    </v-card-actions>
                  </v-row>
                </v-card-text>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </v-slide-item>
    </v-slide-group>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  props: {
    users: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      onboarding: 0,
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    information: () => {
      return(user) => {
        return `${user.profile.team}`
      }
    }
  },
  methods: {
    left() {
      this.prev()
    },
    right() {
      this.next()
    },
    next() {
     this.onboarding += 1
    },
    prev() {
      this.onboarding -= 1
    },
    pushUserPage(user) {
      const leagueEigo = this.leagueNameEigo(user.profile.league.name)
      if (this.currentUser.id === user.id) {
        this.$router.push({ name: "myReview" })
      } else {
        this.$router.push({
          name: "playerReview",
          params: { league: leagueEigo, categoryId: user.profile.category.id, groupId: user.profile.groupId, userId: user.id }
        })
      }
    },
  }
}
</script>