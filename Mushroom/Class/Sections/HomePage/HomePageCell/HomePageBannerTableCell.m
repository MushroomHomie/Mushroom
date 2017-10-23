//
//  HomePageBannerTableCell.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageBannerTableCell.h"

@implementation HomePageBannerTableCell

+ (instancetype)cellWithTable:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = NSStringFromClass([self class]);
    NSString *cellName = [NSString stringWithFormat:@"%@%ld%ld",identify,indexPath.section,indexPath.row];
    
    HomePageBannerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[HomePageBannerTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellName
                                                 andindexPath:indexPath];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                 andindexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initView:indexPath];
    }
    return self;
}

- (void)initView:(NSIndexPath *)indexPath
{
    
}

@end
