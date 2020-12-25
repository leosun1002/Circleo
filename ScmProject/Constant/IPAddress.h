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

#define serviseIP @"http://121.37.250.68/circleo/app/"
#define photoIp @"http://121.37.250.68/circleo"
#define serviseShareIP @"https://mallapi.jie1.top/"

#endif

#if SERVICE_LINK_FLAG == 2

#define serviseIP @"https://mallapi.jie1.top/api/"
#define serviseShareIP @"https://mallapi.jie1.top/"

#endif

//编号
#define resultCode @"resultCode"
#define resultMessage @"resultMessage"
#define resultData @"resultData"

#define PageSize @"10"

@end
