<template>
  <div>
    <v-list color="#FAFAFA">
      <v-list-item class="px-0">
        <v-list-item-content>
          <v-list-item-title class="font-weight-bold">
            パスワード変更
          </v-list-item-title>
          <v-list-item-subtitle :class="$vuetify.breakpoint.mobile ? 'mt-1 text-wrap text-caption' : 'mt-1'">
            新しいパスワードに変更できます
          </v-list-item-subtitle>
          <v-btn
            v-if="$vuetify.breakpoint.mobile"
            max-width="90"
            class="font-weight-bold text-caption mt-1"
          >
            変更する
          </v-btn>
        </v-list-item-content>
        <v-btn
          v-if="!$vuetify.breakpoint.mobile"
          class="font-weight-bold"
        >
          変更する
        </v-btn>
      </v-list-item>
      <v-divider
        class="mt-3"
      />
      <v-list-item class="px-0 mt-3">
        <v-list-item-content>
          <v-list-item-title class="font-weight-bold">
            選手登録解除
          </v-list-item-title>
          <v-list-item-subtitle :class="$vuetify.breakpoint.mobile ? 'mt-1 text-wrap text-caption' : 'mt-1'">
            選手登録が解除され評価を受けることができなくなります
          </v-list-item-subtitle>
          <v-btn
            v-if="$vuetify.breakpoint.mobile"
            max-width="90"
            class="font-weight-bold text-caption mt-1"
            :disabled="user.role !== 'player'"
            @click="$refs.playerReleaseDialog.open()"
          >
            解除する
          </v-btn>
        </v-list-item-content>
        <v-btn
          v-if="!$vuetify.breakpoint.mobile"
          class="font-weight-bold"
          :disabled="user.role !== 'player'"
          @click="$refs.playerReleaseDialog.open()"
        >
          解除する
        </v-btn>
      </v-list-item>
      <v-divider
        class="mt-3"
      />
      <v-list-item class="px-0 mt-3">
        <v-list-item-content>
          <v-list-item-title class="font-weight-bold">
            退会
          </v-list-item-title>
          <v-list-item-subtitle :class="$vuetify.breakpoint.mobile ? 'mt-1 text-wrap text-caption' : 'mt-1'">
            Famoのサービスを利用できなくなります
          </v-list-item-subtitle>
          <v-btn
            v-if="$vuetify.breakpoint.mobile"
            max-width="90"
            class="font-weight-bold text-caption mt-1"
          >
            退会する
          </v-btn>
        </v-list-item-content>
        <v-btn
          v-if="!$vuetify.breakpoint.mobile"
          class="font-weight-bold"
        >
          退会する
        </v-btn>
      </v-list-item>
      <v-divider
        class="mt-3"
      />
    </v-list>
    <the-player-release-dialog
      ref="playerReleaseDialog"
      @update-user="$emit('update-user')"
    />
  </div>
</template>

<script>
import ThePlayerReleaseDialog from "../parts/ThePlayerReleaseDialog"

export default {
  components: {
    ThePlayerReleaseDialog
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    }
  }
}
</script>