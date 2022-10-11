import {toggleFormEnabled} from "./entry";

const updateForm = <HTMLInputElement>document.getElementById("update-form");
updateForm.addEventListener("change", (e: any) => {
  toggleFormEnabled(e.target.checked)
});
