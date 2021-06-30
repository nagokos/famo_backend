<template>
  <v-card
    outlined
  >
    <v-simple-table
      dense
    >
      <tbody>
        <v-col
          v-if="!profile"
          align="center"
        >
          <v-btn
            right
            text
            color="primary"
            @click="$emit('click-player')"
          >
            選手情報追加
          </v-btn>
        </v-col>
        <tr
          v-for="data in profileData"
          v-else
          :key="data.id"
        >
          <td
            class="pr-0"
          >
            <span
              class="font-weight-bold"
              style="font-size: 10px"
            >
              {{ data.name }}
            </span>
          </td>
          <td
            align="end"
            class="pl-0"
          >
            <span
              class="font-weight-bold"
              style="font-size: 10px"
            >
              {{ data.information }}
            </span>
          </td>
          <td
            class="px-0"
          >
            <v-btn
              x-small
              icon
            >
              <v-icon
                x-small
                @click="$emit('click-edit', data.name)"
              >
                mdi-pencil
              </v-icon>
            </v-btn>
          </td>
        </tr>
      </tbody>
    </v-simple-table>
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
      isEdit: false,
    }
  },
  methods: {
    changeEdit(name) {
      this.isEdit = true
      this.$nextTick(() => {
        this.$refs.playerTableEdit.change(name)
      })
      this.$emit("click-edit")
    },
    close() {
      this.isEdit = false
    },
    setErrors(errors) {
      this.$refs.playerTableEdit.setErrors(errors)
    }
  }
}
</script>