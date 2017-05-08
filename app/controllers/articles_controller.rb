class ArticlesController<ApplicationController
    
    before_action :set_article, only: [:edit, :update, :show, :destroy]         #always have b4 action in order
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :destroy, :update]
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @article = Article.new
    end
    
    def show
        @article = Article.find(params[:id])
        
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:success]="Update Succesful bro!"
            redirect_to article_path(@article)
        else
            render :edit
        end
    end
    
    def create
        
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            session[:user_id] = @user.id
            flash[:success]="Succesful bro!"
            redirect_to user_path(@user)
        else
            render :new
        end
    end
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        flash[:danger]="deletion Succesful bro!"
        redirect_to articles_path
    end
    
    private
    def set_article
        @article = Article.find(params[:id])
    end
    
    def article_params
        params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
        if current_user != @article.user
            flash[:danger] = "You can only edit or delete your own bakhodi."
            redirect_to root_path
        end
    end
    
end