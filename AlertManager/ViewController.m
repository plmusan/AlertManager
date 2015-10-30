//
//  ViewController.m
//  AlertManager
//
//  Created by x.wang on 15/10/28.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+AlertView.h"
#import "NSNull+NSNumber.h"

@interface ViewController ()

@property (nonatomic) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [NSNull null].boolValue ? NSLog(@"YES") : NSLog(@"NO");
    self.button = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 180, 55)];
        button.backgroundColor = [UIColor yellowColor];
        [button setTitle:@"show alert" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
}

- (IBAction)buttonPressed:(UIButton *)sender {
//    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Alert" message:@"show something with alert" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"Cancle" destructiveButtonTitle:nil otherButtonTitles:@"OK", nil];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Alert" message:@"msg" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"%s", __FUNCTION__);
    }];
//    controller.alertResult = ^(NSString *clickButtonTitle, NSInteger clickButtonIndex) {
//        NSLog(@"click '%@' button at index: %@", clickButtonTitle, @(clickButtonIndex));
//    };
    [controller addAction:action];
    [controller show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
