//
//  FancyListTableController.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import <UIKit/UIKit.h>
#import "FancyListTableAdapterDelegate.h"
#import "FancyListTableAdapterDataSource.h"
#import "FancyListTableAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface FancyListTableController : UIViewController
<FancyListTableAdapterDelegate,
FancyListTableAdapterDataSource, UIScrollViewDelegate>

@property (nonatomic, strong,readonly) FancyListTableAdapter *adapter;

@end

NS_ASSUME_NONNULL_END
