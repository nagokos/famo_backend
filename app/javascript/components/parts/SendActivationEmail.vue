<template>
  <v-card>
    <v-btn
      icon
      @click="$emit('click-close')"
    >
      <v-icon>
        mdi-close
      </v-icon>
    </v-btn>
    <v-card-title
      class="pt-0 pb-5 font-weight-bold justify-center text-h6"
    >
      認証メール送信
    </v-card-title>
    <v-divider />
    <v-card-text>
      <v-container>
        <v-row>
          <v-col
            cols="12"
            class="pb-0 mt-6"
            align="center"
          >
            <p
              class="font-weight-bold black--text"
            >
              ご登録のアドレスにアカウント認証メールを送信しました
            </p>
          </v-col>
          <v-col
            cols="12"
            class="pt-0"
          >
            <v-sheet
              class="d-flex"
              rounded
              color="grey lighten-3"
              height="50"
            >
              <v-col
                cols="12"
                align="center"
              >
                <p>{{ email }}</p>
              </v-col>
            </v-sheet>
          </v-col>
          <v-col
            cols="12"
            class="py-0"
          >
            <p style="font-size: 10px;">
              ＊リンクをクリックしてアカウントを認証してください。
              <br>
              ＊リンクの有効期限は２４時間以内です。
            </p>
          </v-col>
        </v-row>
      </v-container>
      <slot name="resend" />
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    email: {
      type: String,
      required: true
    }
  }
}
</script>