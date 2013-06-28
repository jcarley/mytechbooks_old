$ ->
  file = $("#file")[0]
  settings =
    access_key: "AKIAJDJ6VPIC7FRAMMSQ"
    content_type: "application/pdf"
    bucket: "finishfirstsoftware_mytechbooks"
    key: "5619559594"
    ajax_base: "/aws",
    max_size: 5 * (1 << 30) # 5gb
    on_error: ->
      $('#log').prepend "Error occurred! You can help me fix this by filing a bug report here: https://github.com/cinely/mule-uploader/issues\n"

    on_select: (fileObj) ->
      $('#log').prepend "File selected\n"

    on_start: (fileObj) ->
      $('#explanation').animate 'opacity': 0, 'slow', ->
        $(this).text "Now, let the file upload for a bit (more than 6MB, because it uploads in chunks of 6MB), then refresh the page and select the file again. It will blow your mind :) "
        $(this).animate 'opacity': 1, 'slow'

      $('#log').prepend "Upload started\n"

    on_progress: (bytesUploaded, bytesTotal) ->
      percent = bytesUploaded / bytesTotal * 100
      $('.progress .bar').width(percent / 100 * $('.progress').width())
      $('#log').prepend("Upload progress: #{bytesUploaded} / #{bytesTotal} (#{parseInt(percent)}.#{parseInt(percent * 10) % 10}%)\n")

    on_init: ->
      $('#log').prepend("Uploader initialized\n")

    on_complete: ->
      console.log "bucket", @settings.bucket
      url = "http://#{@settings.bucket}.s3.amazonaws.com/#{@settings.key}"
      $('#log').prepend("Upload complete!\n")
      $('#log').prepend("The file url is #{url}.\n")

    on_chunk_uploaded: ->
      $('#log').prepend("Chunk finished uploading\n")

  upload = mule_upload(file, settings)
  console.log "uploader: ", upload
