# js/models/todo.coffee

app = app || {}

# Todo Model
# has 'title' and 'completed' attributes

app.Todo =  Backbone.Model.extend
	defaults: 
		title: 			''
		completed: 	false

	# toggle the 'completed' state of todo item
	toggle: ->
		@save	
			completed: !@get('completed')  