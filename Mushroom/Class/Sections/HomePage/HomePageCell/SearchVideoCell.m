//
//  SearchVideoCell.m
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/5.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "SearchVideoCell.h"
#import "SearchResultCellVM.h"
#import "SearchResultModel.h"
#import "HomePageArtistsModel.h"
@interface SearchVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoAuthor;
@property (weak, nonatomic) IBOutlet UILabel *videoDate;

@property (nonatomic, strong) SearchResultCellVM *viewModel;

@end

@implementation SearchVideoCell

+ (instancetype)cellWithTable:(UITableView *)tableView
                 andIndexPath:(NSIndexPath *)indexPath
                 andViewModel:(BaseTableViewCellVM *)viewModel
{
    NSString *identify = NSStringFromClass([self class]);

    SearchVideoCell *cell  = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:identify bundle:nil]
        forCellReuseIdentifier:identify];
        
        cell = [tableView dequeueReusableCellWithIdentifier:identify];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.viewModel = (SearchResultCellVM *)viewModel;
    [cell initData];
    
    return cell;
}

- (void)initData
{
    SearchResultModel *model = [self.viewModel getData];
    _videoTitle.text = model.title;
    _videoDate.text = model.regdate;
    
    NSString *authors = @"";
    for (HomePageArtistsModel *authorModel in model.artists)
    {
        if (authors.length > 0) {
            authors = [authors stringByAppendingString:[NSString stringWithFormat:@"&%@",authorModel.artistName]];
        }
        else
        {
            authors = authorModel.artistName;
        }
    }
    
    _videoAuthor.text = authors;
    
    NSURL *url = [NSURL URLWithString:model.albumImg];
    [_videoImage sd_setImageWithURL:url];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
