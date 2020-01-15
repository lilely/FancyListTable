//
//  FancyListTableSectionDataCenter.m
//  gifFeedBaseModule
//
//  Created by Stanley on 2019/1/15.
//

#import "FancyListTableDataCenter.h"
#import "FancyListTableSliceController.h"

@interface FancyListTableDataCenter()

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, FancyListTableSliceController *>* sectionMap;

@property (nonatomic, strong, readwrite) NSArray *mObjects;

@end

@implementation FancyListTableDataCenter

- (instancetype)initWithMapTable:(NSMapTable *)mapTable {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setObjects:(NSArray * _Nonnull)objects forSections:(NSMutableArray <FancyListTableSliceController *>*)sections {
    if (!objects) {
        return;
    }
    self.mObjects = [objects copy];
}

- (void)reset {
    self.mObjects = nil;
    [self.sectionMap removeAllObjects];
}

- (void)setSectionController:(FancyListTableSliceController *)sectionController forIndex:(NSInteger)index {
    [self.sectionMap setObject:sectionController forKey:@(index)];
}

- (FancyListTableSliceController *)sectionControllerForIndex:(NSInteger)index {
    return [self.sectionMap objectForKey:@(index)];
}

- (NSInteger)indexOfSliceController:(FancyListTableSliceController *)Controller {
    return Controller.index;
}

#pragma mark - Getter

- (NSMutableDictionary *)sectionMap {
    if (!_sectionMap) {
        _sectionMap = [[NSMutableDictionary alloc] init];
    }
    return _sectionMap;
}

- (NSArray *)objects {
    return [self.mObjects copy];
}

@end
