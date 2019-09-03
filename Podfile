#keeping this around incase we need to try another pod
#source 'https://github.com/CocoaPods/Specs.git'

# platform :ios, '10.0'

inhibit_all_warnings!
use_frameworks!

workspace 'FreeNow'

target 'FreeNow' do
  project 'FreeNow'

  pod 'BrightFutures'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'Alamofire'

  target 'FreeNowTests' do
    inherit! :search_paths
      pod 'Spry'
      pod 'Spry+Nimble'
      pod 'Nimble'
      pod 'Quick'
      pod 'KIF'
  end

  target 'FreeNowUITests' do
  end
end

target 'FNApi' do
    project 'FNApi/FNApi'

    pod 'Alamofire'
    pod 'BrightFutures'
    pod 'Swinject'
end

target 'FNFoundation' do
    project 'FNFoundation/FNFoundation'

    pod 'Swinject'
end

target 'FNUIKit' do
    project 'FNUIKit/FNUIKit'

    pod 'Swinject'
end
