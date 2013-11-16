//
//  FailedLoadingView.m
// 
//
//  Created by Ben Gordon on 4/3/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "HelperView.h"

@implementation HelperView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(void)launchHelperViewInView:(UIView *)view {
    if (![HelperView isFailedLoadingInView:view]) {
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"HelperView" owner:nil options:nil];
        HelperView *failedLoadingView = [[HelperView alloc] init];
        failedLoadingView = [views objectAtIndex:0];
        
        // Add fLV to View
        failedLoadingView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - failedLoadingView.frame.size.width/2, -1*failedLoadingView.frame.size.height, failedLoadingView.frame.size.width, failedLoadingView.frame.size.height);
        [view addSubview:failedLoadingView];
        
        // Animate
        [HelperView animateFailedLoading:failedLoadingView duration:2.5];
    }
}

+(void)launchHelperViewInView:(UIView *)view withImage:(UIImage *)image text:(NSString *)text duration:(float)time {
    if (![HelperView isFailedLoadingInView:view]) {
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"HelperView" owner:nil options:nil];
        HelperView *failedLoadingView = [[HelperView alloc] init];
        failedLoadingView = [views objectAtIndex:0];
        
        // Add data
        failedLoadingView.HelperImage.image = image;
        failedLoadingView.HelperText.text = text;
        
        // Add fLV to View
        failedLoadingView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - failedLoadingView.frame.size.width/2, -1*failedLoadingView.frame.size.height, failedLoadingView.frame.size.width, failedLoadingView.frame.size.height);
        [view addSubview:failedLoadingView];
        
        // Animate
        [HelperView animateFailedLoading:failedLoadingView duration:time];
    }
}

+(void)animateFailedLoading:(HelperView *)failedLoadingView duration:(float)duration {
    // Sequence Animation:
    // 1. Add view to top of Frame
    // 2. Animate to middle - hold for duration (3.5s)
    // 3. Bounce downward like a rubber band
    // 4. Launch to off-screen at top of frame
    
    [UIView animateWithDuration:0.25 animations:^{
        failedLoadingView.frame = CGRectMake(failedLoadingView.frame.origin.x, [UIScreen mainScreen].bounds.size.height/2 - failedLoadingView.frame.size.height/2, failedLoadingView.frame.size.width, failedLoadingView.frame.size.height);
    } completion:^(BOOL fin){
        [UIView animateWithDuration:duration animations:^{
            // Hold for 2.5 seconds
            failedLoadingView.frame = CGRectMake(failedLoadingView.frame.origin.x, failedLoadingView.frame.origin.y - 0.1, failedLoadingView.frame.size.width, failedLoadingView.frame.size.height);
        } completion:^(BOOL fin){
            [UIView animateWithDuration:0.13 animations:^{
                failedLoadingView.center = CGPointMake(failedLoadingView.center.x, failedLoadingView.center.y + 35);
            } completion:^(BOOL fin){
                [UIView animateWithDuration:0.25 animations:^{
                    failedLoadingView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - failedLoadingView.frame.size.width/2, -1*failedLoadingView.frame.size.height, failedLoadingView.frame.size.width, failedLoadingView.frame.size.height);
                } completion:^(BOOL fin){
                    [failedLoadingView removeFromSuperview];
                }];
            }];
        }];
    }];
}

+(BOOL)isFailedLoadingInView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[HelperView class]]) {
            return YES;
        }
    }
    
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
