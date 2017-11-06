class MsgThreadsController < ApplicationController
  before_action :set_msg_thread, only: [:show, :edit, :update, :destroy]

  # GET /msg_threads
  # GET /msg_threads.json
  def index
    @msg_threads = MsgThread.all
  end

  # GET /msg_threads/1
  # GET /msg_threads/1.json
  def show
  end

  # GET /msg_threads/new
  def new
    @msg_thread = MsgThread.new
  end

  # GET /msg_threads/1/edit
  def edit
  end

  # POST /msg_threads
  # POST /msg_threads.json
  def create
    @msg_thread = MsgThread.new(msg_thread_params)

    respond_to do |format|
      if @msg_thread.save
        format.html { redirect_to @msg_thread, notice: 'Msg thread was successfully created.' }
        format.json { render :show, status: :created, location: @msg_thread }
      else
        format.html { render :new }
        format.json { render json: @msg_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /msg_threads/1
  # PATCH/PUT /msg_threads/1.json
  def update
    respond_to do |format|
      if @msg_thread.update(msg_thread_params)
        format.html { redirect_to @msg_thread, notice: 'Msg thread was successfully updated.' }
        format.json { render :show, status: :ok, location: @msg_thread }
      else
        format.html { render :edit }
        format.json { render json: @msg_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /msg_threads/1
  # DELETE /msg_threads/1.json
  def destroy
    @msg_thread.destroy
    respond_to do |format|
      format.html { redirect_to msg_threads_url, notice: 'Msg thread was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_msg_thread
      @msg_thread = MsgThread.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def msg_thread_params
      params.require(:msg_thread).permit(:page_id, :uid, :sender_name, :sender_uid, :link, :msg_count, :unread_count, :updated_time, :other_info)
    end
end
