#import "SIMDelegateExampleViewController.h"
#import "SIMCreditCardResponseInformationView.h"
#import <Simplify/SIMCardReaderAdapter.h>

@interface SIMDelegateExampleViewController () <SIMCardReaderAdapterDelegate>
@property (strong, nonatomic) SIMCardReaderAdapter *cardReader;

@property (strong, nonatomic) UILabel *swipeLabel;
@property (nonatomic) SIMCreditCardResponseInformationView *infoView;
@end

@implementation SIMDelegateExampleViewController


-(instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"Delegate Example";
    }
    return self;
}

-(void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    CGSize labelSize = CGSizeMake(CGRectGetWidth(self.view.bounds) - 40.0, 40.0);
    CGRect labelFrame = CGRectMake(CGRectGetMidX(self.view.bounds) - labelSize.width / 2, 50.0, labelSize.width, labelSize.height);
    
    UILabel *swipeLabel = [[UILabel alloc] initWithFrame:labelFrame];
    swipeLabel.backgroundColor = [UIColor grayColor];
    swipeLabel.textColor = [UIColor whiteColor];
    swipeLabel.font = [UIFont systemFontOfSize:18.0f];
    swipeLabel.text = @"Please swipe card";
    swipeLabel.textAlignment = NSTextAlignmentCenter;
    swipeLabel.clipsToBounds = YES;
    swipeLabel.layer.cornerRadius = 4.0f;
    self.swipeLabel = swipeLabel;

    CGFloat startY = CGRectGetMaxY(self.swipeLabel.frame) + 20.0;
    CGRect infoFrame = CGRectMake(20, startY, CGRectGetWidth(self.view.bounds) - 40, CGRectGetHeight(self.view.bounds) - startY - 80);
    
    self.infoView = [[SIMCreditCardResponseInformationView alloc] initWithFrame:CGRectInset(infoFrame, 10.0, 0.0) creditCardResponse:nil];
    self.infoView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.infoView];
    [self.view addSubview:self.swipeLabel];

}

-(void)setupCardReader {
    
    SIMCardReaderAdapterType cardReaderType = SIMCardReaderAdapterTypeMagtekUDynamo;
    
    self.cardReader = [[SIMCardReaderAdapter alloc] initWithCardReaderType:cardReaderType];
    self.cardReader.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupCardReader];
    [self.cardReader activate];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.cardReader.delegate = nil;
    [self.cardReader deactivate];
    self.cardReader = nil;
}

#pragma mark SIMCardReaderAdapterDelegate Methods

-(void)onConnect {
    //Perform whatever you'd like when the Reader is connected
    self.infoView.cardResponse = @{SIMCardReaderDataKeyCardholderName:@"Reader Connected"};
}

-(void)onDisconnect {
    //Perform whatever you'd like when the Reader is disconnected
    self.infoView.cardResponse = @{SIMCardReaderDataKeyCardholderName:@"Reader Disconnected"};
}

-(void)onActivate {
    //Perform whatever you'd like when the Reader is activated
    self.infoView.cardResponse = @{SIMCardReaderDataKeyCardholderName:@"Reader Active"};
}

-(void)onDeactivate {
    //Perform whatever you'd like when the Reader is deactivated
    self.infoView.cardResponse = @{SIMCardReaderDataKeyCardholderName:@"Reader Inactive"};
    
}

-(void)onSwipeError:(NSError *)error {
    
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    CGPoint buttonCenter = self.swipeLabel.center;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:5];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint: CGPointMake(buttonCenter.x - 5, buttonCenter.y)]];
    [shake setToValue:[NSValue valueWithCGPoint: CGPointMake(buttonCenter.x + 5, buttonCenter.y)]];
    [self.swipeLabel.layer addAnimation:shake forKey:@"position"];
    
    [UIView animateWithDuration:0.5f animations:^{
        self.view.backgroundColor = [UIColor redColor];
        self.swipeLabel.text = @"Please try again";
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5f animations:^{
            self.view.backgroundColor = [UIColor orangeColor];
            self.swipeLabel.text = @"Please swipe card";
            self.infoView.cardResponse = @{SIMCardReaderDataKeyCardholderFirstName:@"Bad Swipe"};
            
        }];
        
    }];
    
}

-(void)onSwipeSuccess:(NSDictionary *)cardResponse {
    
    self.infoView.cardResponse = cardResponse;
}

@end
