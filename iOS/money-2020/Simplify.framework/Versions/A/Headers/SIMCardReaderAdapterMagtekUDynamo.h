#import "SIMCardReaderAdapter.h"


@interface SIMCardReaderAdapterMagtekUDynamo : NSObject

@property (nonatomic, weak) id<SIMCardReaderAdapterDelegate> delegate;
@property (nonatomic, readonly) BOOL isActive;

-(void)deactivate;
-(void)activate;

@end
