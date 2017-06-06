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
    //NSLog(@"command111111111=%@",command_ .arguments[0]);
    
    SYTViewController *controller = [[SYTViewController alloc] init];
    NSLog(@"controller=%@",controller);
    controller.delegate = self;
    [controller initWithPreOrderUrl:@"https://test-api-syt-pama.pingan.com.cn/pama_cashier_web/index.html" Command:command_.arguments[0]];
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


