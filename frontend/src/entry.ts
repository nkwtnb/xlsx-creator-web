// import React from "react";
// import ReactDOM from "react-dom";
// import {Hello} from "./components/Hello";
// (() => {
//   window.addEventListener("load", (e) => {
//     ReactDOM.render(
//       <React.StrictMode>
//         <Hello></Hello>
//       </React.StrictMode>
//       , document.getElementById("root")
//     );
//   });
// })();
import "./modal";
import "./registerButton";
import "./updateButton";
import "./updateCheck";
import "./bar.css";
import "./deleteButton";
import {setSelectedIndexText} from "./deleteButton";
import {clearErrorMessage, setErrorMessage} from "./modal";

type UPDATE_TYPE = "REGISTER" | "UPDATE"

console.log("Hello, entry.ts");

let selectedIndex = -1;
export const getSelectedIndex = (): number => {
  return selectedIndex;
}
window.addEventListener("load", (e) => {
  console.log("getselected index");
  const buttons = Array.from(document.querySelectorAll(".delete-button"));
  buttons.forEach((element) => {
    element.addEventListener("click", (e) => {
      const selected = <HTMLInputElement>(<HTMLInputElement>e.target)!.parentNode!.querySelector("#seq")
      selectedIndex = Number(selected.value);
      setSelectedIndexText(selectedIndex.toString());
    });
  });
});

export const getParam = () => {
  const updateForm = (<HTMLInputElement>document.getElementById("update-form")).checked;
  const description = (<HTMLInputElement>document.getElementById("form_description")).value;
  const form = <HTMLFormElement>document.getElementById("form_file");
  return {
    description,
    form,
    updateForm,
  };
}

export const getToken = () => {
  const token = (<HTMLMetaElement>document.querySelector("head meta[name=\"csrf-token\"]")!).content;
  return token;
}

export const submit = async (type: UPDATE_TYPE, token: string, description: string, form: Blob, isUpdateForm?: boolean, index?: number) => {
  clearErrorMessage();
  const postData = new FormData();
  postData.append("description", description);
  if (index !== undefined) {
    postData.append("selected_seq", index.toString());
  }
  if (form) {
    postData.append("form_file", form);
  }
  if (type === "UPDATE" && isUpdateForm !== undefined) {
    postData.append("is_update_form", isUpdateForm.toString())
  }
  const URL = type === "REGISTER" ? "/form/create" : "/form/update";
  fetch(URL, {
    headers: {
      'X-CSRF-Token' : token
    },
    method: "POST",
    body: postData
  })
  .then(async res => {
    if (res.status === 200) {
      location.reload();
      return;
    } else {
      const resp = await res.json();
      setErrorMessage(resp.message);
    }
  });
}

const validate = (form: HTMLFormElement) => {
  console.log(form);
  if (form.files.length === 0) {
    return false;
  }
  return true;
}
export const toggleFormEnabled = (isUpdate: boolean) => {
  const elements: HTMLInputElement[] = Array.from(document.querySelectorAll(".show-only-update-form"));
  elements.forEach(element => {
    element.disabled = !isUpdate
  });
}
export const toggleStatus = (type: UPDATE_TYPE) => {
  console.log("toggle");
  const showOnlyRegisterElements = document.querySelectorAll(".show-only-register");
  const showOnlyUpdateElements = Array.from(document.querySelectorAll(".show-only-update"));

  showOnlyRegisterElements.forEach(showOnlyRegisterElement => {
    showOnlyRegisterElement.classList.add("d-none");
  });
  showOnlyUpdateElements.forEach(showOnlyUpdateElement => {
    showOnlyUpdateElement.classList.add("d-none");
  });
  if (type === "REGISTER") {
    showOnlyRegisterElements.forEach(showOnlyRegisterElement => {
      showOnlyRegisterElement.classList.remove("d-none");
    });
    const form = <HTMLFormElement>document.getElementById("form_file");
    form.disabled = false;

  } else {
    showOnlyUpdateElements.forEach(showOnlyUpdateElement => {
      showOnlyUpdateElement.classList.remove("d-none");
    });
  }
}
