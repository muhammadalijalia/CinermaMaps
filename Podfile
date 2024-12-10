# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'Cinerama Maps' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Cinerama Maps

##pod 'R.swift'
pod 'R.swift', '~> 5.4.0'
pod 'Parchment'

pod 'Cosmos'

pod 'CountryPickerView'
pod 'OTPFieldView'

pod 'SDWebImage/WebP'

pod 'Alamofire', '~> 4.9.1'

pod 'DropDown'
pod 'IQKeyboardManagerSwift'

pod 'GoogleMaps'
pod 'GooglePlaces'

pod 'InputMask'
pod 'SwiftyJSON'

pod 'LanguageManager-iOS'
#pod 'SVGKit'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    # Fix libarclite_xxx.a file not found.
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
