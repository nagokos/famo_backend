<template>
  <v-col
    class="pl-10"
    lg="4"
  >
    <v-card
      outlined
    >
      <v-simple-table dense>
        <template #default>
          <tbody>
            <template>
              <v-col align="center">
                <v-btn
                  right
                  text
                  color="primary"
                  @click="$emit('click-player')"
                >
                  選手情報追加
                </v-btn>
              </v-col>
            </template>
          </tbody>
        </template>
      </v-simple-table>
    </v-card>
  </v-col>
</template>

<script>
export default {
  data() {
    return {
      rating: 3.1,
      desserts: [
          {
            name: "所属",
            calories: "川崎フロンターレU18",
          },
          {
            name: "ポジション",
            calories: "MF",
          },
          {
            name: "背番号",
            calories: 10,
          },
        ],
    }
  },
}
</script>

<style scoped>
  .v-data-table
    tbody
    tr:hover:not(.v-data-table__expanded__content) {
    background: #ffffff !important;
  }
</style>