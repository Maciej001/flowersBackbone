# /models/todo.coffee
$ ->
	window.app = window.app || {}
	# Todo Model
	# has 'title' and 'completed' attributes

	class app.Todo extends Backbone.Model
		defaults: 
			title: 			'Maciej'
			completed: 	false

		# toggle the 'completed' state of todo item
		# and save itd
		toggle: ->
			@save	
				completed: !@get('completed')  

