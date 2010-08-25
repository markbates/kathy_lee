# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kathy_lee}
  s.version = "0.2.0.20100825102713"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["markbates"]
  s.date = %q{2010-08-25}
  s.description = %q{kathy_lee was developed by: markbates}
  s.email = %q{mark+kathylee@markbates.com}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["lib/generators/kathy_lee/model/model_generator.rb", "lib/generators/kathy_lee/model/templates/fixtures.rb", "lib/generators/kathy_lee.rb", "lib/kathy_lee/attributes/binding.rb", "lib/kathy_lee/attributes.rb", "lib/kathy_lee/definition/binding.rb", "lib/kathy_lee/definition/has_many.rb", "lib/kathy_lee/definition/has_one.rb", "lib/kathy_lee/definition/relationship.rb", "lib/kathy_lee/definition.rb", "lib/kathy_lee/fakes.rb", "lib/kathy_lee/kathy_lee.rb", "lib/kathy_lee.rb", "README", "LICENSE"]
  s.homepage = %q{http://www.metabates.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{magrathea}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{kathy_lee}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<dummy>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<dummy>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<dummy>, [">= 0"])
  end
end
