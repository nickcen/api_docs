class WorkersController < ApplicationController
  load_and_authorize_resource
  # inherit_resources
  before_action :set_worker, only: [:show, :edit, :update, :destroy]

  # GET /workers
  # GET /workers.json
  def index
    @workers = Worker.all.order(id: :desc).paginate :page => params[:page], :per_page => 20
  end

  def root_welcome_page
  end

  def login_routing_page
    if current_user.admin?
      redirect_to workers_path
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def new_user
  end

  # PATCH/PUT /workers/1
  # PATCH/PUT /workers/1.json
  def update
    respond_to do |format|
      if @worker.update(worker_params)
        format.html { redirect_to workers_path, notice: 'Worker was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workers/1
  # DELETE /workers/1.json
  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_url }
      format.json { head :no_content }
    end
  end

  private
  # # Use callbacks to share common setup or constraints between actions.
  def set_worker
    @worker = Worker.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def worker_params
    params.require(:worker).permit(:is_admin, :is_developer, :is_tester)
  end
end
