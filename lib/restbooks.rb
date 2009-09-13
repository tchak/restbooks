# 
#  restbooks.rb
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

require 'rubygems'
require 'rest_client'
require 'rexml/document'
require 'cgi'
require 'digest/md5'
#require 'json'

require 'uri/uri'
require 'restbooks/mixins/api'
require 'restbooks/mixins/model'
require 'restbooks/models/author'
require 'restbooks/models/book'
require 'restbooks/models/comment'
require 'restbooks/models/list'
require 'restbooks/models/category'
require 'restbooks/authors'
require 'restbooks/books'
require 'restbooks/lists'
require 'restbooks/categories'

module RestBooks
  class Client
    attr_reader :uri, :user_agent

    def initialize( options={} )
      # Set host
      host = options.has_key?( :host ) ? options.delete(:host) : 'http://feedbooks.com'
      
      # Set user-agent
      @user_agent = options.has_key?( :user_agent ) ? options.delete( :user_agent ) : "RestBooks 0.1"

      # Set service URI
      @uri = URI.parse( host )

      # Set authentification
      if options.has_key?( :user ) && options.has_key?( :password )
        @uri.user = options.delete( :user )
        @uri.password = Digest::MD5.hexdigest( options.delete( :password ) )
      end

      # Set logger output
      RestClient.log = options.delete( :log ) if options.has_key?( :log )

      # Init services
      @books = false
      @authors = false
      @lists = false
      @categories = false
    end
    
    # Use this object to acess books resource
    def books
      @books = Books.new( self ) if !@books
      return @books
    end
    
    # Use this object to acess authors resource
    def authors
      @authors = Authors.new( self ) if !@authors
      return @authors
    end
    
    # Use this object to acess lists resource
    def lists
      @lists = Lists.new( self ) if !@lists
      return @lists
    end
    
    # Use this object to acess categories resource
    def categories
      @categories = Categories.new( self ) if !@categories
      return @categories
    end

  end
end