//
//  IPAddress.h
//  ScmProject
//
//  Created by zhoudong on 2018/7/7.
//  Copyright © 2018年 session. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPAddress <NSObject>


#pragma mark - 服务器连接开关  1 测试服(t) 2 正式服(r)
//修改此处链接不同服务器  1 测试服务  2 正式服务器
#define SERVICE_LINK_FLAG 1



#if SERVICE_LINK_FLAG == 1

#define serviseIP @"https://mallapi.jie1.top/api/"
#define serviseShareIP @"https://mallapi.jie1.top/"

#endif

#if SERVICE_LINK_FLAG == 2

#define serviseIP @"https://mallapi.jie1.top/api/"
#define serviseShareIP @"https://mallapi.jie1.top/"

#endif

//登录注册
#define verifyCode @"register-verify-code" //注册发验证码
#define userRegister @"register" //注册
#define loginIn @"loginIn" //登录
#define loginVerifyCode @"login-verfy-code" //注册发验证码
#define forgetVerifyCode @"forget-verfy-code" //注册发验证码
#define forgetNextStep @"forget-next-step" //注册发验证码
#define forgetResetPassword @"reset-password" //注册发验证码

//获取用户信息
#define UserInformation @"user" //获取用户信息
#define VersionUpdate @"version" //版本更新
#define NameUpdate @"user/update" //更新用户名

//域名购买
#define RotaryPic @"rotary-picture/index" //首页轮播图
#define DomainNameWheel @"hang-sale/wheel-planting" //首页轮播
#define DomainHot @"recommended-domain-name/index" //热门域名
#define Domain @"domain" //查询获取域名展示
#define DomainConsole @"domain-name-manage/console" //控制台
#define DomainShow @"domain-show" //查询获取域名展示
#define DomainPurchase @"domain-purchase" //立即购买
#define DomainRenewList @"domain-renewal-order/list" //域名续费选择域名列表
#define DomainIndex @"domain-index" //购买列表
#define DomainPurchaseDetail @"domain-purchase-detail" //支付详情
#define PaymentPay @"payment/pay" //购买
#define PaymentRenewPay @"domain-renewal-order/pay" //购买
#define HangSearchDN @"hang-sale/search-domain-name" //选择求购域名

//域名管理
#define DomainNameManage @"domain-name-manage/index" //域名列表
#define DomainNameSearch @"domain-name-manage/search" //我的域名搜索
#define DomainNameDetail @"domain-name-manage/show" //域名详情
#define DomainNameBind @"domain-name-manage/show-bind-or-notbind" //域名详情-已绑定
#define DomainNameSelect @"domain-name-manage/public-domain" //自选币种
#define DomainNameBindInit @"domain-name-manage/bind-init" //域名-绑定-换绑-解除绑定地址
#define DomainPaymentFee @"withdrawal/get-payment-fee" //解绑换绑的手续费
#define DomainNameBatchPay @"batch-bind/pay" //批量解绑地址

