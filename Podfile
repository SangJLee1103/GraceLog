# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GraceLog' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GraceLog
	pod 'Firebase/Core'
	pod 'Firebase/Database'
	pod 'Firebase/Firestore'
	pod 'Firebase/Storage'
	pod 'Firebase/Messaging'
	pod 'Firebase/Auth'
	pod 'GoogleSignIn'
	pod 'Then' 
	pod 'SDWebImage'
	pod 'Alamofire' 
	pod 'JGProgressHUD', '~>2.0.3'
	pod 'Toast-Swift', '~> 5.1.1'
	pod 'YPImagePicker'
	pod 'SnapKit'
	pod 'RxSwift'
	pod 'RxCocoa'
	pod 'RxGesture'
	pod 'NSObject+Rx'
	pod 'RxDataSources'
	pod 'ReactorKit'

  target 'GraceLogTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GraceLogUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

