class ApplicationController < ActionController::Base
  protect_from_forgery
  include MoviesHelper
end
