//
//  DTAListCell.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 8/11/14.
//
//

#import "DTAListCell.h"

@implementation DTAListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    self.listLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.listLabel.frame);
}

@end
