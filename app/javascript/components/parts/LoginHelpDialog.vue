<template>
  <v-dialog
    v-model="dialog"
    width="500"
    :persistent="true"
  >
    <v-card>
      <v-btn
        icon
        @click="closeDialog"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
      <v-card-title
        class="pt-0 font-weight-black justify-center"
      >
        ログインでお困りの方
      </v-card-title>
      <v-divider />
      <v-card-text :class="$vuetify.breakpoint.mobile? 'px-0':''">
        <v-container>
          <v-row>
            <v-col class="px-0 py-0 mt-3">
              <v-list nav>
                <v-list-group
                  v-for="item in items"
                  :key="item.question"
                  v-model="item.active"
                  :prepend-icon="item.action"
                >
                  <template #activator>
                    <v-list-item-content>
                      {{ item.question }}
                    </v-list-item-content>
                  </template>

                  <v-list-item
                    v-for="child in item.items"
                    :key="child.answer"
                  >
                    <v-list-item-icon>
                      <v-icon color="red">
                        mdi-alpha-a-circle
                      </v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                      {{ child.answer }}
                    </v-list-item-content>
                  </v-list-item>
                </v-list-group>
              </v-list>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      items: [
        {
          action: "mdi-alpha-q-circle",
          question: "メールアドレスが間違っていると表示される",
          items: [{ answer: `入力されたメールアドレスをご確認の上、再度お試しください。
                             何度お試しいただいても間違っていると表示される場合は、
                             新規登録ができていない可能性がございます。
                             新規登録時にはアカウント認証メールをお送りしているのでご確認ください。` }],
        },
        {
          action: "mdi-alpha-q-circle",
          question: "アカウントを認証してくださいと表示される",
          items: [{ answer: `アカウントを認証するまでは、ログインすることができません。
                             新規登録時にお送りしている、アカウント認証メールのリンクをクリックして、
                             アカウントを認証してください。認証メールを紛失してしまった方は、
                             再度認証メールを取得し、アカウントを認証してください。` }]
        },
        {
          action: "mdi-alpha-q-circle",
          question: "パスワードが間違っていると表示される",
          items: [{ answer: `入力されたパスワードをご確認の上、もう一度お試しください。
                             パスワードをお忘れの方は、パスワードを再設定の上、再度お試しください。`}]
        }
      ]
    }
  },
  methods: {
    open() {
      this.dialog = true
    },
    closeDialog() {
      Object.assign(this.$data, this.$options.data())
    }
  }
}
</script>