appModule.controller 'HomeController', ['$scope', 'BookService' ($scope, bookService) ->

  bookService.index (data) ->
    $scope.books = data

  # $scope.books =
    # [
      # id: 1
      # cover_image: 'http://www.google.com'
      # title: 'Book Title 01'
      # sub_title: 'Book Sub Title'
      # formatted_price: '$49.95'
      # pages: 345
    # ,
      # id: 2
      # cover_image: 'http://www.google.com'
      # title: 'Book Title 02'
      # sub_title: 'Book Sub Title'
      # formatted_price: '$49.95'
      # pages: 345
    # ,
      # id: 3
      # cover_image: 'http://www.google.com'
      # title: 'Book Title 03'
      # sub_title: 'Book Sub Title'
      # formatted_price: '$49.95'
      # pages: 345
    # ,
      # id: 4
      # cover_image: 'http://www.google.com'
      # title: 'Book Title 04'
      # sub_title: 'Book Sub Title'
      # formatted_price: '$49.95'
      # pages: 345
    # ]
]
