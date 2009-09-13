# 
#  categories.rb
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
  class Categories
    include RestBooks::Api
    
    # Endpoint: /types
    #  Formats: Atom
    #  Description: View the categories, use pagination
    #  Parameters:
    #    * order: normally based on the number of favorites, use comments to order them by most discussed lists
    def all( options={} )
      create_url( "/types", options, LIST_PARAMETERS )
      return do_request( :category )
    end
    
    # Endpoint: /type/:id/books
    #  Formats: Atom
    #  Description: List all books from given category, use pagination
    def books( category_id, options={} )
      category_id = category_id.id if category_id.kind_of? RestBooks::Models::Category
      create_url( "/type/#{category_id}/books", options, ORDERED_BOOK_PARAMETERS )
      return do_request( :book )
    end
    
    # Endpoint: /type/:id/books/top
    #  Formats: Atom
    #  Description: List top books for a category (id)
    #  Parameters: Same as /books/top
    def top_books( category_id, options={} )
      category_id = category_id.id if category_id.kind_of? RestBooks::Models::Category
      create_url( "/type/#{category_id}/books/top", options, RANGED_BOOK_PARAMETERS )
      return do_request( :book )
    end

    # Endpoint: /type/:id/books/recent
    #  Formats: Atom, RSS
    #  Description: List recent books for a category (id)
    #  Parameters: Same as /books/recent
    def recent_books( category_id, options={} )
      category_id = category_id.id if category_id.kind_of? RestBooks::Models::Category
      fcreate_url( "/type/#{category_id}/books/recent", options, BOOK_PARAMETERS )
      return do_request( :book )
    end

  end
end