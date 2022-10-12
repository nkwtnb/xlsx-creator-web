import {getParam, getToken, submit, toggleStatus} from "./entry";

window.addEventListener("load", (e) => {
  const register = <HTMLInputElement>document.getElementById("register");
  register.addEventListener("click", (e) => {
    toggleStatus("REGISTER");
  });
  const submitButton = <HTMLInputElement>document.getElementById("submit-register");
  submitButton.addEventListener("click", async (e) => {
    const token = getToken();
    const param = getParam();
    await submit("REGISTER", token, param.description, param.form.files[0])
  });
});
