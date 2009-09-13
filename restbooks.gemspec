# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{restbooks}
  s.version = "0.1.3"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Chavard"]
  s.date = %q{2009-09-12}
  s.description = %q{Restbooks is a client library for feedbooks.com api.}
  s.email = %q{paul@chavard.net}
  s.homepage = %q{http://restbooks.tchak.net}
  s.require_paths = ["lib"]
  s.files = ["README", "LICENSE", "lib/restbooks.rb", "lib/restbooks/books.rb", "lib/restbooks/authors.rb", "lib/restbooks/categories.rb", "lib/restbooks/lists.rb", "lib/uri/uri.rb", "lib/restbooks/mixins/api.rb", "lib/restbooks/mixins/model.rb", "lib/restbooks/models/author.rb", "lib/restbooks/models/book.rb", "lib/restbooks/models/category.rb", "lib/restbooks/models/comment.rb", "lib/restbooks/models/list.rb"]
  #s.has_rdoc = true
  #s.extra_rdoc_files = ["README", "LICENSE"]
  #s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Restbooks is a client library for feedbooks.com api.}
  
  if s.respond_to? :specification_version then
      current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
      s.specification_version = 3

      if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
        s.add_development_dependency(%q<rest_client>, [">= 1.0.3"])
      else
        s.add_dependency(%q<rest_client>, [">= 1.0.3"])
      end
    else
      s.add_dependency(%q<rest_client>, [">= 1.0.3"])
    end
end
