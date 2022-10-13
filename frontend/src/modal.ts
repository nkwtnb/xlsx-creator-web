const clearModal = () => {
  const updateForm = <HTMLInputElement>document.getElementById("update-form");
  updateForm.checked = false;
  const form = <HTMLFormElement>document.getElementById("form_file");
  form.value = "";
  form.disabled = true;
  const description = <HTMLInputElement>document.getElementById("form_description");
  description.value = "";
  clearErrorMessage();
}
const getErrorMessageElement = (): HTMLElement => {
  const e = document.getElementById("error-message");
  if (!e) {
    throw Error(`undefined element #error-message`);
  }
  return e;
}
export const clearErrorMessage = () => {
  const e = getErrorMessageElement();
  e.classList.add("d-none");
  e.textContent = "";
}
export const setErrorMessage = (message: string) => {
  const e = getErrorMessageElement();
  e.classList.remove("d-none");
  e.textContent = message;
}
window.addEventListener("load", (e) => {
  const myModalEl = <HTMLDivElement>document.getElementById('exampleModal')
  myModalEl.addEventListener('hidden.bs.modal', function (event) {
    clearModal();
  })
});
