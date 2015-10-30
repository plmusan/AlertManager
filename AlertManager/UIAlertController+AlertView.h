//
//  UIAlertController+AlertView.h
//  Alert
//
//  Created by x.wang on 15/8/13.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIAlertControllerAlertViewDelegate <NSObject>
@optional
- (void)alertController:(UIAlertController *)alert clickButtonAtIndex:(NSInteger)clickButtonIndex title:(NSString *)buttonTitle;
@end

typedef void (^UIAlertControllerAlertViewResult)(NSString *clickButtonTitle, NSInteger clickButtonIndex);

@interface UIAlertController (AlertView)

/*!
 *  @author x.wang, 08-13
 *
 *  该方法首先调用[UIAlertController alertControllerWithTitle:message:preferredStyle:]生成Alert对象，
 *  然后根据传入的cancelButtonTitle、destructiveButtonTitle和otherButtonTitles
 *  参数创建对应类型的Action并添加到Alert中。
 *
 *  通过设置alertViewDelegate属性或调用[UIAlertController setAlertViewResult:]方法获取响应。
 *
 *  注：仅且使用此方法初始化的UIAlertController对象可以设置delegate和alertResult。
 *
 *  @param title       Alert的标题。
 *  @param message     描述Alert原因的细节。
 *  @param style     显示Alert时使用的样式。
 *  @param cancel      若不为nil，则添加UIAlertActionStyleCancel类型的Action
 *  @param destructive 若不为nil，则添加UIAlertActionStyleDestructive类型的Action
 *  @param others...      若不为nil，则添加UIAlertActionStyleDefault类型的Action，添加的顺序为传入字符串的顺序
 *
 *   此处有一个BUG。可变参数列表在编译时不做类型检查，当传入非NSString对象后运行时会崩掉。
 *
 *  @return 实例化完成的UIAlertController对象，可直接用于显示。
 */
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message
                          preferredStyle:(UIAlertControllerStyle)style cancelButtonTitle:(NSString *)cancel
                  destructiveButtonTitle:(NSString *)destructive otherButtonTitles:(NSString *)others, ... NS_REQUIRES_NIL_TERMINATION;

@property (nonatomic, assign, readonly) BOOL canSetDelegateOrBlock;
@property (nonatomic, assign) id<UIAlertControllerAlertViewDelegate> alertViewDelegate;
@property (nonatomic, copy) UIAlertControllerAlertViewResult alertResult;

- (void)show;

@end

@interface UIViewController (AlertView)

+ (instancetype)currentViewController;

@end

