class Movie < ActiveRecord::Base
    def self.with_director(director)
        if director != nil
            return self.where(:director => director)
        else
            return director
        end
    end
end
