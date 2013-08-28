appModule.controller 'HomeController', ['$scope', 'BookService', ($scope, bookService) ->

  $scope.books = bookService.getBooks()

]
