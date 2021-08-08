<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols="12">
          <p class="text-h4 font-weight-bold mb-1">
            みんなの評価
          </p>
        </v-col>
        <v-col
          v-for="(review, index) in reviews"
          :key="index"
          cols="12"
          lg="6"
        >
          <v-card
            outlined
            :min-height="$vuetify.breakpoint.mobile ? 380 : 310"
            :max-height="$vuetify.breakpoint.mobile ? 380 : 310"
          >
            <v-card-title>
              <v-avatar
                class="mr-2"
                style="cursor: pointer;"
                @click="pushUserPage(review.reviewee)"
              >
                <v-img
                  :src="review.reviewee.avatar"
                />
              </v-avatar>
              <span :class="$vuetify.breakpoint.mobile ? 'text-subtitle-2 font-weight-bold' : 'text-subtitle-1 font-weight-bold'">
                <span
                  style="cursor: pointer;"
                  @click="pushUserPage(review.reviewee)"
                >
                  {{ fullName(review.reviewee) }}
                </span>
                さんへのレビュー
              </span>
            </v-card-title>
            <v-card-text class="pb-0">
              <p class="text-caption">
                {{ review.reviewee.profile.team }} / {{ review.reviewee.profile.position }}
              </p>
              <v-divider />
            </v-card-text>
            <v-card-actions class="pl-3 mt-2 pb-0">
              <v-rating
                :value="+review.rate"
                background-color="#ef5350"
                color="#ef5350"
                readonly
                half-increments
                dense
              />
              <span class="ml-1 text-h6 font-weight-bold">
                {{ review.rate }}
              </span>
              <span
                v-if="!$vuetify.breakpoint.mobile"
                class="text-caption mt-1 ml-3"
                style="color: rgba(0,0,0,.6)"
              >
                試合日 {{ review.gameDate }}
              </span>
            </v-card-actions>
            <v-card-text
              class="py-0 mt-2"
              :style="$vuetify.breakpoint.mobile ? 'height: 145px; max-height: 145px;' : 'height: 75px; max-height: 75px;'"
            >
              <p
                v-if="$vuetify.breakpoint.mobile"
                class="text-caption"
              >
                試合日 {{ review.gameDate }}
              </p>
              <p>
                {{ review.content.length >= 80 ? `${review.content.substr(0, 80)}...` : review.content }}
                <span
                  v-if="review.content.length >= 80"
                  class="text-caption mt-1 ml-3 blue--text text--darken-2"
                  style="cursor: pointer;"
                >
                  もっとみる
                </span>
              </p>
            </v-card-text>
            <v-card-actions class="mr-3">
              <v-spacer />
              <v-avatar
                size="40"
                class="mr-3"
                style="cursor: pointer;"
                @click="pushUserPage(review.reviewer)"
              >
                <v-img
                  :src="review.reviewer.avatar"
                />
              </v-avatar>
              <span
                :class="$vuetify.breakpoint.mobile ? 'text-subtitle-2 font-weight-bold' : 'text-subtitle-1 font-weight-bold'"
                style="cursor: pointer;"
                @click="pushUserPage(review.reviewer)"
              >
                {{ fullName(review.reviewer) }}
              </span>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  props: {
    reviews: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  computed: {
    ...mapGetters({ currentUser: "user/currentUser" }),
    fullName: () => {
      return(user) => {
        return `${user.lastName} ${user.firstName}`
      }
    }
  },
  methods: {
    pushUserPage(user) {
      if (this.currentUser.id === user.id) return this.$router.push({ name: "myReview" })
      if (user.role === "player") {
        const leagueEigo = this.leagueNameEigo(user.profile.league.name)
        this.$router.push({
          name: "playerReview",
          params: { league: leagueEigo, categoryId: user.profile.category.id, groupId: user.profile.groupId, userId: user.id }
        })
      } else {
        this.$router.push({ name: "reviewerReview", params: { userId: user.id } })
      }
    }
  }
}
</script>