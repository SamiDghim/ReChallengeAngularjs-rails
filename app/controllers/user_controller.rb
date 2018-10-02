class UserController < ApplicationController
    def show
        user=User.find(params[:id])
        render json: user
    end

    # get '/GetAllUsers'
    def GetAllUsers
        p = params[:p]
        users = User.paginate(page: p, per_page:2).order('updated_at DESC')
        render json: {status: 'SUCCESS',message: 'Loaded users for admin',data: users,total:(users.total_pages)},status: :ok
    end
end
