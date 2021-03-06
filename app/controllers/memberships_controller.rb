class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin, only: [:destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all
  end

  # GET /memberships/1/edit
  def edit
  end

  def toggle_confirmed

    # Varmistetaan, että nykyinen käyttäjä kuuluu ko. kerhoon
    membership=  Membership.find(params[:id])
    if !Membership.find_by(beer_club_id: membership.beer_club_id, user_id: current_user.id, confirmed: true).nil?
      membership.confirmed = true
      membership.save
      redirect_to :back, notice:"User #{membership.user.username} confirmed"
      return
    end

    redirect_to :back, notice:"Only confirmed members can confirm other users"

  end


  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)

    respond_to do |format|
      if !current_user.nil? && @membership.save
        current_user.memberships << @membership


        format.html { redirect_to @membership.beer_club, notice: current_user.username + ',welcome to the club!' }
        format.json { render action: 'show', status: :created, location: @membership }
      else
        @beer_clubs = BeerClub.all
        format.html { render action: 'new' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:beer_club_id, :user_id)
    end
end
