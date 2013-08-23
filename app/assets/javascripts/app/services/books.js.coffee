appModule.factory 'BookService', ['$resource', '$q', ($resource, $q) ->

  _resource = $resource '/books/:id', id: '@id',

  service =
    getBooks: ->
      _resource.query()

    getBook: (bookId) ->
      deferred = $q.defer()
      _resource.get id:bookId, (event) ->
        deferred.resolve(event)
      ,
      (response) ->
        deferred.reject(response)

      deferred.promise()


  return service
]
