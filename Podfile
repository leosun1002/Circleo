platform :ios,'8.0'
source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!
#use_frameworks!
target "ScmProject" do
pod 'SDWebImage', '~> 4.4.1'
#pod 'AFNetworking', '~> 3.2.0'
pod 'Masonry', '~> 1.1.0'
#pod 'HHRouter', '~> 0.1.9'
pod 'MJRefresh', '~> 3.1.15.3'
pod 'YYText'

pod 'ReactiveCocoa', '~> 2.5'
pod 'SDCycleScrollView','~> 1.65’       #轮播广告控件
pod 'SVProgressHUD', '~> 2.2.5'
pod 'MJExtension'
pod 'CYLTableViewPlaceHolder'
#pod 'FlexLib'
#pod 'CMPopTipView'            #Pop弹窗类
pod 'IQKeyboardManager'
pod 'SGPagingView', '~> 1.5.6'
pod 'CYLTableViewPlaceHolder'
pod 'MLeaksFinder'        #开发时打开
pod 'JXCategoryView'
pod 'JXPagingView/Pager'
pod 'Bugly'

pod 'WechatOpenSDK'
pod 'AlipaySDK-iOS'
pod 'TZImagePickerController'
pod 'UMCCommon'
pod 'UMCAnalytics'
#pod 'UMCSecurityPlugins'
pod 'UMCShare/UI'
pod 'UMCShare/Social/ReducedWeChat'   #友盟分享到微信
pod 'FLAnimatedImage'
pod 'SDWebImage/GIF'
pod 'lottie-ios'
pod 'BHBPopView'
pod 'BRPickerView'

pod 'AliPlayerSDK_iOS'

pod 'NIMKit'

#视频剪辑
pod 'AliyunVideoSDKStd', '3.16.2'
#pod 'QuCore-ThirdParty', '3.15.0'
#pod 'AlivcConan', '1.0.3'
pod 'VODUpload'
pod 'AliyunOSSiOS'

end        

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['ARCHS'] = 'arm64'
    end
  end
end



