####
# Restbooks Gem

Gem::Specification.new do |s|
  s.specification_version = 3 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = 'restbooks'
  s.version = '0.2.0'
  s.date = '2010-03-12'

  s.homepage = "http://restbooks.tchak.net"
  s.description = "Restbooks is a client library for feedbooks.com api"
  s.summary     = "Restbooks is a client library for feedbooks.com api"

  s.authors = ["Paul Chavard"]
  s.email = "paul@chavard.net"

  # = MANIFEST =
  s.files = [
    "README",
    "LICENSE",
    "lib/uri/uri.rb",
    "lib/restbooks.rb",
    "lib/restbooks/books.rb",
    "lib/restbooks/authors.rb",
    "lib/restbooks/categories.rb",
    "lib/restbooks/lists.rb",
    "lib/restbooks/mixins/api.rb",
    "lib/restbooks/mixins/model.rb",
    "lib/restbooks/models/author.rb",
    "lib/restbooks/models/book.rb",
    "lib/restbooks/models/category.rb",
    "lib/restbooks/models/comment.rb",
    "lib/restbooks/models/list.rb"
  ]
  # = MANIFEST =

  s.require_paths = %w[lib]
  s.add_runtime_dependency 'rest-client', '>= 1.4.1'
  s.add_runtime_dependency 'nokogiri'
  s.add_development_dependency 'json'
  s.rubygems_version = '1.3.6'

  #s.test_files = s.files.select {|path| path =~ /^test\/.*_test.rb/}

  #s.has_rdoc = true
  #s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Restbooks", "--main", "README.rdoc"]
  #s.extra_rdoc_files = %w[README.rdoc LICENSE]
end

