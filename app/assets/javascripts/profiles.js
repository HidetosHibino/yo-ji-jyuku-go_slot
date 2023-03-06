// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function previewImage() {
  const target = this.event.target;
  const file = target.files[0];
  const reader  = new FileReader();
  reader.onloadend = function () {
      const preview = document.querySelector("#preview")
      if(preview) {
          preview.src = reader.result;
      }
  }
  if (file) {
      reader.readAsDataURL(file);
  }
}