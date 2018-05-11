# frozen_string_literal: true

class ApplicationController < ActionController::Base
  
  include Pundit
  
  protected  
    def after_sign_in_path_for(resource)
      sign_in_url = new_user_session_url
      if request.referer == sign_in_url
        super
      else
        institution_path(resource.institution) || request.referer || root_path
      end
    end
end
