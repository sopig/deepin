//
//  TicketCommentViewController.m
//  boqiimall
//
//  Created by 张正超 on 14-7-14.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "TicketCommentViewController.h"


#import "EC_UIScrollView.h"

#define kTicketID_ParaKey @"param_TicketId"
//#define kUserID_ParaKey @"param_UserId"
#define kPropImgUrl_ParaKey @"propImgUrl"
#define kTicketTitle_ParaKey @"TicketTitle"
#define kTicketPrice_ParaKey @"TicketPrice"

#define COMMENTVIEW_BASETAG  8888
#define CommentTextViewBaseTag 7777


#define CommentContent @"写点评价吧，对其他宠物主帮助很大哦！"
@interface TicketCommentViewController ()
{
//    EC_UIScrollView *_scrollView;
    UIScrollView *_scrollView;
    BOOL _isClear;
}

//@property(nonatomic,readwrite,strong)TicketCommentModel* ticketCommentModel;
@property(nonatomic,readwrite,strong)NSMutableDictionary* requestParams;

@end

@implementation TicketCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [self loadNavBarView];
    [self setTitle:@"服务券点评"];
    [self.view setBackgroundColor:color_bodyededed];
    
  //  [self loadNavBarView:@"服务券点评"];
     _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, __ContentHeight_noTab)];
    
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 600);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.userInteractionEnabled = YES;
    
    UIView *backgroundView=[UICommon Common_DottedCornerRadiusView:CGRectMake(12, 12, 592/2, 480/2) targetView:_scrollView tag:100 dottedImgName:@"dottedLineWhite"];

    [_scrollView addSubview:backgroundView];
    
    
    CGRect protImgViewRect = CGRectMake(12, 12, 75, 75);
    UIImageView *protImgView = [[UIImageView alloc]initWithFrame:protImgViewRect];
    
    [protImgView setBackgroundColor:[UIColor clearColor]];
    NSString *protImg = [BQ_global convertImageUrlString:kImageUrlType_75x75 withurl:[self.receivedParams objectForKey:kPropImgUrl_ParaKey]];
    [protImgView sd_setImageWithURL:[NSURL URLWithString:protImg] placeholderImage:[UIImage imageNamed:@"placeHold_75x75.png"]];
    [backgroundView addSubview:protImgView];
    
    
    CGRect titleLabelRect = CGRectMake(92, 12, 204, 40);
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:titleLabelRect];
    [titleLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [backgroundView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor =[UIColor convertHexToRGB:@"383838"];
    titleLabel.text = [self.receivedParams objectForKey:kTicketTitle_ParaKey];
    titleLabel.numberOfLines = 0;
    
    
    
    CGRect priceLableRect = CGRectMake(92, 55, 100, 25);
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:priceLableRect];
    priceLabel.font = [UIFont systemFontOfSize:18];
    NSString *priceText = [NSString stringWithFormat:@"%@ 元",[self.receivedParams objectForKey:@"TicketPrice"]];
    priceLabel.text = priceText;
    priceLabel.textColor = color_fc4a00;
    [backgroundView addSubview:priceLabel];
    
    //星级评分
    
    NSArray *titleArray = @[@"专 业 度：",@"服务：",@"服务态度：",@"价格满意："];
    for (int i = 0; i < 4; i++) {
        [self commonScoreWithName:[titleArray objectAtIndex:i] andWithNameRect:CGRectMake(12, 85 + i*35, 100, 40) andWithStarRect:CGRectMake(100, 100 + i*35, 156.25, 25) andWithTag:COMMENTVIEW_BASETAG+i+1];
    }
    

    //像素分割线
    CGRect lineRect = CGRectMake(5, 90, 300, 1);
    [UICommon Common_line:lineRect targetView:backgroundView backColor:color_ededed];
    
    UITextView *commentTextView = [[UITextView alloc]initWithFrame:CGRectMake(12, 262, 592/2, 200)];
    [_scrollView addSubview:commentTextView];
    commentTextView.text = CommentContent;
    commentTextView.font = [UIFont systemFontOfSize:14];
    commentTextView.textColor = [UIColor convertHexToRGB:@"989898"];

    commentTextView.delegate = self;
    [commentTextView setEditable:YES];
    commentTextView.returnKeyType = UIReturnKeyDone;
    _isClear = NO;

    
    //提交
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.backgroundColor = color_fc4a00;
    commitButton.frame = CGRectMake(12,474,592/2, 50);
    commitButton.layer.cornerRadius = 3;
    [commitButton setTitle:@"提交点评" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:commitButton];
    
    [self _initStar];
    
}
//TODO: 没有完成

