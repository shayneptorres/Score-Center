# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Score Center' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Score Center
pod 'Realm', git: 'https://github.com/realm/realm-cocoa.git',:submodules => true, branch: 'master'
pod 'RealmSwift', git: 'https://github.com/realm/realm-cocoa.git',:submodules => true, branch: 'master'

  target 'Score CenterTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Score CenterUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end
