if @book
  json.(@book)
else
  json.error 'Unable to register book with isbn equal to'
end
