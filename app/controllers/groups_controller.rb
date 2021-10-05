class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  def index
    @new_book = current_user.books.new
    @groups = Group.all
  end
  def create
    group = Group.new(group_params)

    # binding.pry
    if group.save
      redirect_to groups_path
    end
  end
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end
  def destroy
  end
  def show
    @group = Group.find(params[:id])

  end
  def edit
    @group = Group.find(params[:id])
  end
  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image, :owner_id)
  end
end
