class PostsController < ApplicationController
  before_action :set_Post, only: [:show, :edit, :update, :destroy]

  # GET /Posts
  # GET /Posts.json
  def index
    # redirect_to root_path
    @posts = Post.all.reverse
  end

  # GET /Posts/1
  # GET /Posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /Posts/new
  def new
    @post = Post.new
  end

  # GET /Posts/1/edit
  def edit
  end


  # This was my first ever rails application, and I modified the "Posts" model to encompass all types of media. 
  # Rather than having 3 separate models for Posts, Songs, or Videos, I have one Posts model where you can choose 
  # the "Type" of media it is. 

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

  def approveThePost 
    @post=Post.find(params[:id])
    @post.approvePostTrue
    @post.save
    redirect_to Posts_path   
  end

  def get_last_approve
    @post=Post.last 
    redirect_to post_approve_path(@post)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :image, :approved, :vibe_type, :body, :url, :uid)

    end
end