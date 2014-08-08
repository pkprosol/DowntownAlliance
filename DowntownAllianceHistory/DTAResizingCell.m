//
//  DTAResizingCell.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 8/8/14.
//
//

#import "DTAResizingCell.h"

@implementation DTAResizingCell

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
    self.lineLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.lineLabel.frame);
}

@end
