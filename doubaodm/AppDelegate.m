//
//  AppDelegate.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/18.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SecondViewController.h"

#import "NewLoginViewController.h"

//引入JPush功能所需头文件
#import "JPUSHService.h"
//ios10注册apns所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#import "LeaveViewController.h"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
        NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
        NSString *token = [tokenid objectForKey:@"tokenid"];
    NSLog(@"%@",token);
    int intString = [token intValue];
    
        if (intString == 0) {
    
            //没有登录
    
            NewLoginViewController *vc = [[NewLoginViewController alloc]init];
    
            self.window.rootViewController = vc;
    
            [self.window makeKeyAndVisible];
    
        }else{
    
    ViewController *vc = [[ViewController alloc]init];
    SecondViewController *sc = [[SecondViewController alloc]init];
    
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:sc];;
    
    //选中与未被选中图片的渲染
    nav1.tabBarItem.title = @"留言";
    //    nav1.tabBarItem.image = [UIImage imageNamed:@"TAG.jpg"];
    nav1.tabBarItem.image = [[UIImage imageNamed:@"first"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"firsts"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    nav2.tabBarItem.title = @"工作";
    nav2.tabBarItem.image = [[UIImage imageNamed:@"second"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    nav2.tabBarItem.image = [[UIImage imageNamed:@""]];
    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"seconds"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.tabBar = [[UITabBarController alloc]init];
    self.tabBar.viewControllers = @[nav1,nav2];
    
    //隐藏导航栏
    nav1.navigationBarHidden = YES;
    nav2.navigationBarHidden = YES;
    
    self.window.rootViewController = _tabBar;
    
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.window makeKeyAndVisible];
    
    
    
        }
    
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc]init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    //    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"3048c87f980bd70dc5285ea4" channel:@"888" apsForProduction:YES advertisingIdentifier:nil];
    
    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        if (remoteNotification) {
            NSLog(@"推送消息==== %@",remoteNotification);
            [self goToMssageViewControllerWith:remoteNotification];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService setTags:nil alias:@"18306131899" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSLog(@"%d----%@---",iResCode,iAlias);
            
        }];
    });
    
    return YES;
}

//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    
}

//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error{
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//    // Required
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//    completionHandler();  // 系统要求执行这个方法
//}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //          NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        //        [rootViewController addNotificationCount];
        [self  goToMssageViewControllerWith:userInfo];
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    NSLog(@"尼玛的推送消息呢===%@",userInfo);
// 取得 APNs 标准信息内容，如果没需要可以不取
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
//    // 取得自定义字段内容，userInfo就是后台返回的JSON数据，是一个字典
//    [APService handleRemoteNotification:userInfo];
//    application.applicationIconBadgeNumber = 0;
//    [self goToMssageViewControllerWith:userInfo];
//}

//跳转指定页面
-(void)goToMssageViewControllerWith:(NSDictionary*)msgDic
{
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"push" forKey:@"push"];
    [pushJudge synchronize];
    
    LeaveViewController * VC = [[LeaveViewController alloc]init];
    VC.navStr = @"消息中心";
    VC.type = @"6";
    
    //    VC.messageDic = msgDic;
    //    VC.JSPush = YES;
    UINavigationController* Nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    //隐藏导航栏
    Nav.navigationBarHidden = YES;
    //这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
    [self.window.rootViewController presentViewController:Nav animated:NO completion:nil];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"尼玛的推送消息呢===%@",userInfo);
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    // NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        //        NSString *state = [NSString stringWithFormat:@"您有一条新消息%@",userInfo[@"aps"][@"alert"]];
        //        [JDStatusBarNotification  showWithStatus:state dismissAfter:1.5];
    }else{
        [self goToMssageViewControllerWith:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
        
        if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
            
            //   [self goToMssageViewControllerWith:userInfo];
            NSLog(@"-------------%@",userInfo);
        }else{
            
            [self goToMssageViewControllerWith:userInfo];
        }
        
    }
    
    // completionHandler(UIBackgroundFetchResultNewData);
    
    // 取得 APNs 标准信息内容
    
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得Extras字段内容
    
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);
    
    //判断程序是否在前台运行
    
    if (application.applicationState ==UIApplicationStateActive) {
        
        
        
    }
    
    
    
    // iOS 7 Support Required,处理收到的APNS信息
    
    //如果应用在后台，在这里执行
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    
    [application setApplicationIconBadgeNumber:0];//小红点清0操作
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [application setApplicationIconBadgeNumber:0];   //清除角标
    //    [application cancelAllLocalNotifications];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
