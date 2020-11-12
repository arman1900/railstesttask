class PagesController < ApplicationController
    def index
          @post=Post.all
    end
    def about
    end
    
    def contact
    end
end
