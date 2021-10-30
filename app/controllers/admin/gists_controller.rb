class Admin::GistsController < Admin::BaseController
  def index
    Gist.find_each { |gist| gist.synchronize }
    @gists = Gist.all
  end
end
