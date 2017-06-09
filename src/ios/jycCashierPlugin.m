/********* jycCashierPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "SYTViewController.h"

@interface jycCashierPlugin : CDVPlugin <SYTViewControllerDelegate>{
    CDVInvokedUrlCommand *command_;
  // Member variables go here.
}
@property (nonatomic, strong) SYTViewController *controller;
- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation jycCashierPlugin

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    command_ = command;
    //NSLog(@"command111111111=%@",command_ .arguments[0]);
//    
//    SYTViewController *controller = [[SYTViewController alloc] init];
//    NSLog(@"controller=%@",controller);
//    controller.delegate = self;
//    [controller initWithPreOrderUrl:@"https://api-syt-pama.pingan.com.cn/pama_cashier_web/index.html" Command:command_.arguments[0]];
//    [self.viewController presentViewController:controller  animated:YES completion:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payComplete:) name:@"payComplete" object:nil];
//    
    
    
    
    self.controller = [[SYTViewController alloc] init];
    NSLog(@"controller=%@",self.controller);
    self.controller.delegate = self;
    [self.controller initWithPreOrderUrl:@"https://api-syt-pama.pingan.com.cn/pama_cashier_web/index.html" Command:command_.arguments[0]];
    [self.viewController presentViewController:self.controller  animated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payComplete:) name:@"payComplete" object:nil];

    
    
    
    
}

#pragma mark - SYTViewControllerDelegate
- (void)payResult:(NSString *)result
{
    //插件回调
    CDVPluginResult* pluginResult = nil;
    
    if (result != nil && [result length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command_.callbackId];
}

typedef NS_ENUM(NSInteger, AliPayResultStatusCode)
{
    AliPayResultStatusCodeSucess        = 9000, // 订单支付成功
    AliPayResultStatusCodeDealIng       = 8000, // 正在处理中，支付结果未知
    AliPayResultStatusCodeUnknow        = 6004, // 支付结果未知
    AliPayResultStatusCodeFaile         = 4000, // 订单支付失败
    AliPayResultStatusCodeRepeat        = 5000, // 重复请求
    AliPayResultStatusCodeUserCancel    = 6001, // 用户中途取消
    AliPayResultStatusCodeNetError      = 6002, // 网络连接错误
};

- (void)payComplete:(NSNotification *)noti
{
    NSDictionary *dict = noti.userInfo;
    AliPayResultStatusCode code = [dict[@"resultStatus"] integerValue];
    
    
    
    NSLog(@"支付状态=%ld",(long)code);
    switch (code) {
        case 9000:// 订单支付成功
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.controller dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"支付成功  返回上一级页面");
                   
                }];
                
                
            }]];
            [self.controller presentViewController: alert animated: YES completion: nil];
        }break;

            
            
        case 8000:// 正在处理中，支付结果未知
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"正在处理中，支付结果未知" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.controller dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"正在处理中，支付结果未知");
                }];
                
            }]];
            [self.controller presentViewController: alert animated: YES completion: nil];
            
        } break;

            
            
        case 6004://支付结果未知
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付结果未知" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.controller dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"支付结果未知");
                    
                }];

            }]];
            [self.controller presentViewController:alert animated:YES completion:nil];
           
            
        } break;
            
            
        case 4000:// 订单支付失败
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.controller dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"支付失败");
                }];
                
                
            }]];
            [self.controller presentViewController: alert animated: YES completion: nil];
            
           
            
        } break;
            
            
        case 5000:// 重复请求

        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重复请求" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.controller dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"重复请求");
                    
                }];

            }]];
            [self.controller presentViewController:alert animated:YES completion:nil];
            
        } break;

            
            
        case 6001: // 用户中途取消
        {
            NSLog(@"中途取消");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付取消" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.controller dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"支付取消");
                    
                }];

            }]];
            [self.controller presentViewController:alert animated:YES completion:nil];
           
            
        } break;

            
        case 6002: // 网络链接错误
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络链接错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.controller dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"网络链接错误");
                    
                }];

            }]];
            [self.controller presentViewController:alert animated:YES completion:nil];
           
            
        } break;
        default:
            break;
    }
    
}



@end


