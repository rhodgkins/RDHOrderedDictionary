Pod::Spec.new do |s|
  s.name = 'RDHOrderedDictionary'
  s.version = '0.2.1'
  s.license = 'MIT'
  
  s.summary = 'Ordered version of NSDictionary.'
  s.homepage = 'https://github.com/rhodgkins/RDHOrderedDictionary'
  s.author = 'Rich Hodgkins'
  s.source = { :git => 'https://github.com/rhodgkins/RDHOrderedDictionary.git', :tag => s.version.to_s }
  
  s.frameworks = 'Foundation'
  s.requires_arc = true

  s.ios.deployment_target = '5.1'
  s.osx.deployment_target = '10.7'
  s.source_files = 'RDHOrderedDictionary/**/*.{h,m}'
  s.public_header_files = 'RDHOrderedDictionary/RDHOrderedDictionary.h', 'RDHOrderedDictionary/NSMutableDictionary+RDHCombinationOperations.h'
end
