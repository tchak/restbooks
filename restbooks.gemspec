# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{restbooks}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Chavard"]
  s.date = %q{2009-09-12}
  s.description = %q{Restbooks is a client library for feedbooks.com api.}
  s.email = %q{paul@chavard.net}
  s.homepage = %q{http://restbooks.tchak.net}
  s.require_paths = ["lib"]
  s.files = ["README", "LICENSE", "restbooks.rb", "restbooks/books.rb", "restbooks/authors.rb", "restbooks/categories.rb", "restbooks/lists.rb", "restbooks/extend/uri.rb", "restbooks/mixins/api.rb", "restbooks/mixins/model.rb", "restbooks/models/author.rb", "restbooks/models/book.rb", "restbooks/models/category.rb", "restbooks/models/comment.rb", "restbooks/models/list.rb"]
  #s.has_rdoc = true
  #s.extra_rdoc_files = ["README", "LICENSE"]
  #s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Restbooks is a client library for feedbooks.com api.}
end
