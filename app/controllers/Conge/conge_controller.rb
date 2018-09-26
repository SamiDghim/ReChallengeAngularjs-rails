module Conge
    class CongeController < ApplicationController

        def create
            conge=CongeDemande.new(conge_params);
            if conge.save
             render json: {status: 'SUCCESS',message: 'Saved demand',data: conge},status: :ok
            else
                render json: {status: 'ERROR',message: 'Demand not saved ',data: conge.errors},status: :unprocessable_entity
            end
        end
        def getUserConges
            conge=CongeDemande.where(user_id: params[:id]).order(created_at: :desc)
            render json: {status: 'SUCCESS',message: 'Loaded Congés demande',data: conge,total:(conge.count+1)/2},status: :ok
        end
        def getUserCongeModel
            conge=CongeDemande.where(id: params[:id])
            render json: {status: 'SUCCESS',message: 'Loaded Congé demande for model',data: conge},status: :ok
        end
        private
        def conge_params
            params.permit(:user_id , :date_debut, :date_fin, :motifAb)
        end
        
    end
end