<template>
  <v-col cols="12">
    <v-card
      elevation="1"
      outlined
    >
      <v-card-title class="font-weight-bold">
        経歴
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <v-col
              class="font-weight-bold"
              align="center"
              cols="12"
              md="4"
            >
              川崎サッカークラブ
              <v-icon
                v-if="!$vuetify.breakpoint.mobile"
                style="float: right"
              >
                mdi-arrow-right
              </v-icon>
            </v-col>
            <v-col
              v-if="$vuetify.breakpoint.mobile"
              class="font-weight-bold"
              align="center"
              cols="12"
            >
              <v-icon>
                mdi-arrow-down
              </v-icon>
            </v-col>
            <v-col
              align="center"
              cols="12"
              lg="4"
              class="font-weight-bold"
            >
              川崎フロンターレU15
              <v-icon
                v-if="!$vuetify.breakpoint.mobile"
                style="float: right"
              >
                mdi-arrow-right
              </v-icon>
            </v-col>
            <v-col
              v-if="$vuetify.breakpoint.mobile"
              class="font-weight-bold"
              align="center"
              cols="12"
            >
              <v-icon>
                mdi-arrow-down
              </v-icon>
            </v-col>
            <v-col
              class="font-weight-bold"
              align="center"
              cols="12"
              lg="4"
            >
              <v-icon color="#EF5350">
                mdi-check-bold
              </v-icon>
              川崎フロンターレU18
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-col>
</template>

<script>
export default {

}
</script>