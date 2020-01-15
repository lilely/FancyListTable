//
//  FancyListTableSectionController.h
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import "FancyListTableSliceController.h"
#import "FancyListTableAdapterContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface FancyListTableSectionController : FancyListTableSliceController

@property (nonatomic, strong, readonly) NSArray<FancyListTableSliceController *>* sliceControllers;

- (instancetype)initWithSliceControllers:(NSArray <FancyListTableSliceController *>*)sliceControllers;

- (FancyListTableSliceController *)segmentCoumponentOfIndex:(NSInteger)index;

- (NSIndexSet *)itemIndexesForSectionController:(FancyListTableSliceController *)sliceController indexes:(NSIndexSet *)indexes;

@end

NS_ASSUME_NONNULL_END
