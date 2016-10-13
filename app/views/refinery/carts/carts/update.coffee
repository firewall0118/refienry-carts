alert 'The book was added to your cart!'
# Update the # of items
$("#cart-size").text( <%= @cart.line_items.size %> )
flash = "<div class='flash'></div>"
$("#cart-link").prepend(flash)
$('.flash').show().fadeOut('slow')
