//
//  ChangeBuyOrActionView.m
//  boqiimall
//
//  Created by ysw on 14-10-21.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "ChangeBuyOrActionView.h"

@implementation ChangeBuyOrActionView
@synthesize changetype;
@synthesize delegateChangeBuy;
@synthesize ChangeData;
@synthesize pGoodsType,pGoodsId,pGoodsSpecId,pGroupPrice;
@synthesize pActionId,pChangeBuyId;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.changetype = CHANGEBUYPRODUCT;
        
        //  --
        headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        [headview setBackgroundColor:color_575757];
        [headview setHidden:YES];
        UILabel * lbl_title = [[UILabel alloc] init];
        [lbl_title setFrame:CGRectMake(0, 0, __MainScreen_Width, 40)];
        [lbl_title setBackgroundColor:[UIColor clearColor]];
        [lbl_title setFont:defFont13];
        [lbl_title setTextColor: [UIColor convertHexToRGB:@"ffffff"]];
        [lbl_title setTextAlignment:NSTextAlignmentCenter];
        [lbl_title setText:@"选择优惠方式"];
        [headview addSubview:lbl_title];
        [self addSubview:headview];
        
        //  --
        backMaskView = [UIButton buttonWithType:UIButtonTypeCustom];
        [backMaskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        [backMaskView setFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [backMaskView setHidden:YES];
        [backMaskView addTarget:self action:@selector(onMaskViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backMaskView];
        
        //  --
        rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0) style:UITableViewStylePlain];
        rootTableView.delegate = self;
        rootTableView.dataSource = self;
        [rootTableView setHidden:YES];
        rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        rootTableView.showsHorizontalScrollIndicator= NO;
        rootTableView.showsVerticalScrollIndicator  = NO;
        [self addSubview:rootTableView];
    }
    return self;
}


- (void) tabReloadData:(resMod_Mall_CartChangeBuyList *) p_changedata{

//    self.changetype = ict==0 ? CHANGEBUYPRODUCT:CHANGEACTION;
    self.ChangeData = p_changedata;
    
    [rootTableView setContentOffset:CGPointMake(0, 0)];
    [rootTableView reloadData];
}


