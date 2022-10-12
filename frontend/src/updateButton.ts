import {getParam, getToken, toggleStatus} from "./entry";
import {submit} from "./entry";

window.addEventListener("load", (e) => {
  console.log("updateButton");
  const buttons = Array.from(document.querySelectorAll(".edit-form"));
  let clickedIndex = 0;
  buttons.forEach((element) => {
    element.addEventListener("click", async (e) => {
      toggleStatus("UPDATE");
      const selected = <HTMLInputElement>(<HTMLInputElement>e.target)!.parentNode!.querySelector("#seq")
      clickedIndex = Number(selected.value);
    });
  });
  const submitUpdateButton = <HTMLInputElement>document.getElementById("submit-update");
  submitUpdateButton.addEventListener("click", async (e) => {
    const token = getToken();
    const param = getParam();
    await submit("UPDATE", token, param.description, param.form.files[0], clickedIndex)
  });
})
