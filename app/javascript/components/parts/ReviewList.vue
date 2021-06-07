<template>
  <v-container class="d-flex px-0 py-0">
    <v-col
      cols="12"
      lg="8"
    >
      <v-card
        elevation="1"
        outlined
        class="mb-8"
      >
        <v-card-title>
          <v-avatar class="mr-4">
            <v-img
              :src="user.avatar"
            />
          </v-avatar>
          <v-icon
            small
            class="mr-1"
          >
            mdi-soccer
          </v-icon>
          <span class="font-weight-bold text-subtitle-1">{{ fullName }}</span>
        </v-card-title>
        <v-card-text class="pb-0">
          <p class="mb-0">
            とても良いプレーでした。とても良いプレーでしたとても良いプレとても良いプレーでした
          </p>
        </v-card-text>
        <v-card-actions class="mr-4 mb-2">
          <v-spacer />
          <v-rating
            v-model="rating"
            align="right"
            background-color="#ef5350"
            color="#ef5350"
            small
            readonly
            dense
          />
          <span class="mt-1 ml-1 font-weight-bold">{{ rating }}</span>
        </v-card-actions>
      </v-card>
    </v-col>
    <!-- 所属リーグのランキング -->
    <v-col
      v-if="!$vuetify.breakpoint.mobile"
      cols="12"
      lg="4"
    >
      <v-card outlined>
        <v-card-title class="text-subtitle-1 font-weight-bold pb-0">
          所属リーグのランキング
        </v-card-title>
        <v-card-text class="py-0">
          <v-list two-line>
            <v-list-item class="ml-4">
              <span class="font-weight-bold mr-3 text-subtitle-1">
                <v-icon color="#C0C0C0">
                  mdi-crown
                </v-icon>
              </span>
              <v-list-item-avatar class="mr-1">
                <v-img
                  :src="user.avatar"
                />
              </v-list-item-avatar>
              <v-list-item-content>
                <v-list-item-title
                  class="font-weight-bold text-button"
                  style="position: relative; top: 13px; left: 3px;"
                >
                  {{ fullName }}
                </v-list-item-title>
                <v-list-item-title class="mt-1">
                  <v-rating
                    v-model="rating"
                    background-color="#ef5350"
                    color="#ef5350"
                    class="mr-1 float-left"
                    readonly
                    small
                    dense
                    style="position: relative; top: 6px;"
                    :half-increments="true"
                  />
                  <span class="text-button font-weight-bold">{{ rating }}</span>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-card-text>
      </v-card>
    </v-col>
  </v-container>
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
  data() {
    return {
      rating: 3.1
    }
  },
  computed: {
    fullName() {
      return `${this.user.last_name} ${this.user.first_name}`
    }
  }
}
</script>