# todos/todos.coffee

window.app = window.app || {}

# Todo Item View
class app.TodoView extends Backbone.View
# DOM  element for a todo item
tagName: 'li'

template: _.template $('#item-template').html()

# events specific to an item
events:
	'dblclick label': 'edit'
	'keypress .edit':	'updateOnEnter'
	'blur .edit':			'close'

# the TodoView listens for changes to its model, re-rendering.
# Since there's a one-to-one correspondence between a **Todo** and
# **TodoView** in this app, we set a direct reference on the model 
# for convenience
initialize: ->
	@listenTo(@model, 'change', @render)

# re-renders the titles of the too item
render: ->
	@$el.html @template(@model.attributes)
	@$input = @$('.edit')
	@

# switch this view into 'editing' mode, displaying the input field
edit: ->
	@$el.addClass '.editing'
	@$input.focus

# close 'editing' mode
close: ->
	value = @$input.val().trim

	@model.save title: value if value

	@$el.removeClass 'editing'

updateOnEnter: (e) ->
	@close if e.which is ENTER_KEY 