# collections/todos.coffee

window.app = window.app || {}
# Todo Collection
#
# the collection of todos is saved in localStorage only 

class app.TodoList extends Backbone.Collection

	# reference to this collection's model
	model: window.app.Todo

	# save all todo items under the "todos-backbone" namespace
	localStorage: new Backbone.LocalStorage 'todos-backbone'

	# filter items that are finished
	completed: ->
		@filter (todo)->
			todo.get 'completed'

	# filter items that are still not finished
	remaining: ->
		@without.apply @, @completed()

	# generates next order number for new todo task
	nextOrder: ->
		return 1 if !@length
		return @last().get('order') + 1

	comparator: (todo) ->
		todo.get('order')



