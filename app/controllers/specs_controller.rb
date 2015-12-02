class SpecsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_app, only: [:index, :show, :edit, :update, :destroy, :new, :create]
  before_action :set_spec, only: [:show, :edit, :update, :destroy]

  protect_from_forgery :except => [:show, :update] 

  # GET /specs/1
  # GET /specs/1.json
  def show
    respond_to do |format|
      format.yaml { render text: @spec.body }
    end
  end

  # GET /specs/new
  def new
    @spec = Spec.new
  end

  # GET /specs/1/edit
  def edit
  end

  # POST /specs
  # POST /specs.json
  def create
    @spec = Spec.new(spec_params.merge({app_id: params[:app_id]}))

    respond_to do |format|
      if @spec.save
        format.html { redirect_to app_path(@app), notice: 'Spec was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /specs/1
  # PATCH/PUT /specs/1.json
  def update
    if request.format == 'yaml'
      @spec.update_attribute(:body, body = request.body.read) 
    else
      @spec.update_attributes(spec_params)
    end
    respond_to do |format|
      format.html { redirect_to app_path(@app), notice: 'Spec was successfully updated.'}
      format.yaml { render text: @spec.body }
    end
  end

  # DELETE /specs/1
  # DELETE /specs/1.json
  def destroy
    @spec.destroy
    respond_to do |format|
      format.html { redirect_to app_path(@app) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spec
      @spec = Spec.find(params[:id])
    end

    def set_app
      @app = App.find(params[:app_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spec_params
      params.require(:spec).permit(:version, :description)
    end
  end
