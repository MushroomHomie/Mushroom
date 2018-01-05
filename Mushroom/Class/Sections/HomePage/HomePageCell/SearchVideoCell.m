//
//  SearchVideoCell.m
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/5.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "SearchVideoCell.h"

@interface SearchVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoAuthor;
@property (weak, nonatomic) IBOutlet UILabel *videoDate;

@end

@implementation SearchVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
