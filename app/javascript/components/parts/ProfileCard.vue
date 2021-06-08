<template>
  <v-card outlined>
    <v-simple-table dense>
      <template #default>
        <tbody>
          <tr
            v-for="item in desserts"
            :key="item.name"
          >
            <td
              class="pr-0"
            >
              <span
                class="font-weight-bold"
                style="font-size: 10px"
              >{{ item.name }}</span>
            </td>
            <td
              align="end"
              class="pl-0"
            >
              <span
                class="font-weight-bold"
                style="font-size: 10px"
              >{{ item.calories }}</span>
            </td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>
  </v-card>
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