class Api::V1::BaseController < ApplicationController
  before_action :check_xhr_header, only: %i[create update destroy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  include Pagy::Backend
  include ErrorHandle
end
