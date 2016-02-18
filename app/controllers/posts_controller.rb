class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /Posts
  # GET /Posts.json
  def index
    # redirect_to root_path
    @posts = Post.all.reverse
  end

  def public_index
    # redirect_to root_path
    @posts = Post.all.reverse
  end

  def test
    @posts = Post.paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /Posts/1
  # GET /Posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  def music
    @posts = Post.where(vibe_type: 'soundcloud')
  end


  # GET /Posts/new
  def new
    @post = Post.new
  end

  # GET /Posts/1/edit
  def edit
  end


  # POST /Posts
  # POST /Posts.json
  def create
    @post = Post.new(post_params)

    if @post.vibe_type == "soundcloud"
        start= 'content="soundcloud://sounds:'
        i = open(@post.url).read.index(start)
        # @post.uid = open(@post.url).read[i+29..i+37]
        @post.url = open(@post.url).read[i+29..i+37]
    elsif @post.vibe_type == "image"
      @post.url = @post.url
      # puts "no"
    elsif @post.vibe_type == "youtube"
      start = 'watch'
      i = @post.url.index(start)
      pp = @post.url[i, i+1]
      # @post.uid = pp[8,100]
      @post.url = pp[8,100]
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /Posts/1
  # PATCH/PUT /Posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Posts/1
  # DELETE /Posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: 'Post Deleted'
  end

  def approve
    # TODO select Posts that are approved
    # Post.update_all(['approved=?', true], :id => params[:Post_ids])
    @post=Post.find(params[:id])
    @post.approvePost
    # @Post.approved=true
    # redirect_to Posts_path
  end

  def setApprove
    @post=Post.find(params[:id])
    @post.approvePost
    @post.save
    redirect_to posts_path
  end

  def setDisapprove
    @post=Post.find(params[:id])
    @post.disapprovePost
    @post.save
    redirect_to posts_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :picture, :approved, :vibe_type, :body, :url, :uid)

    end
end
