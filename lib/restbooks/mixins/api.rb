# 
#  api.rb
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
  module Api
    
    BOOK_PARAMETERS = [ :letter, :year, :lang, :page ]
    AUTHOR_PARAMETERS = [ :letter, :born, :death, :lang, :page ]
    LIST_PARAMETERS = [ :order, :page ]
    ORDERED_BOOK_PARAMETERS = BOOK_PARAMETERS + [ :order ]
    RANGED_BOOK_PARAMETERS = BOOK_PARAMETERS + [ :range ]
    ORDERED_AUTHOR_PARAMETERS = AUTHOR_PARAMETERS + [ :order ]
    RANGED_AUTHOR_PARAMETERS = AUTHOR_PARAMETERS + [ :range ]

  private
    
    def initialize( client )
      @user_agent = client.user_agent
      @uri = client.uri
      @etags = []
    end
    
    def create_url( path, options, valid_keys )
      format = :atom
      options_str = []
      options.each do |key,value|
        if key == :format
          format = options.delete( :format )
        elsif !valid_keys.include?(key)
          options.delete( key )
        else
          options_str << "#{key.to_s}=#{value}"
        end
      end
      options = ( options_str.length > 0 ? options_str.join('&') : nil )
      @uri.path = "#{path}.#{format.to_s}"
      @uri.query = options
    end
    
    def do_request( type, format = :atom )
      etag, saved_data = get_etag( @uri.to_s )
      if etag
        begin
          data = RestClient.get( @uri.to_s, { 'If-None-Match' => etag, 'User-Agent' => @user_agent } )
          etag = data.headers[:etag]
          save_etag( @uri.to_s, etag, data )
        rescue RestClient::NotModified
          data = saved_data
        end
      else
        data = RestClient.get( @uri.to_s, { 'User-Agent' => @user_agent } )
        etag = data.headers[:etag]
        save_etag( @uri.to_s, etag, data )
      end
      case format
      when :atom
        return process_atom_responce( type, data )
      # when :json
      #   #return JSON.parse( data )
      else
        return data
      end
    end
    
    def process_atom_responce( type, responce )
      result = []
      doc = REXML::Document.new( responce )
      REXML::XPath.each( doc, '//entry' ) do |element|
        result << eval( "Models::#{type.to_s.capitalize}.new( element )" )
      end
      return result
    end
    
    def get_etag( path )
      arr = @etags.assoc( path )
      etag = data = nil
      if arr
        etag = arr[1]
        data = arr[2]
        if arr != @etags.first
          @etags.delete(arr)
          @etags.unshift( arr )
        end
      end
      return etag, data
    end
    
    def save_etag( path, etag, data )
      @etags.unshift( [path,etag,data] )
      @etags.pop if @etags.length > 99
    end
    
    def update_etag( path, etag, data )
      arr = @etags.assoc( path )
      if arr
        if arr == @etags.first
          @etags[0] = [path,etag,data]
        else
          @etags.delete(arr)
          @etags.unshift( [path,etag,data] )
        end
      else
        @etags.unshift( [path,etag,data] )
      end
    end

  end
end