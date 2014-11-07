//
//  GesturePasswordController.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>

#import "GesturePasswordController.h"


#import "KeychainItemWrapper/KeychainItemWrapper.h"

@interface GesturePasswordController ()

@property (nonatomic,strong) GesturePasswordView * gesturePasswordView;

@end

@implementation GesturePasswordController {
    NSString * previousString;
    NSString * password;
    UIView* showView;
    BOOL _isModify;
}

@synthesize gesturePasswordView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        gesturePasswordView = nil;
        showView = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isModify = NO;
    previousString = [NSString string];
    self.navigationItem.title = @"设置手势密码";
    password = [ManagerUser shareInstance].gesturePsw;

    if ([password isEqualToString:@""] || ![ManagerUser shareInstance].isGesturePsw) {
        
        [self reset];
        self.navigationItem.title = @"设置手势密码";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    }
    else {
        [self verify];
        self.navigationItem.title = @"验证手势密码";
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancel
{
    if ([[ManagerUser shareInstance].gesturePsw isEqualToString:@""]) {
        [ManagerUser shareInstance].isGesturePsw = NO;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 验证手势密码
- (void)verify{
    if(gesturePasswordView.superview)
    {
        [gesturePasswordView removeFromSuperview];
        gesturePasswordView = nil;
    }
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [self.view addSubview:gesturePasswordView];
}

#pragma mark - 上面的表示图案
-(void)drawShowView{
    showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    showView.backgroundColor = [UIColor clearColor];
    for(int i = 0; i < 9; i++){
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(i%3*15, i/3*15, 10, 10)];
        view.backgroundColor = [UIColor blackColor];
        view.layer.cornerRadius = 5.0;
        view.layer.masksToBounds = YES;
        view.tag = i+1;
        [showView addSubview:view];
    }
    showView.center = CGPointMake(165, 120);
    [self.view addSubview:showView];
}
-(void)drawShowViewWithResult:(NSString*)resultStr{
    for(int i = 0; i < resultStr.length; i++){
        NSInteger tag = [resultStr characterAtIndex:i]-48+1;
        [showView viewWithTag:tag].backgroundColor = [UIColor orangeColor];
    }
}
#pragma mark - 重置手势密码
- (void)reset{

    [ManagerUser shareInstance].gesturePsw = @"";
    if(gesturePasswordView.superview)
    {
        [gesturePasswordView removeFromSuperview];
        gesturePasswordView = nil;
    }
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
//    [gesturePasswordView.imgView setHidden:YES];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
    [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
    [gesturePasswordView.state setText:@"绘制解锁图案"];
    [self.view addSubview:gesturePasswordView];
    [self drawShowView];
}

#pragma mark - 判断是否已存在手势密码
- (BOOL)exist{
    password = [ManagerUser shareInstance].gesturePsw;
    if ([password isEqualToString:@""])return NO;
    return YES;
}

#pragma mark - 清空记录
- (void)clear{
    [ManagerUser shareInstance].gesturePsw = @"";
}

#pragma mark - 改变手势密码
- (void)change{
    _isModify = YES;
    [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
    [gesturePasswordView.state setText:@"先确认密码再修改"];
}

#pragma mark - 忘记手势密码
- (void)forget{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"忘记手势密码需要重新登录设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    [ManagerUtil presentLoginView];
//    [self reset];
}
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [ManagerUser shareInstance].isLogin = false;
        [ManagerUser shareInstance].isGesturePsw = false;
        [ManagerUser shareInstance].gesturePsw = @"";
        [self dismissViewControllerAnimated:NO completion:^{
            [[ManagerUtil getCurrentRootViewController].navigationController popToRootViewControllerAnimated:NO];
            [ManagerUtil presentLoginView];
        }];
        
    }
}

- (BOOL)verification:(NSString *)result{
    if ([result isEqualToString:password]) {
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"输入正确"];
        if (_isModify) {
            [self reset];
        }else{
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }

        //[self presentViewController:(UIViewController) animated:YES completion:nil];
        return YES;
    }
    [gesturePasswordView.state setTextColor:[UIColor redColor]];
    [gesturePasswordView.state setText:@"手势密码错误"];
    return NO;
}

- (BOOL)resetPassword:(NSString *)result{
    if ([previousString isEqualToString:@""]) {
        previousString=result;
        [gesturePasswordView.tentacleView enterArgin];
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"请验证输入密码"];
        [self drawShowViewWithResult:result];
        return YES;
    }
    else {
        if ([result isEqualToString:previousString]) {
            [ManagerUser shareInstance].gesturePsw = result;
            //[self presentViewController:(UIViewController) animated:YES completion:nil];
            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
            [gesturePasswordView.state setText:@"已保存手势密码"];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            return YES;
        }
        else{
            previousString =@"";
            [gesturePasswordView.state setTextColor:[UIColor redColor]];
            [gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
            return NO;
        }
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
