//
//  BQImagePickerViewController.m
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-25.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQImagePickerViewController.h"
#import "BQImageview.h"


#define SPACE_WIDTH_X 13
#define ORIGIN_X 12
#define ORIGIN_Y 12
#define SPACE_WIDTH_Y 13


#define SEL_IMG_KEY @"com.boqii.tolly.portrait"

#define BASE_TAG 9000
@interface BQImagePickerViewController ()
{
    UIImageView *flagImageView ;
}
@end

@implementation BQImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title = @"选择头像";
    //[self loadNavBarView:@"选择头像"];
    //[self loadNavBarView];
    [self mainViewConfigure];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
    [self setTitle:@"选择头像"];
    
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)mainViewConfigure
{
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        [imgArray addObject:[NSString stringWithFormat:@"avatar_square_%d.jpg",i+1]];
    }
    for (int i = 0; i < imgArray.count; i++) {
     
        BQImageview *img = [[BQImageview alloc]initWithFrame:CGRectMake(ORIGIN_X+(i%3)*(SPACE_WIDTH_X+90) ,
                                                                        kNavBarViewHeight+ORIGIN_Y+(i/3)*(SPACE_WIDTH_Y+90) ,
                                                                        90, 90)];
        img.tag = BASE_TAG + i +1;
        
        img.selector = @selector(imgPicker:);
        img.delegate = self;
        img.object = img;

        img.image = [UIImage imageNamed:imgArray[i]];
        [self.view addSubview:img];
    }
    
    flagImageView = [[UIImageView alloc]init];
    flagImageView.image = [UIImage imageNamed:@"checkbox_greensel.png"];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:SEL_IMG_KEY] != nil) {
        [self didSelectImageWithIndex:[[[NSUserDefaults standardUserDefaults]objectForKey:SEL_IMG_KEY]integerValue]-1 isGoBack:NO];
    }

}


- (void)didSelectImageWithIndex:(NSUInteger)index isGoBack:(BOOL)GO
{
 
    flagImageView.frame = CGRectMake(ORIGIN_X+(index%3)*(SPACE_WIDTH_X+90) + 90 -20,
                                     ORIGIN_Y+(index/3)*(SPACE_WIDTH_Y+90) +90 -20+kNavBarViewHeight,
                                     20, 20);
    [self.view addSubview:flagImageView];
    
    [self writeSelectIndex:[NSString stringWithFormat:@"%d",index+1]];
    
    if (!GO) return;
    
    if (_delegate && [_delegate respondsToSelector:_selector]) {
        [self dismissViewControllerAnimated:YES completion:^{
                self.object = [NSNumber numberWithInteger:index];
             [_delegate performSelector:_selector withObject:_object afterDelay:0];
        }];
    }
}

- (void)writeSelectIndex:(NSString*)index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:index forKey:SEL_IMG_KEY];
}

- (void)imgPicker:(id)sender
{
    BQImageview *img = (BQImageview *)sender;
    switch (img.tag) {
        case BASE_TAG +1:
            [self didSelectImageWithIndex:0 isGoBack:YES];
            break;
            
        case BASE_TAG +2:
            [self didSelectImageWithIndex:1 isGoBack:YES];

            break;
            
        case BASE_TAG +3:
            [self didSelectImageWithIndex:2 isGoBack:YES];

            break;
            
        case BASE_TAG +4:
            [self didSelectImageWithIndex:3 isGoBack:YES];

            break;
            
            
        case BASE_TAG +5:
            [self didSelectImageWithIndex:4 isGoBack:YES];

            break;
            
        case BASE_TAG +6:
            [self didSelectImageWithIndex:5 isGoBack:YES];

            break;
            
        case BASE_TAG +7:
            [self didSelectImageWithIndex:6 isGoBack:YES];

            break;
            
        case BASE_TAG +8:
            [self didSelectImageWithIndex:7 isGoBack:YES];

            break;
            
        case BASE_TAG +9:
            [self didSelectImageWithIndex:8 isGoBack:YES];

            break;
            
            
        default:
            break;
    }
    
    
}


- (void)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        //释放视图
        [self freeViews];
    }];
}

- (void)freeViews
{
    for (UIView* view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
