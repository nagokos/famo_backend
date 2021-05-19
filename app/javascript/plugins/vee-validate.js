import { ValidationObserver, ValidationProvider, extend, setInteractionMode } from 'vee-validate'
import { required, max, min, email } from 'vee-validate/dist/rules';

setInteractionMode("eager");

extend("required", {
  ...required,
  message: "{_field_}を入力してください"
})

extend("email", {
  ...email,
  message: "{_field_}を正しく入力してください"
})

extend("max", {
  ...max,
  message: "{_field_}は{length}文字以内で入力してください"
})

extend("min", {
  ...min,
  message: "{_field_}は{length}文字以上で入力してください"
})

extend("birthDateFormat", {
  validate(value) {
    return value.match(/\d{4}-\d{2}-\d{2}/)
  },
  message: "入力形式が正しくありません"
})


export default {
  components: {
    ValidationObserver,
    ValidationProvider
  }
}