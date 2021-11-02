<template>
  <div class="terms">
    <v-card
      elevation="0"
      :class="$vuetify.breakpoint.mobile ? '' : 'mt-15 '"
      :color="$vuetify.breakpoint.mobile ? '#FAFAFA' : 'white'"
    >
      <v-card-title class="justify-center text-h5 font-weight-bold py-8">
        利用規約
      </v-card-title>
      <v-divider />
      <v-card-text
        :class="
          $vuetify.breakpoint.mobile
            ? 'px-1 black--text mt-3'
            : 'px-10 black--text mt-3'
        "
      >
        <v-container>
          <v-row>
            <v-col cols="12">
              この利用規約（以下、「本規約」といいます。）は、本ウェブサイト上で提供するサービス（以下、「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下、「ユーザー」といいます。）には、本規約に同意して頂いたうえで、本サービスをご利用いただきます。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第1条（適用）
            </v-col>
            <v-col cols="12" class="pt-0">
              本規約は、ユーザーと本サービス運営者（以下、「運営者」といいます。）との間の本サービスの利用に関わる一切の関係に適用されるものとします。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第2条（利用登録）
            </v-col>
            <v-col cols="12" class="pt-0">
              本サービスにおいては、登録希望者が本規約に同意の上、登録手続きを行うことができるものとします。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第3条（ユーザーIDおよびパスワードの管理）
            </v-col>
            <v-col cols="12" class="pt-0">
              <ol>
                <li>
                  ユーザーは、自己の責任において、本サービスのユーザーIDおよびパスワードを適切に管理するものとします。
                </li>
                <li>
                  ユーザーは、いかなる場合にも、ユーザーIDおよびパスワードを第三者に譲渡または貸与し、もしくは第三者と共用することはできません。本サービスで、ユーザーIDとパスワードの組み合わせが登録情報と一致してログインされた場合には、そのユーザーIDを登録しているユーザー自身による利用とみなします。
                </li>
                <li>
                  本サービスで、会員ID及びパスワードの盗用、不正利用等により会員のアカウントが当該会員以外の第三者に利用された場合であっても、それにより当該会員に生じた損害について一切責任を負わないものとします。
                </li>
              </ol>
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第4条（禁止事項）
            </v-col>
            <v-col cols="12" class="pt-0">
              ユーザーは、本サービスの利用にあたり、以下の行為をしてはなりません。
              <ol class="mt-4">
                <li>法令または公序良俗に違反する行為</li>
                <li>犯罪行為に関連する行為</li>
                <li>
                  本サービスの内容等、本サービスに含まれる著作権、商標権ほか知的財産権を侵害する行為
                </li>
                <li>
                  本サービス、ほかのユーザー、またはその他第三者のサーバーまたはネットワークの機能を破壊したり、妨害したりする行為
                </li>
                <li>本サービスによって得られた情報を商業的に利用する行為</li>
                <li>本サービスの運営を妨害するおそれのある行為</li>
                <li>不正アクセスをし、またはこれを試みる行為</li>
                <li>他のユーザーに関する個人情報等を収集または蓄積する行為</li>
                <li>不正な目的を持って本サービスを利用する行為</li>
                <li>
                  本サービスの他のユーザーまたはその他の第三者に不利益、損害、不快感を与える行為
                </li>
                <li>他のユーザーに成りすます行為</li>
                <li>
                  本サービスが許諾しない本サービス上での宣伝、広告、勧誘、または営業行為
                </li>
                <li>面識のない異性との出会いを目的とした行為</li>
                <li>
                  本サービスに関連して、反社会的勢力に対して直接または間接に利益を供与する行為
                </li>
                <li>その他、運営者が不適切と判断する行為</li>
              </ol>
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第5条（本サービスの提供の停止等）
            </v-col>
            <v-col cols="12" class="pt-0">
              運営者は、以下のいずれかの事由があると判断した場合、ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。
              <ol class="mt-4 mb-4">
                <li>
                  本サービスにかかるコンピュータシステムの保守点検または更新を行う場合
                </li>
                <li>
                  地震、落雷、火災、停電または天災などの不可抗力により、本サービスの提供が困難となった場合
                </li>
                <li>コンピュータまたは通信回線等が事故により停止した場合</li>
                <li>その他、運営者が本サービスの提供が困難と判断した場合</li>
              </ol>
              運営者は、本サービスの提供の停止または中断により、ユーザーまたは第三者が被ったいかなる不利益または損害についても、一切の責任を負わないものとします。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第6条（利用制限および登録抹消）
            </v-col>
            <v-col cols="12" class="pt-0">
              運営者は、ユーザーが以下のいずれかに該当する場合には、事前の通知なく、ユーザーに対して、本サービスの全部もしくは一部の利用を制限し、またはユーザーとしての登録を抹消することができるものとします。
              <ol class="mt-4 mb-4">
                <li>本規約のいずれかの条項に違反した場合</li>
                <li>登録事項に虚偽の事実があることが判明した場合</li>
                <li>
                  その他、運営者が本サービスの利用を適当でないと判断した場合
                </li>
              </ol>
              運営者は、本条に基づき運営者が行った行為によりユーザーに生じた損害について、一切の責任を負いません。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第7条（退会）
            </v-col>
            <v-col cols="12" class="pt-0">
              ユーザーは、いつでも本サービスから退会することができます。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第8条（保証の否認および免責事項）
            </v-col>
            <v-col cols="12" class="pt-0">
              <ol>
                <li>
                  運営者は、本サービスに事実上または法律上の瑕疵（安全性、信頼性、正確性、完全性、有効性、特定の目的への適合性、セキュリティなどに関する欠陥、エラーやバグ、権利侵害などを含みます。）がないことを明示的にも黙示的にも保証しておりません。
                </li>
                <li>
                  運営者は、本サービスに関して、ユーザーと他のユーザーまたは第三者との間において生じた取引、連絡または紛争等について一切責任を負いません。
                </li>
              </ol>
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第9条（サービス内容の変更等）
            </v-col>
            <v-col cols="12" class="pt-0">
              運営者は、ユーザーに通知することなく、本サービスの内容を変更しまたは本サービスの提供を中止することができるものとし、これによってユーザーに生じた損害について一切の責任を負いません。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第10条（利用規約の変更）
            </v-col>
            <v-col cols="12" class="pt-0">
              運営者は、必要と判断した場合には、ユーザーに通知することなくいつでも本規約を変更することができるものとします。なお、本規約の変更後、本サービスの利用を開始した場合には、当該ユーザーは変更後の規約に同意したものとみなします。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第11条（個人情報の取扱い）
            </v-col>
            <v-col cols="12" class="pt-0">
              運営者は、本サービスの利用によって取得する個人情報については、<span
                class="blue--text text--darken-2"
                style="cursor: pointer"
                @click="$router.push({ name: 'privacy' }, () => {})"
                >プライパシーポリシー</span
              >に従い適切に取り扱うものとします。
            </v-col>
            <v-col
              cols="12"
              :class="
                $vuetify.breakpoint.mobile
                  ? 'text-h6 font-weight-bold mt-3'
                  : 'text-h5 font-weight-bold mt-5'
              "
            >
              第12条（通知または連絡）
            </v-col>
            <v-col cols="12" class="pt-0">
              ユーザーと運営者との間の通知または連絡は、運営者の定める方法によって行うものとします。
            </v-col>
            <v-col align="end" cols="12"> 以上 </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
export default {
  mounted() {
    this.toTop();
  },
};
</script>

<style scoped>
.terms {
  max-width: 900px;
  margin: 0 auto;
}
li {
  margin-bottom: 10px;
}
</style>
