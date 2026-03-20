function reloadFrameOnChange() {
  document.querySelectorAll('.js-reload-turbo-frame-on-change').forEach(element => {
    element.addEventListener('change', () => {
      const formData = new FormData(element.form);
      formData.delete('authenticity_token');
      const url = '?' + new URLSearchParams(formData).toString();
      element.closest('turbo-frame').src = url;
    });
  });
}

document.addEventListener('turbo:load', reloadFrameOnChange);
document.addEventListener('turbo:frame-render', reloadFrameOnChange);