# 
#  authors.rb
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
  class Authors
    include RestBooks::Api

    # Endpoint: /authors
    #  Formats: Atom
    #  Description: List all authors (20 items)
    #  Parameters:
    #     * letter: display the authors with ... as the first letter of their name
    #     * born: authors born in ...
    #     * death: author who dies in ...
    #     * lang: language of the author
    #     * order: normally from A to Z, use desc to reverse order
    def all(options={})
      create_url("/authors", options, ORDERED_AUTHOR_PARAMETERS)
      return do_request(:author)
    end

    # Endpoint: /authors/top
    #  Formats: Atom
    #  Description: List top authors (20 items)
    #  Parameters:
    #     * letter: display the authors with ... as the first letter of their name
    #     * born: authors born in ...
    #     * death: author who dies in ...
    #     * lang: language of the author
    #     * range: normally overall, week will display the most popular for the previous week and month for the last 4 weeks
    def top(options={})
      create_url("/authors/top", options, RANGED_AUTHOR_PARAMETERS)
      return do_request(:author)
    end

    # Endpoint: /authors/recent
    #  Formats: Atom
    #  Description: List recent authors (20 items)
    #  Parameters:
    #     * letter: display the authors with ... as the first letter of their name
    #     * born: authors born in ...
    #     * death: author who dies in ...
    #     * lang: language of the author
    def recent(options={})
      create_url("/authors/recent", options, AUTHOR_PARAMETERS)
      return do_request(:author)
    end

    # Endpoint: /author/:id/books
    #  Formats: Atom
    #  Description: List all books for an author (id)
    #  Parameters: Same as /books
    def books( author_id, options={} )
      author_id = author_id.id if author_id.kind_of? RestBooks::Models::Author
      create_url( "/author/#{author_id}/books", options, ORDERED_BOOK_PARAMETERS )
      return do_request( :book )
    end

    # Endpoint: /author/:id/books/top
    #  Formats: Atom
    #  Description: List top books for an author (id)
    #  Parameters: Same as /books/top
    def top_books( author_id, options={} )
      author_id = author_id.id if author_id.kind_of? RestBooks::Models::Author
      create_url( "/author/#{author_id}/books/top", options, RANGED_BOOK_PARAMETERS )
      return do_request( :book )
    end

    # Endpoint: /author/:id/books/recent
    #  Formats: Atom, RSS
    #  Description: List recent books for an author (id)
    #  Parameters: Same as /books/recent
    def recent_books( author_id, options={} )
      author_id = author_id.id if author_id.kind_of? RestBooks::Models::Author
      create_url( "/author/#{author_id}/books/recent", options, BOOK_PARAMETERS )
      return do_request( :book )
    end

  end
end