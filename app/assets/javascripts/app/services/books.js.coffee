app.factory 'BookService', ['$resource', (resource) ->
  service = resource '/books/:id',  id: '@id',

  return service
]
