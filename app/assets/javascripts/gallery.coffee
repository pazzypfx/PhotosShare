# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.selectors').on 'change', ->
    if !location.origin
      location.origin = location.protocol + "//" + location.host

    product = '/' + $('#product').val()
    if product == '/none'
      product = ''

    variety = '/' + $('#variety').val()
    if variety == '/none' || product == ''
      variety = ''

    place = '/' + $('#place').val()
    if place == '/none'
      place = ''

    window.location = location.origin + "/gallery/index" + product + variety + place