//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}

//默认星级视图的值
- (void)_initStar{
     self.requestParams = [NSMutableDictionary dictionary];
    [self.requestParams setObject:[NSString stringWithFormat:@"%.2f",0.00] forKey:@"ProfessionalScore"];
    [self.requestParams setObject:[NSString stringWithFormat:@"%.2f",0.00] forKey:@"EnvironmentScore"];
    [self.requestParams setObject:[NSString stringWithFormat:@"%.2f",0.00] forKey:@"AttitudeScore"];
    [self.requestParams setObject:[NSString stringWithFormat:@"%.2f",0.00] forKey:@"PriceScore"];

}

//创建星级评分
- (void)commonScoreWithName:(NSString*)name andWithNameRect:(CGRect)nameRect andWithStarRect:(CGRect)starRect andWithTag:(NSUInteger)tagNum
{
    UIView *backgroundView = [_scrollView viewWithTag:100];
    backgroundView.userInteractionEnabled = YES;
    //专业度
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textAlignment = NSTextAlignmentJustified;
    nameLabel.textColor = [UIColor convertHexToRGB:@"383838"];
    nameLabel.text = name;
    [backgroundView addSubview:nameLabel];
    
    //星级评分视图
    BQStarRatingView *starRatingView = [[BQStarRatingView alloc]initWithFrame:starRect numberOfStar:5 withStatue:0];
    starRatingView.tag = tagNum;
    starRatingView.delegate = self;
    [backgroundView addSubview:starRatingView];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#define mark - starRatingviewDelegate

- (void)starRatingView:(BQStarRatingView *)view score:(float)score
{
    if (view.tag == COMMENTVIEW_BASETAG + 1) {
        [self.requestParams setObject:[NSString stringWithFormat:@"%.2f",score] forKey:@"ProfessionalScore"];
    }
    else if (view.tag == COMMENTVIEW_BASETAG + 2){
        [self.requestParams setObject:[NSString stringWithFormat:@"%.2f",score] forKey:@"EnvironmentScore"];
    }
    else if (view.tag == COMMENTVIEW_BASETAG + 3){
          [self.requestParams setObject:[NSString stringWithFormat:@"%.2f",score] forKey:@"AttitudeScore"];
    }
    else if (view.tag == COMMENTVIEW_BASETAG + 4){
        [self.requestParams setObject:[NSString stringWithFormat:@"%.2f",score] forKey:@"PriceScore"];
    }
}


#pragma mark - Delegate方法

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_isClear) {
        return;
    }
   textView.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _isClear = YES;
    [self.requestParams setObject:textView.text forKey:@"CommentContent"];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



#pragma mark - 提交按钮点击事件处理

- (void)commitButtonClicked:(id)sender
{
    [self.requestParams setObject:[UserUnit userId] forKey:@"UserId"];
    [self.requestParams setObject:[self.receivedParams objectForKey:kTicketID_ParaKey] forKey:@"TicketId"];
    [self goApiRequest];
}

-(void) goApiRequest{
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_CommitTicketComment class:@"ResponseBase"
//              params:self.requestParams isShowLoadingAnimal:NO hudShow:@"正在提交"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestCommitTicketComment:self.requestParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在提交" delegate:self];
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_CommitTicketComment]) {
        [self HUDShow:@"点评成功" delay:1 dothing:YES];
    }
}

-(void)HUDdelayDo {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
