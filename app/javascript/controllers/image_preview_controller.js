import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  previewImage() {
    const input = this.inputTarget
    const preview = this.previewTarget

    if (!input.files || !input.files[0]) return

    const file = input.files[0]

    if (!file.type.startsWith('image/')) {
      preview.innerHTML = '<p class="text-red-500">有効な画像ファイルを選択してください。</p>'
      return
    }

    const reader = new FileReader()
    reader.onload = (e) => {
      preview.innerHTML = `<img src="${e.target.result}" alt="Preview" class="mt-1 rounded" style="max-width: 300px; max-height: 200px;">`
    }
    reader.readAsDataURL(file)
  }
}
