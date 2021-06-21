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
