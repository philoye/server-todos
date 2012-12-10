$ ->
  window.Todo = Backbone.Model.extend
    defaults: ->
      done:  false
      order: Todos.nextOrder()

    toggle: ->
      @save done: not @get("done")

  window.TodoList = Backbone.Collection.extend(
    model: Todo
    url: "/api/todos"
    done: ->
      @filter (todo) ->
        todo.get "done"

    remaining: ->
      @without.apply this, @done()

    nextOrder: ->
      return 1  unless @length
      @last().get("order") + 1

    comparator: (todo) ->
      todo.get "order"
  )
  window.Todos = new TodoList
  window.TodoView = Backbone.View.extend
    events:
      "click .check": "toggleDone"
      "dblclick div.todo-text": "edit"
      "click span.todo-destroy": "clear"
      "keypress .todo-input": "updateOnEnter"
      "blur .todo-input": 'close'

    initialize: ->
      @model.bind "change", @render, this
      @model.bind "destroy", @remove, this

    render: ->
      _.extend @model,
        done_checked: if @model.get('done') then 'checked' else ''
        done_class:   if @model.get('done') then 'done' else ''
      $(@el).html ich.item(@model)
      this


    toggleDone: ->
      @model.toggle()

    edit: ->
      $(@el).addClass "editing"
      @$('.todo-input').focus()

    close: ->
      $(@el).removeClass "editing"
      @model.save text: @$('.todo-input').val()

    updateOnEnter: (e) ->
      @close()  if e.keyCode is 13

    remove: ->
      $(@el).remove()

    clear: ->
      @model.destroy()

  window.AppView = Backbone.View.extend(
    el: $("#todoapp")
    events:
      "keypress #new-todo":  "createOnEnter"
      "keyup #new-todo":     "showTooltip"
      "click .todo-clear a": "clearCompleted"

    initialize: ->
      @input = @$("#new-todo")
      Todos.bind "add", @addOne, this
      Todos.bind "reset", @addAll, this
      Todos.bind "all", @render, this
      $('#todo-list').empty()
      #Todos.fetch() # we are bootstrapping the collection in the HTML

    render: ->
      $('#todo-stats').html ich.stats
        hasRemainingItems:   Todos.remaining().length > 0
        numRemainingItems:   Todos.remaining().length
        labelItemsRemaining: if Todos.remaining().length is 1 then 'item' else 'items'
        hasDoneItems:        Todos.done().length > 0
        numDoneItems:        Todos.done().length
        labelDoneItems:      if Todos.done().length is 1 then 'item' else 'items'

    addOne: (todo) ->
      view = new TodoView(model: todo)
      @$("#todo-list").append view.render().el

    addAll: ->
      Todos.each @addOne

    createOnEnter: (e) ->
      text = @input.val()
      return  if not text or e.keyCode isnt 13
      Todos.create text: text
      @input.val ""

    clearCompleted: ->
      _.each Todos.done(), (todo) ->
        todo.destroy()

      false

    showTooltip: (e) ->
      tooltip = @$(".ui-tooltip-top")
      val = @input.val()
      tooltip.fadeOut()
      clearTimeout @tooltipTimeout  if @tooltipTimeout
      return  if val is "" or val is @input.attr("placeholder")
      show = ->
        tooltip.show().fadeIn()

      @tooltipTimeout = _.delay(show, 1000)
  )
  window.App = new AppView
