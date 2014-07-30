//
//  DTADecadeCell.m
//  DowntownAllianceHistory
//
//  Created by Viktor Falkner on 7/30/14.
//
//

#import "DTADecadeCell.h"

@implementation DTADecadeCell

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
    self.decadeCellImageView.contentMode = UIViewContentModeScaleAspectFill;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
