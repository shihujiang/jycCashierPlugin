/********* jycCashierPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "SYTViewController.h"

@interface jycCashierPlugin : CDVPlugin <SYTViewControllerDelegate>{
    CDVInvokedUrlCommand *command_;
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation jycCashierPlugin

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
      command_ = command;
//    CDVPluginResult* pluginResult = nil;
//    NSString* echo = [command.arguments objectAtIndex:0];
//
//    if (echo != nil && [echo length] > 0) {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }
//
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    
    SYTViewController *controller = [[SYTViewController alloc] init];
    controller.delegate = self;
//    [controller initWithPreOrderUrl:@"https://test-api-syt-pama.pingan.com.cn/pama_cashier_web/test1.html"];
//    [controller initWithPreOrderUrl:@"https://m.baidu.com"];
    [controller initWithPreOrderUrl:@"https://test-api-syt-pama.pingan.com.cn/pama_cashier_web/test1.html" Command:jsonString];
    [self.viewController presentViewController:controller  animated:YES completion:nil];
    
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


@end


