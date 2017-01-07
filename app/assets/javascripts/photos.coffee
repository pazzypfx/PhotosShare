# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@photos = {}

class photos.events
  @product_changed = () ->
    product = '?product=' + $('#product').val()
    if product == '?product=none'
      product = ''
    window.location = window.location.pathname + product
    # todo: Use AJAX to do this because there are errors when creating new photos
