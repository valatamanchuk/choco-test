platform :ios, '15.0'
use_frameworks!
inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

def shared_pods
  pod 'Locksmith'
  pod 'SnapKit'
  pod 'IQKeyboardManager'
  pod 'MXParallaxHeader'
  pod 'Kingfisher'
  pod 'Tabman'
  pod 'RealmSwift', '~>10'
  pod 'DZNEmptyDataSet'
end

def debug_pods
  pod 'SwiftLint'
end

target 'choco-test' do
  debug_pods
  shared_pods
end

target 'choco-testTests' do
  shared_pods
end

target 'choco-testUITests' do
  shared_pods
end
