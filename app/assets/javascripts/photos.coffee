# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@photos = {}

class photos.events
  @product_changed = () ->
    product = $('#product').val()
    url = window.location.protocol + "//" + window.location.host + '/varieties/' + product
    $.getJSON url, (data) ->
      $('#varieties').find('option').remove().end()
      $('#varieties').append($("<option></option>").text("- Select -"))
      $.each data, (i, obj) ->
        $('#varieties').append($('<option>').text(obj.name).attr('value', obj.id))
