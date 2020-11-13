class PagesController < ApplicationController
    def index
          @post=Post.all
    end
end
