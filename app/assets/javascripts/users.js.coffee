# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#user_crop_x').val(coords.x)
    $('#user_crop_y').val(coords.y)
    $('#user_crop_w').val(coords.w)
    $('#user_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
  	$('#preview').css
  		width: Math.round(100/coords.w * $('#cropbox').width()) + 'px'
  		height: Math.round(100/coords.h * $('#cropbox').height()) + 'px'
  		marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
  		marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'

ready = ->
  engine = new Bloodhound(
    datumTokenizer: (d) ->
      console.log d
      Bloodhound.tokenizers.whitespace d.title
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: '../users/autocomplete?query=%QUERY'
      wildcard: '%QUERY')
  promise = engine.initialize()
  promise.done(->
    console.log 'success!'
    return
  ).fail ->
    console.log 'err!'
    return
  $('.typeahead').typeahead null,
    name: 'engine'
    displayKey: 'name'
    source: engine.ttAdapter()
  return

$(document).ready ready
$(document).on 'page:load', ready