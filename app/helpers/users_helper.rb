module UsersHelper

	def make_admin
    @user = User.find(params[:id])
    if @user.admin == false
      @user.toggle!(:admin) 
      redirect_to user_path, :flash => { :success => "#{@user.login} became admin" }
    else
      redirect_to user_path, :flash => { :error => "#{@user.login} is already admin" }
    end
  end

  def remove_admin
    @user = User.find(params[:id])
    if @user.admin == true
      @user.toggle!(:admin)
      redirect_to user_path, :flash => { :success => "Admin destroyed" }
    else
      redirect_to user_path, :flash => { :error => "#{@user.login} is not admin already" }
    end
  end

  def make_moder
    @user = User.find(params[:id])
    if @user.moder == false
      @user.toggle!(:moder) 
      redirect_to user_path, :flash => { :success => "#{@user.login} became moder" }
    else
      redirect_to user_path, :flash => { :error => "#{@user.login} is already moder" }
    end
  end

  def remove_moder
    @user = User.find(params[:id])
    if @user.moder == true
      @user.toggle!(:moder)
      redirect_to user_path, :flash => { :success => "moder destroyed" }
    else
      redirect_to user_path, :flash => { :error => "#{@user.login} is not moder already" }
    end
  end

end
