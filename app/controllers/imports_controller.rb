class ImportsController < ApplicationController
  def create
    raise params
    f = params[:something-from-the-docs]
    doc = Nokogiri::XML(f)
    EmailParser.import!(doc)
  end
end