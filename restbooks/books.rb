# 
#  books.rb
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
  class Books
    include RestBooks::Api
    
    # Endpoint: /books
    #  Formats: Atom
    #  Description: List all books (20 items)
    #  Parameters:
    #     * letter: display the books with ... as the first letter of their name
    #     * year: book released in ...
    #     * lang: language of the book
    #     * order: normally from A to Z, use desc to reverse order or year to sort them by release date
    def all( options={} )
      create_url( "/books", options, ORDERED_BOOK_PARAMETERS )
      return do_request( :book )
    end

    # Endpoint: /books/top
    #  Formats: Atom
    #  Description: List top books (20 items)
    #  Parameters:
    #     * letter: display the books with ... as the first letter of their name
    #     * year: book released in ...
    #     * lang: language of the book
    #     * range: normally overall, week will display the most popular for the previous week and month for the last 4 weeks
    def top( options={} )
      create_url( "/books/top", options, RANGED_BOOK_PARAMETERS )
      return do_request( :book )
    end

    # Endpoint: /books/recent
    #  Formats: Atom, RSS
    #  Description: List recent books (20 items)
    #  Parameters:
    #     * letter: display the books with ... as the first letter of their name
    #     * year: book released in ...
    #     * lang: language of the book
    def recent( options={} )
      create_url( "/books/recent", options, BOOK_PARAMETERS )
      return do_request( :book )
    end

    # Endpoint: /books/search
    #  Formats: Atom
    #  Description: Search for a book
    #  Parameters:
    #     * query: you can use advanced queries too (for example "type:Horror AND Lovecraft")
    def search( query, options={} )
      options[:query] = query
      create_url( "/books/search", options, [:query] )
      return do_request( :book )
    end

    # Endpoint: /book/:id/similar
    #  Formats: Atom
    #  Description: List similar books for a given book
    #  Parameters: none
    def similar( book_id, options={} )
      book_id = book_id.id if book_id.kind_of? RestBooks::Models::Book
      create_url( "/book/#{book_id}/similar", options, [:page] )
      return do_request( :book )
    end

    # Endpoint: /book/:id/lists
    #  Formats: Atom
    #  Description: View in which list a book is included
    #  Parameters:
    #     * order: normally the order is based on the number of favorites, use asc or desc to switch this to alphabetical order
    def lists
      book_id = book_id.id if book_id.kind_of? RestBooks::Models::Book
      create_url( "/book/#{book_id}/lists", options, LIST_PARAMETERS )
      return do_request( :list )
    end
    
    # Endpoint: /book/:id/comments
    #  Formats: Atom
    def comments( book_id, options={} )
      book_id = book_id.id if book_id.kind_of? RestBooks::Models::Book
      create_url( "/book/#{book_id}/comments", options, [:page] )
      return do_request( :comment )
    end

    # Endpoint: /book/:id/comments
    #  Formats: Atom, EPub, Mobipocket, PDF, png
    #  Description: Get the book, information or cover
    #  Parameters:
    #     * size: for png cover you can use smaller
    def get( book_id, options={} )
      book_id = book_id.id if book_id.kind_of? RestBooks::Models::Book
      options.delete(:size) if options[:format] != :png
      create_url( "/book/#{book_id}", options, [:size] )
      if @uri.format.to_sym == :atom
        return do_request( :book )
      elsif [ :epub, :mobi, :pdf, :atom, :png ].include?( @uri.format.to_sym )
        responce = RestClient::Request.execute(:method => :get, :url => @uri.to_s, :headers => {}, :raw_response => true)
        return { :content_type => responce.headers[:content_type], :path => responce.file.path }
      end
    end

  end
end