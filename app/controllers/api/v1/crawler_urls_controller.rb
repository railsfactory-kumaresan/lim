class API::V1::CrawlerUrlsController < ApplicationController
  include ResponseHandler

  def index
    json_response(CrawlerList.all.map(&:url).uniq)
  end

  def create
    response, status = CrawlerList.index_and_save(crawler_params)
    json_response(response, status == 200 ? :created : :unprocessable_entity)
  end

  private

  def crawler_params
    params.permit(:url)
  end
end
