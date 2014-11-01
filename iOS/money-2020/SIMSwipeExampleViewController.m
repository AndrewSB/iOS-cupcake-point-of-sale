#import "SIMSwipeExampleViewController.h"
#import "SIMCreditCardResponseInformationView.h"
#import <Simplify/SIMSwipeViewController.h>

#define SIMSwipeExampleViewControllerButtonText @"Launch Swipe Controller"

@interface SIMSwipeExampleViewController () <UIViewControllerTransitioningDelegate, SIMSwipeViewControllerDelegate>
@property (nonatomic, strong) UIButton *swipeControllerButton;
@property (nonatomic) SIMCreditCardResponseInformationView *infoView;
@property (nonatomic, strong) SIMSwipeViewController *swipeViewController;
@property (nonatomic, strong) SIMSwipeTransitionController *transitionController;
@end

@implementation SIMSwipeExampleViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"Swipe View Example";
        self.transitionController = [[SIMSwipeTransitionController alloc] init];

    }
    return self;
}

-(void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    CGSize buttonSize = CGSizeMake(CGRectGetWidth(self.view.bounds) - 40.0, 40.0);
    CGRect buttonFrame = CGRectMake(CGRectGetMidX(self.view.bounds) - buttonSize.width / 2, 50.0, buttonSize.width, buttonSize.height);

    UIButton *swipeControllerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    swipeControllerButton.frame = buttonFrame;
    swipeControllerButton.backgroundColor = [UIColor grayColor];
    swipeControllerButton.titleLabel.textColor = [UIColor whiteColor];
    swipeControllerButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [swipeControllerButton setTitle:SIMSwipeExampleViewControllerButtonText forState:UIControlStateNormal];
    [swipeControllerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [swipeControllerButton addTarget:self action:@selector(displaySwipeViewController) forControlEvents:UIControlEventTouchUpInside];
    swipeControllerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    swipeControllerButton.clipsToBounds = YES;
    swipeControllerButton.layer.cornerRadius = 4.0f;
    self.swipeControllerButton = swipeControllerButton;
    
    CGFloat startY = CGRectGetMaxY(self.swipeControllerButton.frame) + 20.0;
    CGRect infoFrame = CGRectMake(20, startY, CGRectGetWidth(self.view.bounds) - 40, CGRectGetHeight(self.view.bounds) - startY - 80);

    self.infoView = [[SIMCreditCardResponseInformationView alloc] initWithFrame:CGRectInset(infoFrame, 10.0, 0.0) creditCardResponse:nil];
    self.infoView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:swipeControllerButton];
    [self.view addSubview:self.infoView];

    SIMSwipeViewController *swipeViewController = [[SIMSwipeViewController alloc] init];
    swipeViewController.transitioningDelegate = self;
    swipeViewController.delegate = self;
    
    self.swipeViewController = swipeViewController;

}

-(void)displaySwipeViewController {
    [self presentViewController:self.swipeViewController animated:YES completion:nil];
}

//If you'd like a nice animation and overlay, implement the SIMTransitionDelegate callbacks.
#pragma mark UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    self.transitionController.reverse = NO;
    return self.transitionController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    self.transitionController.reverse = YES;
    return self.transitionController;
}


//Process the card response information.
#pragma mark SIMSwipeViewControllerDelegate Methods

-(void)onSwipeSuccess:(NSDictionary *)cardResponse {
    
    self.infoView.cardResponse = cardResponse;
    
}

@end
