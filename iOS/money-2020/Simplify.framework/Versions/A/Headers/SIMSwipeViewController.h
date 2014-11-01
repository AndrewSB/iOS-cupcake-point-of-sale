#import "SIMSwipeTransitionController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

@protocol SIMSwipeViewControllerDelegate <NSObject>

-(void)onSwipeSuccess:(NSDictionary *)cardResponse;

@end

@interface SIMSwipeViewController : UIViewController

@property (nonatomic) id<SIMSwipeViewControllerDelegate> delegate;

@end
