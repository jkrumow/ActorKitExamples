source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def base_pods
  pod 'ActorKit/Promises'
  pod 'ActorKit/Supervision'
end

def networking
	pod 'AFNetworking'
end

target 'TestActorKit', :exclusive => true do
  base_pods
  networking
end

target 'TestActorKitTests', :exclusive => true do
  base_pods
end
