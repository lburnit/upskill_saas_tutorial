class PagesController < ApplicationController
    # get request for / which is homepage
    def home 
        @basic_plan = Plan.find(1)
        @pro_plan = Plan.find(2)
    end 

    def about
    end 
end 