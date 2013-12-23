# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rerun_task/version"

Gem::Specification.new do |s|
  s.name        = "rerun_task"
  s.version     = RerunTask::VERSION
  s.authors     = ["lukasvotypka"]
  s.email       = ["lukas.votypka@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Re-run task if is not finished}
  s.description = %q{This gem is developed for handling rake task and re-run them if didn't finished successfully}

  s.rubyforge_project = "rerun_task"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "test-unit"
  s.add_development_dependency "mocha"
end
