const clearValues = () => {
  console.log("clead");
  const updateForm = <HTMLInputElement>document.getElementById("update-form");
  updateForm.checked = false;
  const form = <HTMLFormElement>document.getElementById("form_file");
  form.value = "";
  form.disabled = true;
  const description = <HTMLInputElement>document.getElementById("form_description");
  description.value = "";
}
window.addEventListener("load", (e) => {
  const myModalEl = <HTMLDivElement>document.getElementById('exampleModal')
  myModalEl.addEventListener('hidden.bs.modal', function (event) {
    clearValues();
  })
})
