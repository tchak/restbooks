# 
#  lists.rb
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
  class Lists
    include RestBooks::Api
    
    # Endpoint: /lists
    #  Formats: Atom
    #  Description: View the lists, use pagination
    #  Parameters:
    #    * favorites: normally, only the lists with at least 2 favorites are displayed. You can change the minimum value using this parameter.
    #    * order: normally based on the number of favorites, use comments to order them by most discussed lists
    def all( options={} )
      create_url( "/lists", options, LIST_PARAMETERS )
      return do_request( :list )
    end
    
    # Endpoint: /list/:id
    #  Formats: Atom
    #  Description: View the books on the lists, use pagination
    def books( list_id, options={} )
      list_id = list_id.id if list_id.kind_of? RestBooks::Models::List
      create_url( "/list/#{list_id}", options, LIST_PARAMETERS )
      return do_request( :book )
    end

  end
end