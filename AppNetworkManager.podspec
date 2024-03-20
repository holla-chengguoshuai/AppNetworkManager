#
# Be sure to run `pod lib lint AppNetworkManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppNetworkManager'
  s.version          = '0.1.0'
  s.summary          = 'A short description of AppNetworkManager.'

  s.homepage         = 'https://github.com/guoshuai.cheng@holla.world/AppNetworkManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guoshuai.cheng@holla.world' => 'guoshuai.cheng@holla.world' }
  s.source           = { :git => 'https://github.com/guoshuai.cheng@holla.world/AppNetworkManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'AppNetworkManager/Classes/**/*'
  
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'ObjectMapper'
  s.dependency 'HandyJSON'
end
