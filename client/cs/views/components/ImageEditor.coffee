class ImageEditor
  constructor: (@el) ->
    fileSelect = @el.querySelector('input[type=file]')
    fileSelect.addEventListener("change", (evt) =>
      @onFileChange(evt.currentTarget)
    )

  ###
  lastModifiedDate: Tue Feb 28 2012 12:55:17 GMT+0100 (CET)
  name: "Bildschirmfoto 2012-02-28 um 12.55.12.png"
  size: 42201
  type: "image/png"
  webkitRelativePath: ""
  ###
  onFileChange: (el) ->
    files = el.files

    # for know, take the first file found
    unless files.length is 0 and not files[0].type.match('image.*')
      reader = new FileReader()
      imgFile = files[0]
      filename = imgFile.name
      type = imgFile.type

      reader.onload = (e) =>
        url = e.target.result
        image = new Image()
        image.src = url
        image.alt = filename
        editor = @el.querySelector('.editor')
        editor.innerHTML = ""
        editor.className = "editor"
        editor.appendChild(image)

      reader.readAsDataURL imgFile
  