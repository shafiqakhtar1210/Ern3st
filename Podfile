# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Ern3st' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Ern3st
  pod 'BubbleTransition', '~> 3.2.0'

  pod 'I3DRecorder', :git => 'https://github.com/TG3Ds/in3D-iOS-SDK.git'
  pod 'CircleBar'
  pod 'DWAnimatedLabel', '~> 1.1'
  pod 'Tg3dMobileScanSDK-iOS'
  pod 'ZIPFoundation', '~> 0.9'
  pod 'ZIPFoundation', '~> 0.9'
  pod 'AnimatedCollectionViewLayout'
  pod 'SwiftyJSON'
  pod 'Alamofire'
post_install do |installer|
  installer.generated_projects.each do |project|
            project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                 end
            end
     end
  installer.aggregate_targets.each do |target|
    target.xcconfigs.each do |variant, xcconfig|
      xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
      IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
    end
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
        xcconfig_path = config.base_configuration_reference.real_path
        IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
    end
  end
end
end
