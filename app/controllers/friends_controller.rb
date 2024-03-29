class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]

  before_action :authenticate_user!, except: [ :index, :show ] 

  before_action :correct_user, only: [ :edit, :update, :destroy]

  #http_basic_authenticate_with name: "test", password: "secret", only: :destroy

  # GET /friends or /friends.json
  def index
    @friends = Friend.all
    #@friends = current_user.friends.all

  end

  # GET /friends/1 or /friends/1.json
  def show

  end

  # GET /friends/new
  def new
    #@friend = Friend.new
    @friend = current_user.friends.build
    # p current_user.friends.methods
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    #@friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), 
                      notice: "#{@friend.first_name} was successfully created." }

        format.json { render :show, status: :created, location: @friend }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end


  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|

      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "#{friend_params[:first_name]} was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }

      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def correct_user
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to friends_url, notice: "un-authorized to Edit this Friend !!" if @friend.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      begin
        @friend = Friend.find(params[:id])
         
      rescue => exception
        print "NOTICE: ", exception

        respond_to do |format|
          format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    end

    # Only allow a list of trusted parameters (form) through. != params (from url)
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, 
                                    :email, :phone, :user_id, :status, :check, :avatar)
    end
end
