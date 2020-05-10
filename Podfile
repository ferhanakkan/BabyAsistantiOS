# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
     end
  end
end

target 'BabyAssistant' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
    pod 'RealmSwift'
    pod 'PromisesSwift'
    pod 'NotificationBannerSwift', '2.2.2'
    pod 'Alamofire', '5.0.0-rc.2'
    pod 'Localize', '2.3.0'
    pod 'IQKeyboardManagerSwift', '6.5.0'
    pod 'Kingfisher', '5.8.1'
    pod 'SnapKit', '5.0.1'
    pod 'SkeletonView', '1.8.2'
    pod 'DLRadioButton', '1.4.12'
    pod 'KDCircularProgress', '1.5.4'
    pod 'HMSegmentedControl', '1.5.3'
    pod 'DZNEmptyDataSet', '1.8.1'
    pod 'DateScrollPicker', '1.0.1'
    pod 'Firebase/Analytics'
    pod 'Firebase/Auth'
    pod 'Firebase/Core'
    pod 'Firebase/Firestore'
    pod 'Firebase/Storage'
    pod 'Fabric', '~> 1.10.2'
    pod 'Firebase/Crashlytics'
    pod 'BEMCheckBox'
    pod 'OneSignal', '>= 2.11.2', '< 3.0'
    
   target 'OneSignalNotificationServiceExtension' do
     pod 'OneSignal', '>= 2.11.2', '< 3.0'
   end
  

  # Pods for BabyAssistant

end