//个人中心
#define ConsumeRecord @"consume-record/show-index" //账户明细
#define BankCards @"withdrawal/bank-cards" //获取我的银行卡
#define BankCardDestroy @"bank-card/destroy" //删除银行卡
#define Withdrawal @"withdrawal/cny-withdrawal" //提现
#define Transfer @"user/money-transfer" //金币划转
#define WithdrawalUSDT @"withdrawal/usdt-withdrawal" //USDT提币
#define ConsumeRecordShow @"consume-record/show" //交易流水详情
#define BankCardCreate @"bank-card/create" //添加银行卡
#define ConsumeRecordList @"consume-record/list" //进出帐列表
#define Certification @"certification/create" //实名认证
#define MyTeamIndex @"my-team/index" //我的团队
#define IncomeDetails @"consume-record/income-details" //收益明细
#define UpgradeSendCode @"upgrade-verfy-code" //升级代理商获取手机验证码
#define UpgradeAgent @"upgrade-agent/upgrade" //代理商升级
#define SetPayPsw @"user/setting-pay-password" //设置资产密码
#define UpdatePayPsw @"user/update-pay-password" //更新资产密码
#define IntegralIndex @"integral-log/index" //积分列表
#define MessageCreate @"message/create" //留言反馈
#define PayPswVerify @"pay-password-verify-code" //更新资产密码获取手机验证码
#define PayPswNextStep @"user/next-pay-password" //更新资产密码下一步
#define PromotionCenter @"promotion-center/index" //推广中心背景图
#define PartnerSharingIndex @"partner-sharing/index" //我的合作商权益设置
#define PartnerSharingUpdate @"partner-sharing/update" //我的合作商权益更新
#define WalletAddressIndex @"user-wallet-address/index" //地址管理列表
#define WalletAddressStore @"user-wallet-address/store" //添加地址
#define WalletAddressDestory @"user-wallet-address/destroy" //删除地址
#define OriginalCode @"original-code" //获取原手机号验证码
#define CheckOriginalCode @"user/check-original-code" //下一步
#define NewCode @"new-phone-code" //新手机号获取验证码
#define UpdateNewCode @"user/update-new-phone" //完成
#define AgentCenterBanner @"agent-center-banel/index" //个人中心banel图
#define AgentCenterBottomBanner @"agent-center-bottom-banel/index" //代理商中心banel图

//上传图片
#define ImageUpload @"upload"
#define ImageUploadBulk @"upload-bulk"  //批量上传图片
#define UpdateAvatar @"user/update-avatar"

//商城
#define ShopHangBuy @"hang-sale/index-buy" //求购域名列表
#define ShopHangSale @"hang-sale/index" //域名商城列表
#define DomainSuffix @"domain-suffix/index" //获取所有域名后缀
#define DomainSearchTerm @"search-term/index" //搜索项
#define DomainHangSaleInit @"hang-sale/hang-sale-init" //挂单选择域名
#define DomainHangSaleStore @"hang-sale/store" //域名挂单
#define DomainHangSaleBuy @"hang-sale/create-buying" //添加求购域名
#define DomainHangSaleShow @"hang-sale/show" //购买订单
#define DomainHangSalePay @"hang-sale/pay" //支付购买
#define DomainHangSalePayBuy @"hang-sale/pay-buying" //售出求购域名
#define DomainOrderManage @"hang-sale/order-management" //支付购买
#define DomainHangSaleOrder @"hang-sale/show-data" //订单详情
#define DomainHangSaleOrderDestroy @"hang-sale/destroy" //取消订单
#define DomainHangSaleIfSelf @"hang-sale/domain-name-is-self" //查询域名是否在自己名下

//首页
#define NewInformation @"new-information/index"   //首页
#define NewInformationMore @"new-information/more-index" //查看更多
#define NewInformationLike @"new-information/like-new" //点赞
#define NewInformationShow @"new-information/show" //详情

