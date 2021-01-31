# encoding: UTF-8
class Admin::CategoriesController < AdminController
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      Board.amr_notification("La catégorie #{@category.title} du suivi #{admin_categories_url} a été créée par #{current_user.name} #{user_url(current_user)}")
      redirect_to admin_categories_url, notice: 'Nouvelle catégorie créée.'
    else
      flash.now[:alert] = "Impossible d’enregistrer cette catégorie"
      render :new
    end
  end

  def edit
  end

  def update
    @category.attributes = params[:category]
    if @category.save
      Board.amr_notification("La catégorie #{@category.title} du suivi #{admin_categories_url} a été modifiée par #{current_user.name} #{user_url(current_user)}")
      redirect_to admin_categories_url, notice: 'Catégorie mise à jour.'
    else
      flash.now[:alert] = "Impossible d’enregistrer cette catégorie"
      render :edit
    end
  end

  def destroy
    Board.amr_notification("La catégorie #{@category.title} du suivi #{admin_categories_url} a été supprimée par #{current_user.name} #{user_url(current_user)}")
    @category.delete
    redirect_to admin_categories_url, notice: 'Catégorie supprimée'
  end

protected

  def load_category
    @category = Category.find(params[:id])
  end

end
