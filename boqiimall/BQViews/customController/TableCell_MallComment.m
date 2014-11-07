//
//  TableCell_MallComment.m
//  boqiimall
//
//  Created by YSW on 14-7-15.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "TableCell_MallComment.h"

#define tag_score 100

@implementation TableCell_MallComment
@synthesize commentDelegate;
@synthesize productIMG;
@synthesize lbl_score;
@synthesize lbl_fhsd;
@synthesize lbl_fwmyd;
@synthesize lbl_mjpf;
@synthesize lbl_spms;
@synthesize lbl_ProductTitle;
@synthesize lbl_ProductPrice;
@synthesize lbl_ProductMarketPrice;
@synthesize lbl_marketLine;

@synthesize txt_Content;
@synthesize txtViewPlaceHold;

@synthesize iscore_fhsd;
@synthesize iscore_fwmyd;
@synthesize iscore_spms;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib{
    productIMG.layer.borderWidth = 1.0f;
    productIMG.layer.borderColor = color_d1d1d1.CGColor;
    
    [lbl_ProductTitle setFont:defFont15];
    [lbl_ProductTitle setTextColor:color_333333];
    [lbl_ProductPrice setTextColor:color_fc4a00];
    [lbl_ProductPrice setFont:defFont(YES, 17)];
    
    
    [lbl_ProductMarketPrice setTextColor:color_989898];
    lbl_marketLine = [[UILabel alloc] initWithFrame:CGRectMake(lbl_ProductMarketPrice.frame.origin.x-3, lbl_ProductMarketPrice.frame.origin.y+10, 55, 1)];
    [lbl_marketLine setBackgroundColor:color_989898];
    [self.contentView addSubview:lbl_marketLine];
    
    
    [txt_Content setBackgroundColor:[UIColor clearColor]];
    txt_Content.layer.borderColor = color_ededed.CGColor;
    txt_Content.layer.borderWidth = 1.0f;
    txt_Content.delegate = self;
    [txt_Content setTextColor:color_989898];
    
    [txtViewPlaceHold setFrame:CGRectMake(txt_Content.frame.origin.x+5, txt_Content.frame.origin.y+5, txt_Content.frame.size.width-10, txt_Content.frame.size.height-10)];
    [txtViewPlaceHold setBackgroundColor:[UIColor whiteColor]];
    [txtViewPlaceHold setPlaceholder:@"写点评论吧，对其他宠物主帮助很大哦！"];
    [txtViewPlaceHold setTextColor:color_989898];
    [txtViewPlaceHold setFont:defFont14];
    
    
    [UICommon Common_line:CGRectMake(txt_Content.frame.origin.x, lbl_spms.frame.origin.y-6, txt_Content.frame.size.width, 1) targetView:self.contentView backColor:color_ededed];
    
    
    [lbl_mjpf setTextColor: color_989898];
    [lbl_score setTextColor:color_989898];
    [lbl_spms setTextColor: color_333333];
    [lbl_fwmyd setTextColor: color_333333];
    [lbl_fhsd setTextColor: color_333333];
    
    [self addButtonScore];
}

- (void) setScore:(float) _score{
    
    for (UIView * subView in self.contentView.subviews) {
        if (subView.tag>=tag_score && subView.tag<tag_score+4) {
            [subView removeFromSuperview];
        }
    }
    
    for (int i=0; i<5; i++) {
        int iscore = floor((float)_score);
        UIImageView * imgScore = [[UIImageView alloc] initWithFrame:CGRectMake(92+(i*20), lbl_mjpf.frame.origin.y-3, 27, 27)];
        [imgScore setTag:tag_score + i];
        [imgScore setBackgroundColor:[UIColor clearColor]];
        [imgScore setImage:[UIImage imageNamed: i<iscore ? @"like_btn_sel.png":@"like_btn_nor.png"]];
        [self.contentView addSubview:imgScore];
    }
}

- (void) addButtonScore{
    
    float ypoint = 0;
    for (int i=0; i<3; i++) {
        
        int tag = 0;
        if (i==0) {
            tag = tag_score*100;
            ypoint = lbl_spms.frame.origin.y-1;
        }
        if (i==1) {
            tag = tag_score*200;
            ypoint = lbl_fwmyd.frame.origin.y-1;
        }
        if (i==2) {
            tag = tag_score*300;
            ypoint = lbl_fhsd.frame.origin.y-1;
        }
    
        for (int j=1; j<6; j++) {
            UIButton * btnScrore = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnScrore setFrame:CGRectMake(110+33*(j-1), ypoint, 32, 26)];
            [btnScrore setTag:tag+j];
            [btnScrore setBackgroundColor:[UIColor clearColor]];
            [btnScrore setImage:[UIImage imageNamed: @"like_btn_big_nor.png"] forState:UIControlStateNormal];
            [btnScrore addTarget:self action:@selector(onButtonScoreClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btnScrore];
        }
    }
}
//  -- 打分
- (void) onButtonScoreClick:(id)sender{
    
    UIButton * btntmp = (UIButton*) sender;
    [self.txt_Content resignFirstResponder];
    
    if (btntmp.tag>tag_score*100 && btntmp.tag<tag_score*200) {
        
        iscore_spms = btntmp.tag - tag_score*100;
        [self scoreResult:tag_score*100 score:iscore_spms];
    }
    if (btntmp.tag>tag_score*200 && btntmp.tag<tag_score*300) {

        iscore_fwmyd = btntmp.tag - tag_score*200;
        [self scoreResult:tag_score*200 score:iscore_fwmyd];
    }
    if (btntmp.tag>tag_score*300) {
        
        iscore_fhsd = btntmp.tag - tag_score*300;
        [self scoreResult:tag_score*300 score:iscore_fhsd];
    }
    
    //  --。。。。。。
    if ([commentDelegate respondsToSelector:@selector(onDelegateScoreButtonClick:)]) {
        [commentDelegate onDelegateScoreButtonClick:self];
    }
}

//  -- 打分结果   : btntag 是基数标识
- (void) scoreResult:(int) _btntag score:(int) _score{
    
    int iscore = floor((float)_score);

    for (int i=1; i<6; i++) {
        UIButton * scoreBtn = (UIButton*)[self.contentView viewWithTag:_btntag+i];
        [scoreBtn setImage:[UIImage imageNamed:i<=iscore ? @"like_btn_big_sel.png":@"like_btn_big_nor.png"]
                            forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    [txtViewPlaceHold resignFirstResponder];
    [txt_Content resignFirstResponder];
}

#pragma mark    --  textview delegate
-(void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        [self.txtViewPlaceHold setHidden:NO];
    }else{
        [self.txtViewPlaceHold setHidden:YES];
    }
    
    //  --。。。。。。
    if ([commentDelegate respondsToSelector:@selector(onDelegateCommentContentChanged:)]) {
        [commentDelegate onDelegateCommentContentChanged:self];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    return YES;
}


@end
