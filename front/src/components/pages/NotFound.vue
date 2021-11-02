<template>
  <v-container>
    <div class="not-found pt-10 pb-5">
      <h1
        :class="
          $vuetify.breakpoint.mobile
            ? 'font-weight-bold text-h2'
            : 'font-weight-bold text-h1'
        "
      >
        404
        <span
          :class="
            $vuetify.breakpoint.mobile
              ? 'text-h4 grey--text text--darken-1'
              : 'text-h3 grey--text text--darken-1'
          "
          >Not Found</span
        >
      </h1>
      <div class="mt-10 mb-10 font-weight-bold">
        <p>
          お探しのページは一時的にアクセスができない状況にあるか、移動もしくは削除された可能性があります。
        </p>
        <p>また、URLにお間違いがないか再度ご確認ください。</p>
      </div>
      <v-btn
        color="#3949AB"
        :ripple="false"
        large
        class="font-weight-bold"
        :to="{ name: 'top' }"
      >
        <span class="white--text">トップに戻る</span>
      </v-btn>
    </div>
  </v-container>
</template>

<style scoped>
.not-found {
  margin: 0 auto;
  max-width: 600px;
}
</style>
