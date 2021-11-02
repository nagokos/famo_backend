<template>
  <v-dialog
    v-model="dialog"
    width="400"
    :fullscreen="$vuetify.breakpoint.mobile"
    :transition="
      $vuetify.breakpoint.mobile
        ? 'dialog-bottom-transition'
        : 'dialog-transition'
    "
    :persistent="true"
  >
    <v-card color="#FAFAFA">
      <v-card-actions class="py-3">
        <v-btn icon :ripple="false" @click="close">
          <v-icon> mdi-close </v-icon>
        </v-btn>
        <v-spacer />
        <v-btn
          color="#3949AB"
          dark
          rounded
          depressed
          width="80"
          class="text-caption font-weight-bold"
          @click="sizeApply"
        >
          適用する
        </v-btn>
      </v-card-actions>
      <v-divider />
      <v-card-text>
        <vue-cropper
          ref="cropper"
          style="height: 400px"
          :img="blobUrl"
          :auto-crop="true"
        />
        <v-slider
          v-model="size"
          class="mt-4"
          max="20"
          hide-details
          append-icon="mdi-magnify-plus-outline"
          prepend-icon="mdi-magnify-minus-outline"
          @input="changeSize"
          @click:append="plusSize"
          @click:prepend="minusSize"
        />
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    blobUrl: {
      type: String,
      default: "",
      required: true,
    },
    fileName: {
      type: String,
      default: "",
      required: true,
    },
  },
  data() {
    return {
      dialog: false,
      size: 0,
      oldSize: 0,
    };
  },
  methods: {
    open() {
      this.dialog = true;
    },
    close() {
      Object.assign(this.$data, this.$options.data());
    },
    changeSize() {
      const size = this.size - this.oldSize;
      this.$refs.cropper.changeScale(size);
      this.oldSize = this.size;
    },
    minusSize() {
      if (this.size <= 0) return;
      this.size -= 1;
      this.$refs.cropper.changeScale(-1);
      this.oldSize = this.size;
    },
    plusSize() {
      if (this.size >= 20) return;
      this.size += 1;
      this.$refs.cropper.changeScale(1);
      this.oldSize = this.size;
    },
    sizeApply() {
      this.$refs.cropper.getCropBlob((data) => {
        // do something
        const file = new File([data], this.fileName);
        this.$emit("set-avatar", file);
        this.dialog = false;
      });
    },
  },
};
</script>
