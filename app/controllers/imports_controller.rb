class ImportsController < ApplicationController
  protect_from_forgery except: :create 

  def create
    doc = Nokogiri::XML(request.body.read)
    EmailParser.import!(doc)
    render status: 200, text: "OK"
  end
end