import {toggleFormEnabled} from "./entry";

const updateCheck = <HTMLInputElement>document.getElementById("update-form");
updateCheck.addEventListener("change", (e: any) => {
  toggleFormEnabled(e.target.checked)
});
