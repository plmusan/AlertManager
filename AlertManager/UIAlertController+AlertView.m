//
//  UIAlertController+AlertView.m
//  Alert
//
//  Created by x.wang on 15/8/13.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import "UIAlertController+AlertView.h"
#import <objc/runtime.h>

static const void *kAlertDelegate   = "alert_delegate";
static const void *kAlertResult   = "alert_result";
static const void *kAlertCanSetDelegateOrBlock   = "alert_can_set";

@implementation UIAlertController (AlertView)

- (void)setAlertViewDelegate:(id)alertViewDelegate {
    NSAssert(self.canSetDelegateOrBlock, @"%@ can not set delegate.", self);
    if (self.canSetDelegateOrBlock) {
        objc_setAssociatedObject(self, kAlertDelegate, alertViewDelegate, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (id<UIAlertControllerAlertViewDelegate>)alertViewDelegate {
    id delegate = objc_getAssociatedObject(self, kAlertDelegate);
    if ([delegate conformsToProtocol:@protocol(UIAlertControllerAlertViewDelegate)]) {
        return delegate;
    }
    return nil;
}

- (void)setAlertResult:(UIAlertControllerAlertViewResult)alertResult {
    NSAssert(self.canSetDelegateOrBlock, @"%@ can not set result block.", self);
    if (self.canSetDelegateOrBlock) {
        objc_setAssociatedObject(self, kAlertResult, alertResult, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (UIAlertControllerAlertViewResult)alertResult {
    UIAlertControllerAlertViewResult result = objc_getAssociatedObject(self, kAlertResult);
    return result;
}

- (void)setCanSetDelegateOrBlock:(BOOL)canSetDelegateOrBlock {
    objc_setAssociatedObject(self, kAlertCanSetDelegateOrBlock, @(canSetDelegateOrBlock), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)canSetDelegateOrBlock {
    id flag = objc_getAssociatedObject(self, kAlertCanSetDelegateOrBlock);
    if ([flag isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)flag).boolValue;
    }
    return NO;
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message
                          preferredStyle:(UIAlertControllerStyle)style cancelButtonTitle:(NSString *)cancel
                  destructiveButtonTitle:(NSString *)destructive otherButtonTitles:(NSString *)others, ...  {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    controller.canSetDelegateOrBlock = YES;
    if (cancel) {
        [controller addActionWithTitle:cancel style:UIAlertActionStyleCancel];
    }
    if (destructive) {
        [controller addActionWithTitle:destructive style:UIAlertActionStyleDestructive];
    }
    if (others) {
        va_list vargs;
        NSString *varg = nil;
        [controller addActionWithTitle:others style:UIAlertActionStyleDefault];
        va_start(vargs, others);
        // 当传入的参数不为NSString对象时，会在此处Crash
        while ((varg = va_arg(vargs,id))) {
            [controller addActionWithTitle:varg style:UIAlertActionStyleDefault];
        }
        va_end(vargs);
    }
    return controller;
}

- (void)addButtonWithTitle:(NSString *)title {
    [self addActionWithTitle:title style:UIAlertActionStyleDefault];
}

- (void)addActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style {
    NSInteger index = self.actions ? self.actions.count : 0;
    typeof(self) __weak weakSelf = self;
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction *action) {
        [weakSelf clickedButtonAtIndex:index title:title];
    }];
    [self addAction:action];
}

- (void)clickedButtonAtIndex:(NSInteger)buttonIndex title:(NSString *)title {
    if (self.alertResult) {
        self.alertResult(title,buttonIndex);
    }
    if ([self.alertViewDelegate respondsToSelector:@selector(alertController:clickButtonAtIndex:title:)]) {
        [self.alertViewDelegate alertController:self clickButtonAtIndex:buttonIndex title:title];
    }
}

- (void)show {
    [[UIViewController currentViewController] presentViewController:self animated:YES completion:nil];
}

@end


@implementation UIViewController (AlertView)

+ (instancetype)currentViewController {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

@end


