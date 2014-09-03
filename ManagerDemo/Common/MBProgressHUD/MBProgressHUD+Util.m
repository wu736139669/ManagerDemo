
#import "MBProgressHUD+Util.h"

static MBProgressHUD *activityHUD = nil;
@implementation MBProgressHUD(Util)




+ (void)hudWithView:(UIView *)view label:(NSString *)msg
{
    if (view == nil)
    {
        view = [UIApplication sharedApplication].delegate.window;
    }
    
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];

    HUD.dimBackground = NO;
    HUD.animationType = MBProgressHUDAnimationFade;
    [view addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = msg;
    [HUD show:YES];
    activityHUD = HUD;
}

+ (void)errorHudWithView:(UIView *)view label:(NSString *)msg hidesAfter:(NSTimeInterval)delay
{
    if (view == nil)
    {
        view = [UIApplication sharedApplication].delegate.window;
    }
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.dimBackground = NO;
    HUD.animationType = MBProgressHUDAnimationFade;
    [view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_dock_forum"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}

+ (void)checkHudWithView:(UIView *)view label:(NSString *)msg hidesAfter:(NSTimeInterval)delay
{
    if (view == nil)
    {
        view = [UIApplication sharedApplication].delegate.window;
    }
    
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    
    HUD.dimBackground = NO;
    HUD.animationType = MBProgressHUDAnimationFade;
    [view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_success"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}
@end