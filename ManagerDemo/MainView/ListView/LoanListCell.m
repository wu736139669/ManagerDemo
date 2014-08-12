//
//  LoanListCell.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "LoanListCell.h"

@implementation LoanListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0),
//                   dispatch_get_main_queue(), ^(){
//                       [self initView];
//                   });
    [self initView];
}
-(void)initView
{
    _percentView.wrapperColor = [UIColor clearColor];
    _percentView.progressColor = [UIColor redColor];
    _percentDtlabel.backgroundColor = [UIColor clearColor];
}
-(void)setPercent:(NSInteger) percent
{
    NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\"font-size:20px; color:red; text-align:center; \">%ld</span> %%",percent];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentCenter],DTDefaultTextAlignment, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _percentDtlabel.attributedString = percentString;
    [_percentView setProgress:percent/100.0 animated:NO];
}
-(void)setTimeWithString:(NSString*)htmlString
{
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentCenter],DTDefaultTextAlignment, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _timeDtLabel.attributedString = percentString;
}
@end
