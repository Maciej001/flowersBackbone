# views/app.coffee
$ ->
	window.app = window.app || {}

	# The Application

	class app.AppView extends Backbone.View

		# bind to existing element
		el: '#todoapp'

		# statistics template at the bottom
		statsTemplate: _.template( $('#stats-template').html() )

		events: 
			'keypress #new-todo': 			'createOnEnter'
			'click #clear-completed':		'clearCompleted'
			'click #toggle-all':				'toggleAllComplete'

		initialize: ->
			#first element
			@allCheckbox = 	@.$('#toggle-all')[0]
			@$input = 			@.$('#new-todo')
			@$footer = 			@.$('#footer')
			@$main = 				@.$('#main')

			@.listenTo app.Todos, 'add', @addOne
			@.listenTo app.Todos, 'reset', @addAll

			@.listenTo app.Todos, 'change:completed', @filterOne
			@.listenTo app.Todos, 'filter', @filterAll
			@.listenTo app.Todos, 'all', @render

			app.Todos.fetch();

		# re-rendering means refreshing the statistics
		# the rest of app doesn't change
		render: ->
			completed = app.Todos.completed().length
			remaining = app.Todos.remaining().length

			if app.Todos.length
				@$main.show()
				@$footer.show()

				@$footer.html @statsTemplate
					completed: completed  # number of completed tasks
					remaining: remaining  # number of remianing tasks

				@.$('#filters li a')
					.removeClass('selected')
					.filter '[href="#/' + (app.TodoFilter || '') + '"]'
					.addClass('selected')
			else
				@$main.hide()
				@$footer.hide()

			@allCheckbox.checked = !remaining

		# add todo item by creating a view for it, and
		# append its element to the 'ul'
		addOne: (todo) ->
			view = new app.TodoView
				model: todo
			$('#todo-list').append view.render().el

		# add all items in the **Todos** collection at once
		addAll: ->
			@.$('#todo-list').html('')
			app.Todos.each( @addOne, @)

		filterOne: (todo) ->
			todo.trigger('visible')

		filterAll: ->
			app.Todos.each(@filterOne, @)

		# generate the attributes for a new Todo item
		newAttributes: ->
			title: @$input.val().trim()
			order: app.Todos.nextOrder()
			completed: false

		# if you hit Enter in main input field, create new Todo model,
		# persisting it to localStorage
		createOnEnter: (e) ->
			return if e.which isnt ENTER_KEY or not @$input.val().trim()

			# create creates a new instance of a model within a collection
			app.Todos.create @newAttributes()

			# clear/reset input field
			@$input.val ''

		clearCompleted: ->
			_.invoke app.Todos.completed(), 'destroy'
			false

		toggleAllComplete: ->
			completed = @allCheckbox.checked

			app.Todos.each (todo) ->
				todo.save
					'completed': completed




























			