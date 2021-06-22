<template>
  <v-container>
    <v-row>
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
import InformationCareer from "./InformationCareer"
import InformationRelation from "./InformationRelation"

export default {
  components: {
     InformationCareer,
     InformationRelation
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