//购物车
#define ShoppingCartIndex @"shopping-cart/index"  //我的购物车列表
#define ShoppingCartDestroy @"shopping-cart/destroy"   //删除购物车
#define DomainNameCategory @"domain-name-category/index" //获取域名分类
#define RecommendedDomainName @"recommended-domain-name/search" //根据域名分类搜索推荐域名
#define ShoppingCartStore @"shopping-cart/store" //添加购物车
#define BrowserIndex @"browser/search-article" //浏览器文章搜索
#define RecommendedDNHomepage @"recommended-domain-name/label-domain-name" //首页推荐标签域名
#define RecommendedDNHomepageMore @"recommended-domain-name/label-domain-name-all" //查看更多推荐域名
#define BrowserRecommendHot @"browser/hot-recommend"  //热门推荐文章
#define BrowserMyArticle @"article-chain/index-list"  //我的文章列表
#define BrowserPublichChain @"article-public-chain/index"  //获取文章上链的公链
#define BrowserBindAllDomain @"article-chain/bind-article-all-domain" //所有域名地址
#define BrowserShow @"browser/show" //文章详情（域名浏览器端进入）
#define BrowserSearchDN @"browser/search-domain-name" //获取当前文章下所有的域名（域名浏览器进入）
#define BrowserSearchChain @"browser/search-public-chain" //获取当前文章下所有的公链（域名浏览器进入）
#define BrowserDomainHash @"article-chain/domain-name-hash" //获取我的域名下所有的hash
#define BrowserDomainDeleteHash @"article-chain/delete-article-chain-hash" //域名解绑hash
#define BrowserDomainBindHash @"article-chain/bind-article-chain-hash" //域名绑定hash
#define BrowserDomainDeleteArticleChain @"article-chain/domain-name-remove-article-chain" //文章解绑域名
#define BrowserDomainBindArticleChain @"article-chain/domain-name-bind-article-chain" //文章绑定域名
#define ArticleChainStore @"article-chain/new-create" //发布文章
#define ArticleChainSearchHash @"article-chain/search-hash" //查询我自己是否有这个hash
#define BrowserNewArticle @"browser/new-article" //功能首页
#define BrowserUseDomain @"article-chain/use-domain-name" //文章发布选择域名
#define BrowserSticky @"sticky-configuration/index"  //获取文章置顶配置
#define BrowserFavorites @"article-chain/favorites-list"  //我的文章收藏列表
#define BrowserArticleaPay @"browser/article-chain-pay"  //首页-我的付费文章
#define BrowserAddFavorite @"article-chain/add-favorite"  //收藏/取消收藏文章
#define BrowserArticleType @"article-type/index"  //获取文章分类
#define BrowserArticleAppreciationList @"article-appreciation-record/index"  //文章赞赏支付列表
#define BrowserArticleAppreciationPay @"article-appreciation-record/appreciate-pay"  //文章赞赏支付列表
#define BrowserArticleTollPay @"article-toll-record/pay"  //文章付费查看
#define BrowserSearchDomain @"browser/search-domain" //浏览器域名搜索
#define BrowserArticleUpdate @"article-chain/update" //文章编辑-服务项
#define BrowserChainSearch @"public-chain-infomation/search" //资产信息

#define EpidemicList @"epidemic-chain/list" //疫情

//存证上链
#define CertificateIndex @"deposit-certificate-categorys/index"//存证上链
#define CertificatePay @"deposit-certificate-categorys/pay"//支付购买次数
#define CertificateCreate @"deposit-certificate/create"//新建存证
#define MyCertificateList @"deposit-certificate/index"//我的存证
#define CertificateBindDomain @"deposit-certificate/bind-domain"//绑定域名
#define CertificateBindList @"deposit-certificate/deposit-certificate-bind-domain"//获取我的存证绑定的域名
#define CertificateBindAllList @"deposit-certificate/bind-deposit-all-domain"//获取我的存证绑定的域名
#define CertificateUnbindDomain @"deposit-certificate/untie-domain"//解绑域名
#define CertificateDetail @"deposit-certificate/show"//存证详情
#define CertificateBrowser @"browser/search-deposit-certificate"//搜索存证

//获取我的购物车数量
#define ShoppingCartRedCount @"shopping-cart/get-count" //获取我的购物车数量
//优惠券
#define KachinIndex @"kachin/index" //我的卡券
#define GiveKachin @"kachin/give-kachin" //赠送卡劵

//币币账户
#define CurrencyIndex @"currency/index"   //我的币币帐户
#define Currencyselect @"currency/search"   //添加地址获取币种
#define CurrencyExchangeRate @"currency/get-exchange-rate"  //获取币种汇率
#define CurrencyRecord @"currency-record/index"  //币币帐户交易记录
#define CurrencyRecordDetail @"currency-record/show"  //币币交易记录详情
#define CurrencyDetail @"currency/show"  //我的币种详情
#define CurrencyCoinPull @"currency/coin-currency"  //币币帐户提币
#define CurrencyEthMoney @"eth-money-address/index"  //获取ERC20充币地址
#define CurrencySearchDNS @"search/dns"  //读取公链上的kv关系

