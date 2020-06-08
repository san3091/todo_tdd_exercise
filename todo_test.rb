gem 'minitest'
require 'minitest/autorun'
require_relative './lib/todo'
require_relative './lib/todo_list'

class TodoTest < Minitest::Test
  def test_description
    expected = "Feed the dog"
    assert_equal expected, ::Todo.new("Feed the dog").description
  end

  def test_incomplete_todo
    assert_equal false, ::Todo.new("Feed the dog").complete?
  end

  def test_complete_todo
    complete_todo = ::Todo.new("Feed the dog")
    complete_todo.complete
    assert_equal true, complete_todo.complete?
  end

  def test_complete_description
    complete_todo = ::Todo.new("Feed the dog")
    complete_todo.complete
    assert_equal "Feed the dog (complete)", complete_todo.description
  end

  def test_empty_todo_list
    expected = "Nothing to do"
    assert_equal expected, ::TodoList.new.list_all
  end

  def test_add_todo
    todo_list = ::TodoList.new
    todo = ::Todo.new("Feed the dog")
    todo_list.add(todo)
    expected = "Feed the dog"
    assert_equal expected, todo_list.list_all
  end

  def test_list_multiple_todos
    todo_list = ::TodoList.new
    [::Todo.new("Feed the dog"), ::Todo.new("Eat")].each { |todo| todo_list.add(todo) }
    expected = "Feed the dog\nEat"
    assert_equal expected, todo_list.list_all
  end

  def test_list_incomplete
    todo_list = ::TodoList.new
    complete_todo = ::Todo.new("Eat")
    complete_todo.complete
    [::Todo.new("Feed the dog"), complete_todo].each { |todo| todo_list.add(todo) }
    expected = "Feed the dog"
    assert_equal expected, todo_list.list_incomplete
  end

  def test_list_complete
    todo_list = ::TodoList.new
    complete_todo = ::Todo.new("Eat")
    complete_todo.complete
    [::Todo.new("Feed the dog"), complete_todo].each { |todo| todo_list.add(todo) }
    expected = "Eat (complete)"
    assert_equal expected, todo_list.list_complete
  end

  def test_complete_from_list
    todo_list = ::TodoList.new
    [::Todo.new("Feed the dog"), ::Todo.new("Eat").complete].each { |todo| todo_list.add(todo) }
  end

end
