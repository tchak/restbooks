# 
#  list.rb
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
    class List
      include RestBooks::Model
      attr_reader :title, :id, :updated, :description
      
      def initialize(element)
        if element
          @element = element
          @element.xpath('*').each do |tag|
            case tag.name
            when 'title'
              @title = tag.text.strip
            when 'id'
              @id = tag.text.split('/').last
              @id = @id.split(':').last if @id.split(':').length > 1
            when 'updated'
              @updated = Date.parse(tag.text)
            when 'content'
              @description = tag.text.strip
            end
          end
        else
          @element = Nokogiri::XML::Element.new('entry')
        end
      end

      def to_hash
        return { :title => @title,
          :id => @id,
          :updated => @updated,
          :description => @description }
      end

    end
  end
end
