$(document).ready(function() {
  $('a.list-change').click(function(event) {
    event.preventDefault();

    var request = $.ajax({
			method: 'POST',
			url: $(this).attr('href'),
      data: { id: $(this).attr('id') }
		});

    request.done(function(data) {
      var list_ul = $('ul#shopping_list')
      var items = data.new_list

      list_ul.empty()
      if (items.length === 0) {
        $('ul#shopping_list').append("<li>Empty list!</li>")
      } else {
        for (var i = 0; i < items.length; i++) {
            $('ul#shopping_list').append("<li>" + items[i] + "</li>")
        }
      }

    });
  });
});
// if ('new_score' in data) {
//   $('li#review-rating-' + data.review_id).text('Review rating: ' + data.new_score);
// } else {
//   if ($('div.flash_message').text !== data.login_error) {
//      $('div.flash_message').text(data.login_error)
//   }
// }
