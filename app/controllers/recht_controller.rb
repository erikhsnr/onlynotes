class RechtController < ApplicationController
  def index
    redirect_to "https://www.gesetze-im-internet.de/kunsturhg/__22.html", allow_other_host: true
  end
end
