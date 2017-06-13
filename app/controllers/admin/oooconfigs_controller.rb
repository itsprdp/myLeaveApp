# frozen_string_literal: true

class Admin::OooconfigsController < ApplicationController
  before_action :admin_user
  before_action :set_pto

  def update
    if @ooo_config.update_attributes(ooo_config_params)
      flash[:success] = 'configs are updated'
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  private

  def set_pto
    @ooo_config = OOOConfig.where('financial_year = ?',
                                  OOOConfig.financial_year).first
  end

  def ooo_config_params
    params.require(:ooo_config).permit(:leaves_count,
                                       wfhs_count: [:quarter1,
                                                    :quarter2,
                                                    :quarter3,
                                                    :quarter4])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end