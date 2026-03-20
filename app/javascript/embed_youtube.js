import Trix from 'trix'

let lang = Trix.config.lang

function linkDialog() {
  return `
  <div class="trix-dialog__link-fields">
    <input type="url" name="href" id="trix-link-url-input" class="trix-input trix-input--dialog" placeholder="${lang.urlPlaceholder}" aria-label="${lang.url}" data-trix-input>
    <div class="flex">
      <input type="button" class="trix-button trix-button--dialog" value="${lang.link}" data-trix-method="setAttribute">
      <input type="button" class="trix-button trix-button--dialog" value="${lang.unlink}" data-trix-method="removeAttribute">
    </div>
  </div>
  <div data-behavior="embed_container" class="mt-2">
    <div class="link_to_embed link_to_embed--new">
      Would you like to embed media from this site?
      <input class="btn-primary mt-5 ml-2" type="button" data-behavior="embed_url" value="Yes, embed it">
    </div>
  </div>
`
}

class EmbedTrixVideo {
  constructor(element) {
    this.youtubePattern = /^https:\/\/([^]+\.)?youtube\.com\/watch\?v=(.*)/

    this.element = element
    this.editor = element.editor
    this.toolbar = element.toolbarElement
    this.hrefElement = this.toolbar.querySelector("[data-trix-input][name='href']")
    this.embedContainerElement = this.toolbar.querySelector("[data-behavior='embed_container']")
    this.embedElement = this.toolbar.querySelector("[data-behavior='embed_url']")

    this.reset()
    this.installEventHandlers()
  }

  installEventHandlers() {
    this.hrefElement.addEventListener('input', this.didInput.bind(this))
    this.hrefElement.addEventListener('focusin', this.didInput.bind(this))
    this.embedElement.addEventListener('click', this.embed.bind(this))
  }

  async didInput(event) {
    let value = event.target.value.trim()
    let matches = value.match(this.youtubePattern)

    if (matches != null) {
      const videoId = matches[2]
      try {
        const response = await fetch(`/embedded_youtube/${encodeURIComponent(videoId)}`)
        const body = await response.json()
        this.showEmbed(body)
      } catch (e) {
        this.reset()
      }
    } else {
      this.reset()
    }
  }

  embed() {
    if (this.currentEmbed == null) {
      return
    }

    let attachment = new Trix.Attachment(this.currentEmbed)
    this.editor.insertAttachment(attachment)
    this.element.focus()
  }

  showEmbed(embed) {
    this.currentEmbed = embed
    this.embedContainerElement.style.display = 'block'
  }

  reset() {
    this.embedContainerElement.style.display = 'none'
    this.currentEmbed = null
  }
}

document.addEventListener('trix-initialize', (event) => {
  window.trixEditorLoaded = true
  document.querySelectorAll('.trix-dialog--link').forEach((dialog) => {
    dialog.innerHTML = linkDialog()
  })

  new EmbedTrixVideo(event.target)
})
