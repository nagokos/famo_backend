<template>
  <v-col cols="12">
    <v-card
      elevation="1"
      outlined
    >
      <v-card-title class="font-weight-bold">
        つながり
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12">
              <v-tabs>
                <v-tab class="font-weight-bold">
                  フォロー
                </v-tab>
                <v-tab class="font-weight-bold">
                  フォロワー
                </v-tab>
              </v-tabs>
            </v-col>
            <v-col
              cols="12"
              lg="6"
            >
              <v-card
                rounded
                outlined
              >
                <v-card-text
                  class="px-0 py-0"
                >
                  <v-list>
                    <v-list-item>
                      <v-list-item-avatar>
                        <v-img
                          :src="user.avatar"
                        />
                      </v-list-item-avatar>
                      <v-list-item-content>
                        <v-list-item-title class="font-weight-black">
                          {{ fullName }}
                        </v-list-item-title>
                      </v-list-item-content>
                      <v-list-item-action>
                        <v-btn
                          rounded
                          color="primary"
                          outlined
                          :ripple="false"
                          class="font-weight-bold text-capitalize"
                        >
                          Follow
                        </v-btn>
                      </v-list-item-action>
                    </v-list-item>
                  </v-list>
                </v-card-text>
              </v-card>
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