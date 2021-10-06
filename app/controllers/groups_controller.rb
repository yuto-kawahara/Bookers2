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
    group.save
    group_users = GroupUser.new(group_id: group.id, user_id: current_user.id)
    group_users.save
    # binding.pry
    redirect_to groups_path
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
    @group_user = GroupUser.where(:group_id => @group.id)
    # binding.pry

    @new_book = current_user.books.new
  end
  def edit
    @group = Group.find(params[:id])
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.group_users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    group_users.each do |gu|
      AdminMailer.send_mail(@mail_title, @mail_content, gu.user).deliver
    end

  end


  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image, :owner_id)
  end
end