//通知中心
#define NoticeIndex @"notice/index"  //通知中心
#define NoticeRead @"notice/is-read" //通知未读和已读

//网络建站
#define WebsiteTempList @"website-template/index"//获取所有网站模板
#define WebsiteStore @"website/store"//新建网站
#define WebsiteList @"website/index"//我的网站
#define WebsiteUpdate @"website/update"//更新网站
#define WebsiteDetail @"website/show"//网站详情
#define WebsiteDelete @"website/delete"//删除网站
#define WebsiteDomainList @"website-domain/index"//我的所有绑定网站的域名
#define WebsiteArticleList @"website-article/index"//我的网站下的文章管理
#define WebsiteArticleDetail @"website-article/show"//文章详情
#define WebsiteCategoryNavigation @"website/website-category-navigation"//获取网站下所有的分类导航
#define WebsiteArticleStore @"website-article/store"//发布文章支付
#define WebsiteArticleUpdate @"website-article/update"//更新文章隐藏或显示
#define WebsiteArticleUpdateCarousel @"website/update-carousel"//网站更新轮播图
#define WebsiteArticleUpdateNavigation @"website/update-category-navigation"//网站更新分类导航
#define WebsiteBindDomain @"website/bind-domain-name"//网站绑定域名
#define WebsiteOneDomainList @"website-domain/index-one-domain"//单个网站绑定的所有域名
#define WebsiteUnbindDomain @"website/remove-domain-name"//网站移除绑定的域名
#define BrowserSeachWebsite @"browser/search-website"//域名浏览器搜索网站


#pragma -mark 商城
#define ShopLogin @"user/login" //登录
#define GoodList @"my-good/index" //我的资产列表
#define GetMyFuel @"user/get-my-fuel" //我的燃料
#define GoodTransRecordList @"good-transaction-record/index" //资产记录
#define GoodTransRecordDetail @"good-transaction-record/show" //资产记录详情

#define GoodCategoryList @"good-one-category/index" //获取所有商品一级分类和二级分类
#define SecondGoodList @"good/index" //商品列表
#define SecondGoodDetail @"good/show" //商品详情
#define BlockChainDetail @"good/show-block" //商品区块详情
#define GoodPay @"order/pay-good" //商品区块详情

#define UserInfo @"user/index" //获取用户信息
#define GoodsMyOrderIndex @"pick-order/index" //我的订单
#define GoodsRemind @"remind-ship/remind" //我的订单
#define GoodsMyOrderDetail @"pick-order/show" //提货订单详情
#define FuelRecordIndex @"fuel-transaction-record/index" //燃料交易记录
#define FuelRecordDetail @"fuel-transaction-record/show" //燃料交易详情
#define FuelConfiguration @"fuel-configuration/index" //获取燃料充值配置
#define FuelRecharge @"user/recharge-fuel" //充值
#define FuelRechargeRecord @"fuel-transaction-record/recharge-record" //充值记录列表

#define AddressList @"address-management/index" //地址管理
#define AddressStore @"address-management/store" //添加
#define AddressDelete @"address-management/destroy" //删除
#define AddressUpdate @"address-management/update" //修改
#define FeedUploadImage @"upload/bulk-upload"  //批量上传图片
#define ShopMessageStore @"message/store"  //留言反馈
#define ShopSetNickName @"user/set-nickname"  //更新昵称

#define ShopVersionUpdate @"version/index"  //版本更新

#define AddressBookList @"address-book/index"  //通讯录列表
#define AddressBookStore @"address-book/store"  //添加好友
#define AddressBookDelete @"address-book/destroy"  //删除好友
#define AddressBookEdit @"address-book/update"  //编辑好友

#define MallGetNonce @"nuls-api/get-as-nonce"  //获取地址上的nonce值
#define MallSendAway @"my-good/give-away"  //转赠
#define MallPickUp @"my-good/pick-up"  //提货

//溯源
#define SourceList @"good-traceability/index"  //溯源
#define SourceDetailList @"good-traceability/show"  //物品溯源详情

@end
