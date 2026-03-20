function clickSubmitButton() {
  document.querySelectorAll('.js-click-submit-button').forEach(element => {
    element.addEventListener('click', (event) => {
      event.preventDefault()
      const formAction = element.dataset.formAction

      const form = document.querySelector(`form[action="${formAction}"]`)

      if (form.checkValidity()) {
        form.querySelector('[type="submit"]').click()
      }
      else {
        form.reportValidity()
      }
    })
  })
}
  
document.addEventListener('turbo:load', clickSubmitButton);
document.addEventListener('turbo:frame-render', clickSubmitButton);
