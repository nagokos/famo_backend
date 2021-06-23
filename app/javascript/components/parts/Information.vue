<template>
  <v-container>
    <v-row>
      <information-player
        v-if="$vuetify.breakpoint.mobile"
        :profile="profile"
        @click-player="$emit('click-player')"
      />
      <!-- 経歴 -->
      <information-career />
      <!-- つながり -->
      <information-relation
        :user="user"
      />
    </v-row>
  </v-container>
</template>

<script>
import InformationPlayer from "./InformationPlayer"
import InformationCareer from "./InformationCareer"
import InformationRelation from "./InformationRelation"

export default {
  components: {
    InformationPlayer,
    InformationCareer,
    InformationRelation
  },
  props: {
    user: {
      type: Object,
      default: () => {},
      required: true
    },
    profile: {
      type: Object,
      default: () => {},
      required: false
    }
  }
}
</script>