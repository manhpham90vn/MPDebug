Pod::Spec.new do |s|
  s.name             = 'MPDebug'
  s.version          = '1.0.3'
  s.summary          = 'A Debug Tools for iOS'
  s.description      = <<-DESC
A Debug Tools for iOS
                       DESC
  s.homepage         = 'https://github.com/manhpham90vn/MPDebug'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'manhpham90vn' => 'manhpham90vn@icloud.com' }
  s.source           = { :git => 'https://github.com/manhpham90vn/MPDebug.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'MPDebug/*.{h,m,swift}'
  s.preserve_path = 'MPDebug/module.modulemap'
  s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => "'${PODS_TARGET_SRCROOT}/MPDebug'" }
  s.swift_version = '5.0'
  s.dependency 'Socket.IO-Client-Swift', '~> 15.2.0'
   
end