- (void) resetFrame:(CGRect) frame{
    [self setFrame:frame];
    [headview setFrame:CGRectMake(0, frame.size.height, frame.size.width, 40)];
    [backMaskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [backMaskView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [rootTableView setFrame:CGRectMake(0, frame.size.height, frame.size.width, 200)];

    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [backMaskView setHidden:NO];
                         [rootTableView setHidden:NO];
                         [backMaskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
                         
                         if (self.changetype==CHANGEACTION) {
                             [headview setHidden:NO];
                             [headview setFrame:CGRectMake(0, frame.size.height-240, frame.size.width, 40)];
                             [rootTableView setFrame:CGRectMake(0, frame.size.height-200, frame.size.width, 200)];
                         }
                         else{
                             [rootTableView setFrame:CGRectMake(0, frame.size.height-200, frame.size.width, 200)];
                         }
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void) removeSelf{
    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [headview setFrame:CGRectMake(0, headview.frame.origin.y+240, headview.frame.size.width, 40)];
                         [backMaskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
                         [rootTableView setFrame:CGRectMake(0, rootTableView.frame.origin.y+rootTableView.frame.size.height, rootTableView.frame.size.width, 200)];
                     }
                     completion:^(BOOL finished){
                         [headview setHidden:YES];
                         [backMaskView setHidden:YES];
                         [rootTableView setHidden:YES];
                         [self removeFromSuperview];
                     }];
}

#pragma mark    --  event
- (void)onMaskViewClick:(id) sender{
    [self removeSelf];
}

- (void)onButtonChecked:(id) sender{
    UIButton * tmpbtn = (UIButton*)sender;
    [tmpbtn setImage:[UIImage imageNamed:@"checkbox_greensel.png"] forState:UIControlStateNormal];
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rownum = 0;
    if (self.changetype==CHANGEBUYPRODUCT) {
        rownum = self.ChangeData ?self.ChangeData.ChangeBuyList.count:0;
    }
    else if (self.changetype==CHANGEACTION){
        rownum = self.ChangeData ?self.ChangeData.ActionList.count:0;
    }
    return rownum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.changetype==CHANGEBUYPRODUCT ? 168/2 : 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * identifierCell;
    
    if (self.changetype==CHANGEACTION) {
        identifierCell = @"ChangeBuyActionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if ( !cell ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            
            UIImageView * btncheck = [[UIImageView alloc] init];
            [btncheck setTag:11111];
            [btncheck setFrame:CGRectMake(12, 19, 20, 20)];
            [btncheck setBackgroundColor:[UIColor clearColor]];
            [btncheck setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"]];
            [cell.contentView addSubview:btncheck];
            
            //  -- 活动id
            UILabel * lbl_Actionid = [[UILabel alloc] init];
            [lbl_Actionid setTag:4001];
            [lbl_Actionid setFrame:CGRectMake(0, 0, 0, 0)];
            [lbl_Actionid setHidden:YES];
            [cell.contentView addSubview:lbl_Actionid];
            
            //  -- 活动描述
            UILabel * lbl_ActionDes = [[UILabel alloc] init];
            [lbl_ActionDes setTag:4002];
            [lbl_ActionDes setFrame:CGRectMake(CGRectGetMaxX(btncheck.frame)+6, 10, __MainScreen_Width-CGRectGetMaxX(btncheck.frame)-12, 40)];
            [lbl_ActionDes setBackgroundColor:[UIColor clearColor]];
            [lbl_ActionDes setFont:defFont13];
            [lbl_ActionDes setTextColor:color_333333];
            [lbl_ActionDes setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lbl_ActionDes];
        }
        
        UIImageView * imgcheck = (UIImageView*)[cell.contentView viewWithTag:11111];
        UILabel * lbl_4001 = (UILabel*)[cell.contentView viewWithTag:4001];
        [lbl_4001 setText:@""];
        UILabel * lbl_4002 = (UILabel*)[cell.contentView viewWithTag:4002];
        [lbl_4002 setText:@"活动商品已购滿500元，已减100元"];
        
        if (ChangeData && ChangeData.ActionList.count>0) {
            
            int actionid = [ChangeData.ActionList[indexPath.row] ActionId];
            [imgcheck setImage:[UIImage imageNamed: self.pActionId==actionid ? @"checkbox_greensel.png"
                                                                             : @"checkbox_greenUnsel.png"]];
            [lbl_4001 setText:[NSString stringWithFormat:@"%d",[ChangeData.ActionList[indexPath.row] ActionId]]];
            [lbl_4002 setText:[ChangeData.ActionList[indexPath.row] ActionTitle]];
        }
        
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (self.changetype==CHANGEBUYPRODUCT) {
        identifierCell = @"ChangeBuyProductCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if ( !cell ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            
            UIImageView * btncheck = [[UIImageView alloc] init];
            [btncheck setTag:11111];
            [btncheck setFrame:CGRectMake(12, 25, 20, 20)];
            [btncheck setBackgroundColor:[UIColor clearColor]];
            [btncheck setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"]];
            [cell.contentView addSubview:btncheck];

            //  -- 商品图
            UIImageView * proimg = [[UIImageView alloc] init];
            [proimg setTag:3001];
            [proimg setFrame:CGRectMake(CGRectGetMaxX(btncheck.frame)+8, 12, 60, 60)];
            [proimg setBackgroundColor:[UIColor whiteColor]];
            proimg.layer.borderColor = color_d1d1d1.CGColor;
            proimg.layer.borderWidth = 0.5f;
            [cell.contentView addSubview:proimg];
            
            //  -- 商品标题
            UILabel * lbl_protitle = [[UILabel alloc] init];
            [lbl_protitle setTag:3002];
            [lbl_protitle setFrame:CGRectMake(CGRectGetMaxX(proimg.frame) +10, CGRectGetMinY(proimg.frame)-1, __MainScreen_Width-20-CGRectGetMaxX(proimg.frame), 40)];
            [lbl_protitle setBackgroundColor:[UIColor clearColor]];
            [lbl_protitle setFont:defFont12];
            [lbl_protitle setTextColor:color_333333];
            [lbl_protitle setTextAlignment:NSTextAlignmentLeft];
            [lbl_protitle setLineBreakMode:NSLineBreakByWordWrapping];
            [lbl_protitle setNumberOfLines:0];
            [cell.contentView addSubview:lbl_protitle];
            
            //  -- 商品状态或是否下架
            UILabel * lbl_prostatus = [[UILabel alloc] init];
            [lbl_prostatus setTag:3000];
            [lbl_prostatus setFrame:CGRectMake(CGRectGetMaxX(proimg.frame) +10, 40, 200, 18)];
            [lbl_prostatus setBackgroundColor:[UIColor clearColor]];
            [lbl_prostatus setFont:defFont12];
            [lbl_prostatus setText:@"商品下架或库存不足"];
            [lbl_prostatus setTextColor:[UIColor redColor]];
            [lbl_prostatus setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lbl_prostatus];
            
            //  -- 商品原价
            UILabel * lbl_oriprice = [[UILabel alloc] init];
            [lbl_oriprice setTag:3003];
            [lbl_oriprice setFrame:CGRectMake(CGRectGetMaxX(proimg.frame) +10, CGRectGetMaxY(proimg.frame)-15, __MainScreen_Width-12-CGRectGetMaxX(proimg.frame), 18)];
            [lbl_oriprice setBackgroundColor:[UIColor clearColor]];
            [lbl_oriprice setFont:defFont12];
            [lbl_oriprice setTextColor:color_989898];
            [lbl_oriprice setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lbl_oriprice];
            
            //  -- 商品现价
            UILabel * lbl_saleprice = [[UILabel alloc] init];
            [lbl_saleprice setTag:3004];
            [lbl_saleprice setFrame:CGRectMake(__MainScreen_Width-112, lbl_oriprice.frame.origin.y, 100, 18)];
            [lbl_saleprice setBackgroundColor:[UIColor clearColor]];
            [lbl_saleprice setFont:defFont13];
            [lbl_saleprice setTextColor:color_fc4a00];
            [lbl_saleprice setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lbl_saleprice];
            
            //  -- 每行商品的分隔线
            UILabel * lblSpaceLine = [[UILabel alloc] initWithFrame:CGRectMake(proimg.frame.origin.x, 0, __MainScreen_Width-proimg.frame.origin.x-12, 0.5)];
            [lblSpaceLine setTag:3009];
            [lblSpaceLine setBackgroundColor: color_d1d1d1];
            [cell.contentView addSubview:lblSpaceLine];
        }
        
        if (ChangeData && ChangeData.ChangeBuyList.count>0) {
            
            UIImageView * imgcheck = (UIImageView*)[cell.contentView viewWithTag:11111];
            UILabel * lbl_3000 = (UILabel*)[cell.contentView viewWithTag:3000];
            UIImageView * img_3001 = (UIImageView*)[cell.contentView viewWithTag:3001];
            UILabel * lbl_3002 = (UILabel*)[cell.contentView viewWithTag:3002];
            UILabel * lbl_3003 = (UILabel*)[cell.contentView viewWithTag:3003];
            UILabel * lbl_3004 = (UILabel*)[cell.contentView viewWithTag:3004];
            UILabel * lbl_3009 = (UILabel*)[cell.contentView viewWithTag:3009];
            [lbl_3009 setHidden: indexPath.row>0 ? NO:YES];
            
            int irow = indexPath.row;
            resMod_Mall_CartChangeBuyInfo * tmpchange = self.ChangeData.ChangeBuyList[irow];
            CGSize tsize = [tmpchange.ChangeBuyTitle sizeWithFont:defFont12 constrainedToSize:CGSizeMake(lbl_3002.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            
            NSString * simg = self.pChangeBuyId==tmpchange.ChangeBuyId ? @"checkbox_greensel.png" : @"checkbox_greenUnsel.png";
            [imgcheck setImage:[UIImage imageNamed: simg]];
            
            [lbl_3000 setText:tmpchange.ReasonForNotChange];
            [img_3001 sd_setImageWithURL:[NSURL URLWithString:tmpchange.ChangeBuyImg]
                        placeholderImage:[UIImage imageNamed:@"placeHold_75x75.png"]];
            [lbl_3002 setText:tmpchange.ChangeBuyTitle];
            [lbl_3002 setFrame:CGRectMake(lbl_3002.frame.origin.x,lbl_3002.frame.origin.y,lbl_3002.frame.size.width,tsize.height)];
            [lbl_3003 setText:[NSString stringWithFormat:@"原价：%.2f元",tmpchange.ChangeBuyOriPrice]];
            [lbl_3004 setText:[NSString stringWithFormat:@"换购价：%.2f元",tmpchange.ChangeBuyPrice]];
        }
        
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.changetype==CHANGEBUYPRODUCT){
        resMod_Mall_CartChangeBuyInfo * tmpchange = self.ChangeData.ChangeBuyList[indexPath.row];
        if (!tmpchange.IsCanChange) {
            return;
        }
    }
    
    UITableViewCell * cell = [rootTableView cellForRowAtIndexPath:indexPath];
    UIImageView * btn_11111 = (UIImageView*)[cell.contentView viewWithTag:11111];
    [btn_11111 setImage:[UIImage imageNamed:@"checkbox_greensel.png"]];

    [self removeSelf];
    
    if ([delegateChangeBuy respondsToSelector:@selector(onDelegateChangeActionDidChecked:)]) {
        NSMutableDictionary * dicparams = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dicparams setObject:[NSString stringWithFormat:@"%d",self.pGoodsId] forKey:@"GoodsId"];
        [dicparams setObject:[NSString stringWithFormat:@"%d",self.pGoodsType] forKey:@"GoodsType"];
        [dicparams setObject:pGoodsSpecId forKey:@"GoodsSpecId"];
        [dicparams setObject:[NSString stringWithFormat:@"%.2f",self.pGroupPrice] forKey:@"GroupPrice"];
        
        if (self.changetype==CHANGEACTION){
            resMod_Mall_CartPreferentialInfo * preinfo = self.ChangeData.ActionList[indexPath.row];
            [dicparams setObject:[NSString stringWithFormat:@"%d",preinfo.ActionId] forKey:@"ActionId"];
            [dicparams setObject:@"0" forKey:@"ChangeBuyId"];
        }
        else{
            resMod_Mall_CartChangeBuyInfo * tmpchange = self.ChangeData.ChangeBuyList[indexPath.row];
            [dicparams setObject:[NSString stringWithFormat:@"%d",tmpchange.CurrentActionId] forKey:@"ActionId"];
            [dicparams setObject:[NSString stringWithFormat:@"%d",tmpchange.ChangeBuyId] forKey:@"ChangeBuyId"];
        }
        [delegateChangeBuy onDelegateChangeActionDidChecked:dicparams];
    }
}
@end


