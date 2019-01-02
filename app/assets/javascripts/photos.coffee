# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@photos = {}
doNothing = {}

class photos.events
  @product_changed = () ->
    product = $('#product').val()
    url = window.location.protocol + "//" + window.location.host + '/products/' + product + '/varieties.json'
    $.getJSON url, (data) ->
      $('#varieties').find('option').remove().end()
      $('#varieties').append($("<option></option>").text("- Select -"))
      $.each data, (i, obj) ->
        $('#varieties').append($('<option>').text(obj[0]).attr('value', obj[1]))

#@publication_changed = () ->
$('.js-switch').siblings(".fa-spinner").hide()
$('.js-switch').change (event) ->
  id = event.target.value
  if doNothing[id] == true
    doNothing[id] = false
    return
  $('.js-switch:input[value='+id+']').parent().css('background', '');
  url = window.location.protocol + "//" + window.location.host + '/photos/' + id
  $(this).siblings(".fa-spinner").show()
  $('#loading').show()
  $.ajax(
    method: 'PATCH'
    dataType: "json"
    url: url
    data:
      'photo':
        'published': event.target.checked
  ).done( (msg) ->
    $("#spinner_"+msg.id).hide()
    $(this).siblings(".fa-spinner").hide(200)
  ).error (msg) ->
    id = msg.responseJSON[0].id
    $("#spinner_"+id).hide()
    $(this).siblings(".fa-spinner").hide()
    doNothing[id] = true
    $('.js-switch:input[value='+id+']').trigger 'click'
    $('.js-switch:input[value='+id+']').parent().css('background', 'rgba(201, 48, 44, 0.49)');
    $('#error').show()
