#YQNetworking.podspec
Pod::Spec.new do |s|
s.name         = "YQNetworking"
s.version      = "0.0.1"
s.summary      = "a light weight framework and easy to use netRequest"
s.homepage     = "https://github.com/sevnqiao/NetWork"
s.license      = 'MIT'
s.author       = { "sevn_Xiong" => "1020203007@qq.com" }
s.source       = { :git => "https://github.com/sevnqiao/NetWork.git", :tag => s.version}
s.dependency 'AFNetworking', '~> 2.6.3'
s.dependency 'MJExtension', '~> 3.0.13'
s.dependency 'YYModel', '~> 1.0.4'
s.source_files  = 'NetWork/NetWork/*.{h,m}'
s.requires_arc = true
end