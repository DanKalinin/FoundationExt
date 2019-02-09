//
//  NSERPC.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/9/19.
//

#import "NSEOperation.h"



@protocol NSERPCDelegate <NSEOperationDelegate>

@end



@interface NSERPC : NSEOperation <NSERPCDelegate>

@end
