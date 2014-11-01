#import <UIKit/UIKit.h>

@interface SIMCreditCardResponseInformationView : UIView

- (id)initWithFrame:(CGRect)frame creditCardResponse:(NSDictionary *)creditCardResponse;

@property (nonatomic, strong) NSDictionary *cardResponse;

@end
