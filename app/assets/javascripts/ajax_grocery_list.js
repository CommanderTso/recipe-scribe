$(document).ready(function() {
  $('a.list-change').click(function(event) {
    event.preventDefault();
    var action = event.target.id.split("-")[1]
    var recipe_id = event.target.id.split("-")[2]
    var current_increment = parseInt($('span#list-buying-total-' + recipe_id).text(), 10);
    var new_value = 0;
    
    if (current_increment === 0 && action === "remove") {
      return;
    }

    if (action === "add") {
      new_value = current_increment + 1;
    } else if (current_increment > 0) {
      new_value = current_increment - 1;
    } else {
      new_value = 0
    }

    $('span#list-buying-total-' + recipe_id).text(new_value);

    var request = $.ajax({
			method: 'POST',
			url: $(this).attr('href'),
      data: { id: $(this).attr('id') }
		});

    request.done(function(data) {
      var list_ul = $('ul#shopping_list');
      var items = data.new_list;

      list_ul.empty()
      if (items.length === 0) {
        $('ul#shopping_list').append("<li>Empty list!</li>");
      } else {
        for (var i = 0; i < items.length; i++) {
            $('ul#shopping_list').append("<li>" + items[i] + "</li>");
        }
      }

    });
  });
});
