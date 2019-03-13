#
# Be sure to run `pod lib lint LDNestedPageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LDNestedPageView'
  s.version          = '1.0.0'
  s.summary          = 'LDNestedPageView是一个嵌套列表'
  s.description      = '一个使用tableView+collection实现的嵌套列表'

  s.homepage         = 'https://github.com/dongdongca/LDNestedPageView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '李东' => 'Black_leedong@163.com' }
  s.source           = { :git => 'https://github.com/dongdongca/LDNestedPageView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LDNestedPageView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LDNestedPageView' => ['LDNestedPageView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
