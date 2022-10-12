import {toggleFormEnabled} from "./entry";
window.addEventListener("load", (e) => {
  const updateCheck = <HTMLInputElement>document.getElementById("update-form");
  updateCheck.addEventListener("change", (e: any) => {
    toggleFormEnabled(e.target.checked)
  });
  console.log("updateCheck");
})
