//
//  SYTViewController.h
//  SYTPayKit
//
//  Created by HanLiu on 2017/2/22.
//  Copyright © 2017年 HanLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYTViewControllerDelegate <NSObject>

- (void)payResult:(NSString *)result;

@end

@interface SYTViewController : UIViewController
@property(nonatomic,weak)id<SYTViewControllerDelegate> delegate;

- (void)initWithPreOrderUrl:(NSString *)url;

@end

