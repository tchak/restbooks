# 
#  model.rb
#  restbooks
#  
#  Created by Paul Chavard on 2009-09-12.
#  Copyright 2009
#
#  This file is part of RestBooks.
#
#  RestBooks is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  RestBooks is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with RestBooks.  If not, see <http://www.gnu.org/licenses/>.
#

module RestBooks
  module Model

    # def title=( str )
    #   @title = str
    #   @element.elements['title'].text = str
    # end

    def to_s
      return @element.to_s
    end
    
    def to_entry
      return @element
    end

    # def to_json
    #   model = self.class.to_s.split('::').last.downcase.to_sym
    #   return JSON.generate( { model => self.to_hash } )
    # end

  end
end