<template>
  <v-container>
    <v-row>
      <!-- 経歴 -->
      <v-col cols="12">
        <information-career />
      </v-col>
      <!-- つながり -->
      <v-col cols="12">
        <information-relation
          :user="user"
        />
      </v-col>
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