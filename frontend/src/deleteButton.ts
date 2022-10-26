import {getSelectedIndex, getToken} from "./entry";
const submit = (token: string, index: number) => {
  const postData = new FormData();
  postData.append("selected_seq", index.toString());
  fetch("/form/delete", {
    headers: {
      'X-CSRF-Token' : token
    },
    method: "DELETE",
    body: postData
  })
  .then(async res => {
    if (res.status === 200) {
      location.reload();
      return;
    }
  });
}
window.addEventListener("load", (e) => {
  const submitButton = <HTMLInputElement>document.getElementById("submit-delete");
  submitButton.addEventListener("click", async (e) => {
    const token = getToken();
    const index = getSelectedIndex();
    await submit(token, index)
  });
})
export const setSelectedIndexText = (index: string) => {
  const deleteFormIdElement = document.getElementById("delete-form-id")
  deleteFormIdElement!.textContent = index;
}
