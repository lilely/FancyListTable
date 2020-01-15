//
//  FancyListTableAdapter_internal.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import "FancyListTableDataCenter.h"
#import "FancyListTableWorkingRangeHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface FancyListTableAdapter()

@property (nonatomic) FancyListTableDataCenter *dataCenter;

@property (nonatomic, nullable) FancyListTableDataCenter *updatingPreDataCenter;

@property (nonatomic) NSMutableSet<Class> *registeredCellClasses;

@property (nonatomic) FancyListTableWorkingRangeHelper *workingRangeHandler;

- (NSInteger)indexOfSliceController:(FancyListTableSliceController *)sectionController;

@end

NS_ASSUME_NONNULL_END
