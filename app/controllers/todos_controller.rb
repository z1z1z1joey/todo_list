class TodosController < ApplicationController
  before_action :set_todo, :only => [:show, :edit, :update, :destroy]
  def index
    @todos = Todo.all
  end
  def new
    @todo = Todo.new
  end
  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to todos_url
    else
      render :action => :new
    end
  end
  def show
    set_todo
  end
  def edit
    set_todo
  end
  def update
    set_todo
    if @todo.update_attributes(todo_params)
      redirect_to todos_url
    else
      render :action => :edit
    end
  end
  def destroy
    set_todo
    if DateTime.current > @todo.date
      redirect_to todos_url ,:notice => "時間過期，無法刪除！"
    else
      @todo.destroy
      redirect_to todos_url
    end
  end
  private
  def todo_params
    params.require(:todo).permit(:title, :date, :note)
  end
  def set_todo
    @todo = Todo.find(params[:id])
  end
end
