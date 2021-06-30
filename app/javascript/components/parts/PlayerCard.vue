<template>
  <v-card
    outlined
    elevation="1"
  >
    <v-card-title
      v-if="!profile"
      class="font-weight-bold"
    >
      選手
      <v-spacer />
      <v-btn
        color="primary"
        text
        @click="$emit('click-player')"
      >
        選手情報を追加
      </v-btn>
    </v-card-title>
    <div
      v-for="data in profileData"
      v-else
      :key="data.id"
    >
      <v-card-title class="font-weight-bold">
        {{ data.name }}
        <v-spacer />
        <v-btn
          icon
          @click="$emit('click-edit', data.name)"
        >
          <v-icon>
            mdi-pencil
          </v-icon>
        </v-btn>
      </v-card-title>
      <v-card-text
        align="center"
        class="font-weight-bold"
        style="color: rgba(0,0,0,.6);"
      >
        {{ data.information }}
      </v-card-text>
    </div>
  </v-card>
</template>

<script>
export default {
  props: {
    profile: {
      type: Object,
      default: () => {},
      required: false
    },
     profileEdit: {
      type: Object,
      default: () => {},
      required: true
    }
  },
  data() {
    return {
      isEdit: false
    }
  },
  methods: {
    changeEdit(name) {
      this.isEdit = true
      this.$nextTick(() => {
        this.$refs.playerCardEdit.change(name)
      })
      this.$emit("click-edit")
    },
    close() {
      this.isEdit = false
    },
    setErrors(errors) {
      this.$refs.playerCardEdit.setErrors(errors)
    }
  }
}
</script>