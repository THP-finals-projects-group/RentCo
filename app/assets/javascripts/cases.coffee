# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 
  $('form').on 'click', '.remove_rooms', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('div').hide()
    event.preventDefault()

  $('form').on 'click', '.add_rooms', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  
  $('form').on 'click', '.add_users', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()