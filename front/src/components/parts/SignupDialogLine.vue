<template>
  <v-card color="#FAFAFA">
    <v-btn icon :ripple="false" @click="$emit('click-back')">
      <v-icon> mdi-arrow-left </v-icon>
    </v-btn>
    <v-card-title class="pt-0 pb-5 font-weight-bold justify-center text-h6">
      LINEで登録
    </v-card-title>
    <v-divider />
    <v-card-text class="pb-0">
      <v-container>
        <v-row>
          <v-col
            cols="12"
            :class="$vuetify.breakpoint.mobile ? 'mt-4 px-0' : 'mt-4'"
          >
            本Webサービスでは、認証画面にて許可をいただいた場合のみ、あなたのLINEアカウントに登録されているメールアドレスを取得します。
            <br />
            取得したメールアドレスは、以下の目的以外では使用いたしません。また、法令に定められた場合を除き、第三者への提供はいたしません。
            <br />
            <ul>
              <li>ユーザーIDとしてアカウントの管理に利用</li>
              <li>お知らせがある際に登録のアドレスに通知</li>
            </ul>
          </v-col>
          <v-col
            cols="12"
            align="center"
            :class="$vuetify.breakpoint.mobile ? 'mb-7 px-0' : 'mb-7'"
          >
            <v-divider />
            <v-btn
              width="250"
              x-large
              :ripple="false"
              class="font-weight-bold mt-8"
              href="/api/v1/oauth/line"
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
        </v-row>
      </v-container>
    </v-card-text>
  </v-card>
</template>

<script>
export default {};
</script>
