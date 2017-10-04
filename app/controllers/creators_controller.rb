class CreatorsController < ApplicationController
	before_action :find_creator, only: [:edit, :update, :show, :destroy]

	def index
		@creators = Creator.all
	end

	def new
		@creator = Creator.new
	end

	def create
		@creator.save
		redirect_to creators_path
	end

	def edit
	end

	def update
		if @creator.update(creator_params)
			flash[:success] = "Creator was successfully updated"
			redirect_to creator_path(@creator)
		else
			render 'edit'
		end
	end

	private
		def find_creator
			@creator = Creator.find(params[:id])
		end

		def creator_params
			params.require(:creator).permit(:name, :blurb, :email, :password, :creator_img)
		end
end
