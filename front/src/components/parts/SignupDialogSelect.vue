<template>
  <v-card color="#FAFAFA">
    <v-btn icon :ripple="false" @click="$emit('click-close')">
      <v-icon> mdi-close </v-icon>
    </v-btn>
    <v-card-title class="pt-0 pb-5 font-weight-bold justify-center text-h6">
      新規登録
    </v-card-title>
    <v-divider />
    <v-container>
      <v-row>
        <v-col cols="12" align="center" class="mt-10">
          <v-btn
            width="250"
            x-large
            :ripple="false"
            class="font-weight-bold"
            @click="$emit('email-register')"
          >
            <v-icon color="#EF5350" class="mr-2"> mdi-email </v-icon>
            <span class="mx-auto">メールアドレスで登録</span>
          </v-btn>
        </v-col>
        <v-col cols="12" align="center">
          <v-btn
            width="250"
            x-large
            :ripple="false"
            class="font-weight-bold"
            @click="$emit('line-agree')"
          >
            <v-img
              src="@/assets/line.png"
              class="mr-2"
              max-width="25"
              max-height="25"
            />
            <span class="mx-auto">LINEで登録</span>
          </v-btn>
        </v-col>
        <v-col cols="12" align="center" class="mb-14">
          <v-btn
            width="250"
            x-large
            :ripple="false"
            class="font-weight-bold text-capitalize"
            href="/api/v1/oauth/google"
          >
            <v-img
              src="@/assets/google.png"
              class="mr-2"
              max-width="25"
              max-height="25"
            />
            <span class="mx-auto"> Googleで登録 </span>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-card>
</template>
