# 
#  book.rb
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
  module Models
    class Book
      include RestBooks::Model
      attr_reader :title, :id, :author, :updated, :language, :date, :subject, :description, :rights
      
      def initialize( element=nil )
        @updated = Time.now
        @subject = []
        if element
          @element = element
          @element.elements.each do |tag|
            case tag.name
            when 'title'
              @title = tag.text
            when 'id'
              @id = tag.text.split('/').last
              @id = @id.split(':').last if @id.split(':').length > 1
            when 'updated'
              @updated = Date.parse( tag.text )
            when 'author'
              @author = tag.elements['name'].text
              @author_id = tag.elements['uri'].text.split('/').last
            when 'language' 
              @language = tag.text
            when 'date'
              @date = tag.text
            when 'subject'
              @subject << tag.text
            when 'description'
              @description = tag.text.strip()
            when 'rights'
              @rights = tag.text
            when 'content'
              @html = tag.text if tag.attributes['type'] == "xhtml"  
            end
          end
        else
          @element = REXML::Element.new( 'entry' )
        end
      end

      # def language=( str )
      #   @language = str
      #   @element.elements['dc:language'].text = str
      # end
      # 
      # def date=( str )
      #   @date = str
      #   @element.elements['dc:date'].text = str
      # end
      # 
      # def subject=( str )
      #   
      # end
      # 
      # def description=( str )
      #   @description = str
      #   @element.elements['dc:description'].text = str
      # end
      # 
      # def rights=( str )
      #   @rights = str
      #   @element.elements['dc:rights'].text = str
      # end

      def to_html
        return @html
      end

      def to_hash
        return { :title => @title,
          :id => @id,
          :author => @author,
          :author_id => @author_id,
          :updated => @updated,
          :language => @language,
          :date => @date,
          :subject => @subject,
          :description => @description,
          :rights => @rights }
      end

    end
  end
end