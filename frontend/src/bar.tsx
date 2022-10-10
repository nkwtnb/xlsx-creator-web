(() => {
  ReactDOM.render(document.getElementById("root")
})();


// import "./bar.css"
//
// console.log("javascript loaded");
//
// const validate = (form: HTMLFormElement) => {
//   console.log(form);
//   if (form.files.length === 0) {
//     return false;
//   }
//   return true;
// }
//
// const submitUpdate = async (index: number, token: string, description: string, form: Blob) => {
//   const postData = new FormData();
//   console.log("submitUpdate");
//   postData.append("description", description);
//   postData.append("selected_seq", index.toString());
//   if (form) {
//     postData.append("form_file", form);
//   }
//   fetch("/form/update", {
//     headers: {
//       'X-CSRF-Token' : token
//     },
//     method: "POST",
//     body: postData
//   })
//   .then(async res => {
//     location.reload();
//   });
// }
// const clearValues = () => {
//   const updateForm = <HTMLInputElement>document.getElementById("update-form");
//   updateForm.checked = false;
//   const form = <HTMLFormElement>document.getElementById("form_file");
//   form.value = "";
//   form.disabled = true;
//   const description = <HTMLInputElement>document.getElementById("form_description");
//   description.value = "";
// }
// const toggleFormEnabled = (isUpdate: boolean) => {
//   const elements: HTMLInputElement[] = Array.from(document.querySelectorAll(".show-only-update-form"));
//   elements.forEach(element => {
//     element.disabled = !isUpdate
//   });
// }
// type UPDATE_TYPE = "REGISTER" | "UPDATE"
// const toggleStatus = (type: UPDATE_TYPE) => {
//   console.log(type);
//   const showOnlyRegisterElements = document.querySelectorAll(".show-only-register");
//   const showOnlyUpdateElements = Array.from(document.querySelectorAll(".show-only-update"));
//
//   showOnlyRegisterElements.forEach(showOnlyRegisterElement => {
//     showOnlyRegisterElement.classList.add("d-none");
//   });
//   showOnlyUpdateElements.forEach(showOnlyUpdateElement => {
//     showOnlyUpdateElement.classList.add("d-none");
//   });
//   if (type === "REGISTER") {
//     showOnlyRegisterElements.forEach(showOnlyRegisterElement => {
//       showOnlyRegisterElement.classList.remove("d-none");
//     });
//     const form = <HTMLFormElement>document.getElementById("form_file");
//     form.disabled = false;
//
//   } else {
//     showOnlyUpdateElements.forEach(showOnlyUpdateElement => {
//       showOnlyUpdateElement.classList.remove("d-none");
//     });
//   }
// }
//
//   window.addEventListener("load", (e) => {
//     console.log(e);
//     const register = <HTMLInputElement>document.getElementById("register");
//     register.addEventListener("click", (e) => {
//       toggleStatus("REGISTER");
//     });
//     const updateForm = <HTMLInputElement>document.getElementById("update-form");
//     updateForm.addEventListener("change", (e: any) => {
//       toggleFormEnabled(e.target.checked)
//     });
//     register.addEventListener("click", (e) => {
//       toggleStatus("REGISTER");
//     });
//     const myModalEl = <HTMLDivElement>document.getElementById('exampleModal')
//     myModalEl.addEventListener('hidden.bs.modal', function (event) {
//       clearValues();
//     })
//     const buttons = Array.from(document.querySelectorAll(".edit-form"));
//     let clickedIndex = 0;
//     buttons.forEach((element) => {
//       element.addEventListener("click", async (e) => {
//         const token = <HTMLMetaElement>document.querySelectorAll("meta[name=\"csrf-token\"]")[0];
//         const _token = (<HTMLInputElement>e.target)!.parentNode!.querySelectorAll("input[name=\"authenticity_token\"]");
//         console.log(_token);
//         console.log(token.content);
//         toggleStatus("UPDATE");
//         console.log(e.target);
//         // clickedIndex = (buttons.findIndex(button => button === e.target) + 1);
//         const seq = (<HTMLInputElement>document.getElementById("selected_seq"));
//         const selected = <HTMLInputElement>(<HTMLInputElement>e.target)!.parentNode!.querySelector("#seq")
//         clickedIndex = Number(selected.value);
//       });
//     });
//     const submitUpdateButton = <HTMLInputElement>document.getElementById("submit-update");
//     submitUpdateButton.addEventListener("click", async (e) => {
//       const token = (<HTMLMetaElement>document.querySelector("head meta[name=\"csrf-token\"]")!).content;
//       // const token = document.querySelectorAll("form.modal-form input[name=\"authenticity_token\"]")[0];
//       // const token = (<HTMLInputElement>document.querySelectorAll(".modal_form input[name=\"authenticity_token\"]")[0]).value
//       const description = (<HTMLInputElement>document.getElementById("form_description")).value;
//       const form = <HTMLFormElement>document.getElementById("form_file");
//       // if (!validate(form)) {
//       //   return;
//       // }
//       await submitUpdate(clickedIndex, token, description, form.files[0])
//     });
//   });
