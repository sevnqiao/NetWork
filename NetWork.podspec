#NetWork.podspec
Pod::Spec.new do |s|
s.name         = "NetWork"
s.version      = "0.0.3"
s.summary      = "a light weight framework"
s.homepage     = "https://github.com/sevnqiao/NetWork"
s.license      = 'MIT'
s.author       = { "sevn_Xiong" => "1020203007@qq.com" }
s.source       = { :git => "https://github.com/sevnqiao/NetWork.git", :tag => s.version}
s.source_files = 'NetWork/NetWork/*.{h,m}'

s.platform     = :ios, '7.0'            #支持的平台及版本
s.requires_arc = true

s.frameworks   = 'UIKit', 'Foundation'
s.dependency 'AFNetworking', '~> 2.6.0'
s.dependency 'MJExtension',  '~> 3.0.13'
s.dependency 'YYModel',      '~> 1.0.4'
end