import {
  ValidationObserver,
  ValidationProvider,
  extend,
  setInteractionMode,
} from "vee-validate";
import {
  required,
  max,
  min,
  numeric,
  confirmed,
} from "vee-validate/dist/rules";

setInteractionMode("eager");

extend("required", {
  ...required,
  message: "{_field_}は必須項目です",
});

extend("max", {
  ...max,
  message: "{_field_}は{length}文字以内で入力してください",
});

extend("min", {
  ...min,
  message: "{_field_}は{length}文字以上で入力してください",
});

extend("numeric", {
  ...numeric,
  message: "{_field_}は数字のみ入力可能です",
});

extend("passwordConfirmed", {
  ...confirmed,
  message: "パスワードが一致していません",
});

extend("formFormat", {
  params: ["format"],
  validate(value, { format }) {
    return value.match(format);
  },
  message: "入力形式が正しくありません",
});

export default {
  components: {
    ValidationObserver,
    ValidationProvider,
  },
};
