//
//  ArrayDataSource.m
//  DataSourceTableViewTest
//
//  Created by 劉光軍 on 16/4/8.
//  Copyright © 2016年 劉光軍. All rights reserved.
//

#import "ArrayDataSource.h"

@interface ArrayDataSource()
@property(nonatomic, strong) NSArray* items;/**< array */
@property(nonatomic, strong) NSArray* cellIdentifier;/**< cellIdentifier */
@end

@implementation ArrayDataSourceSectionModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"DataSourceModel":[ArrayDataSourceModel class]};
    
}

@end
@implementation ArrayDataSourceModel


@end

@interface ArrayDataSource ()
@property(nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;/**< block */


@end

@implementation ArrayDataSource


- (instancetype)init {
    return  nil;
}

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSArray *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return  self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.section][indexPath.row];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return [self.items count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.items count]>0) {
       return [self.items[section] count];
    }
    return 0;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArrayDataSourceSectionModel*Model=self.cellIdentifier[indexPath.section];
    ArrayDataSourceModel*model1=Model.DataSourceModel[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model1.CellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item,indexPath.row);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArrayDataSourceSectionModel*Model=self.cellIdentifier[indexPath.section];
    ArrayDataSourceModel*model1=Model.DataSourceModel[indexPath.row];
    return model1.rowHeight;
}

@end
