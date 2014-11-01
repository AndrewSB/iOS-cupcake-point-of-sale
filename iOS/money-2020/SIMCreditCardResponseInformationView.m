#import "SIMCreditCardResponseInformationView.h"
#import <Simplify/SIMCardReaderAdapter.h>

#define SIMCreditCardResponseInformationViewYOffset 6.0

@interface SIMCreditCardResponseInformationView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *cardholderLabel;
@property (nonatomic, strong) UILabel *iinLabel;
@property (nonatomic, strong) UILabel *expAndLast4Label;
@property (nonatomic, strong) UIImageView *cardTypeImage;

@end

@implementation SIMCreditCardResponseInformationView

- (id)initWithFrame:(CGRect)frame creditCardResponse:(NSDictionary *)creditCardResponse {
	if (self = [super initWithFrame:frame]) {
		
        self.cardResponse = creditCardResponse;
        
        CGFloat yOffset = 0.0;
		UILabel *titleLabel = [self createLabelWithSize:26.0f yOffset:yOffset];
        titleLabel.text = @"Card Information";
		[self addSubview:titleLabel];
		yOffset = CGRectGetMaxY(titleLabel.frame) + SIMCreditCardResponseInformationViewYOffset;
        self.titleLabel = titleLabel;

		UILabel *cardholderLabel = [self createLabelWithSize:14.0f yOffset:yOffset];
		[self addSubview:cardholderLabel];
		yOffset = CGRectGetMaxY(cardholderLabel.frame) + SIMCreditCardResponseInformationViewYOffset;
        self.cardholderLabel = cardholderLabel;

		UILabel *iinLabel = [self createLabelWithSize:14.0f yOffset:yOffset];
		[self addSubview:iinLabel];
		yOffset = CGRectGetMaxY(iinLabel.frame) + SIMCreditCardResponseInformationViewYOffset;
        self.iinLabel = iinLabel;

		UILabel *expAndLast4Label = [self createLabelWithSize:14.0f yOffset:yOffset];
		[self addSubview:expAndLast4Label];
		yOffset = CGRectGetMaxY(expAndLast4Label.frame) + SIMCreditCardResponseInformationViewYOffset;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        self.expAndLast4Label = expAndLast4Label;
        
        CGRect cardTypeFrame = CGRectMake(10, yOffset, 40, 25);
        
        UIImageView *cardTypeImage = [[UIImageView alloc] initWithFrame:cardTypeFrame];
        [self addSubview:cardTypeImage];
        yOffset = CGRectGetMaxY(cardTypeFrame) + SIMCreditCardResponseInformationViewYOffset;
        self.cardTypeImage = cardTypeImage;

	}
	return self;
}

- (UILabel *)createLabelWithSize:(CGFloat)size yOffset:(CGFloat)yOffset {
	UILabel* label = [[UILabel alloc] init];
	label.font = [UIFont boldSystemFontOfSize:size];
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = UIColor.clearColor;
    label.text = @" ";
	[label sizeToFit];
	label.frame = CGRectMake(10, yOffset, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(label.frame));
	return label;
}

-(void)setCardResponse:(NSDictionary *)cardResponse {
    if (_cardResponse != cardResponse) {
        _cardResponse = cardResponse;
        
        self.titleLabel.text = @"Card Information";
        self.cardholderLabel.text = [NSString stringWithFormat:@"Cardholder Name: %@ %@", cardResponse[SIMCardReaderDataKeyCardholderFirstName], cardResponse[SIMCardReaderDataKeyCardholderLastName]];
        self.iinLabel.text = [NSString stringWithFormat:@"IIN: %@", cardResponse[SIMCardReaderDataKeyCardIIN]];
        self.expAndLast4Label.text = [NSString stringWithFormat:@"Exp: %@/%@\t\tLast4: %@",cardResponse[SIMCardReaderDataKeyCardExpMonth], cardResponse[SIMCardReaderDataKeyCardExpYear], cardResponse[SIMCardReaderDataKeyCardLast4]];
        [self.cardTypeImage setImage:cardResponse[SIMCardReaderDataKeyCardTypeImage]];
        [self layoutSubviews];
    }
}

@end
