source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def base_pods
  pod 'ActorKit/Promises', :path => '../Libraries/ActorKit'
  pod 'ActorKit/Supervision', :path => '../Libraries/ActorKit'
  pod 'AFNetworking'
end

target 'TestActorKit', :exclusive => true do
  base_pods
end

target 'TestActorKitTests', :exclusive => true do
  base_pods
end
