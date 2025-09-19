import { reactive } from 'vue';

export function useForm(initialValues = {}) {
  const form = reactive({ ...initialValues });
  
  const reset = () => {
    Object.keys(initialValues).forEach(key => {
      form[key] = initialValues[key];
    });
  }

  return { form, reset };
}
