$ ->
  settings =
    access_key: "AKIAJDJ6VPIC7FRAMMSQ"
    content_type: "application/pdf"
    bucket: "finishfirstsoftware_mytechbooks"
    key: "5619559594"
    ajax_base: "/aws",
    max_size: 5 * (1 << 30) # 5gb

    on_progress: (bytesUploaded, bytesTotal) ->
      percent = bytesUploaded / bytesTotal * 100
      $('.progress .meter').width(percent / 100 * $('.progress').width())

    on_complete: ->
      console.log "bucket", @settings.bucket
      url = "http://#{@settings.bucket}.s3.amazonaws.com/#{@settings.key}"

  file_list = $("#file_list")

  $("#file").change (e) ->
    file = e.target.files[0]
    if file
      $(this).val ""
      file_row = $("<li>#{file.name}</li>")
      file_row[0].data = file
      console.log file_row
      file_list.append(file_row)
      window.uploader = mule_upload(settings)
      window.uploader.start_upload file, false

  $("#start_book_upload").click (e) ->
    e.preventDefault()
    $("#file").click()

  $("#cancel_book_upload").click (e) ->
    if window.uploader
      window.uploader.cancel ->
        alert "Canceled."
        window.uploader = null


