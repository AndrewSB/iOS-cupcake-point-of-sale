#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define SIMCardReaderAdapterErrorKey @"ReaderError"

#define SIMCardReaderMagtekUDynamoNotifcationTrackDataReady @"trackDataReadyNotification"
#define SIMCardReaderMagtekUDynamoNotifcationConnection @"devConnectionNotification"

#define SIMCardReaderDataKeyDeviceSerial @"deviceSerial"
#define SIMCardReaderDataKeyCardholderName @"cardholderName"
#define SIMCardReaderDataKeyCardholderNameArray @"cardholderNameArray"
#define SIMCardReaderDataKeyCardholderFirstName @"cardholderFirstName"
#define SIMCardReaderDataKeyCardholderLastName @"cardholderLastName"
#define SIMCardReaderDataKeyCardIIN @"cardIIN"
#define SIMCardReaderDataKeyCardLast4 @"cardLast4"
#define SIMCardReaderDataKeyCardExpDate @"cardExpDate"
#define SIMCardReaderDataKeyCardExpMonth @"cardExpMonth"
#define SIMCardReaderDataKeyCardExpYear @"cardExpYear"

#define SIMCardReaderDataKeyTrack1Data @"track1Data"
#define SIMCardReaderDataKeyTrack2Data @"track2Data"
#define SIMCardReaderDataKeyCardServiceCode @"cardServiceCode"
#define SIMCardReaderDataKeyKSN @"cardKSN"
#define SIMCardReaderDataKeyCardPANLength @"cardPanLength"
#define SIMCardReaderDataKeyCardType @"cardType"
#define SIMCardReaderDataKeyCardTypeImage @"cardTypeImage"

typedef enum {
    SIMCardReaderAdapterTypeNone,
    SIMCardReaderAdapterTypeMagtekUDynamo
} SIMCardReaderAdapterType;


typedef enum {
    SIMCardReaderAdapterErrorCodeTrackError,
    SIMCardReaderAdapterErrorCodeTransferError
} SIMCardReaderAdapterErrorCode;

@protocol SIMCardReaderAdapterDelegate

-(void)onConnect;
-(void)onDisconnect;
-(void)onActivate;
-(void)onDeactivate;
-(void)onSwipeSuccess:(NSDictionary *)cardResponse;
-(void)onSwipeError:(NSError *)error;

@end

@interface SIMCardReaderAdapter : NSObject

@property (nonatomic, weak) id<SIMCardReaderAdapterDelegate> delegate;
@property (nonatomic, readonly) BOOL isConnected;
@property (nonatomic, readonly) BOOL isActive;
@property (nonatomic, readonly) SIMCardReaderAdapterType cardReaderType;

-(instancetype)initWithCardReaderType:(SIMCardReaderAdapterType)cardReaderType;
-(void)deactivate;
-(void)activate;

@end
