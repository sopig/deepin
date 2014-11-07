//
//  TableCell_Mosaic.m
//  boqiimall
//
//  Created by YSW on 14-7-2.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "TableCell_Mosaic.h"
#import "resMod_Mall_IndexData.h"

//  --  .mosaic img.
@implementation EC_MosaicButton
@synthesize itype;
@synthesize apiUrl;
@synthesize mosaicImg;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        itype = -100;
        [self setImage:[UIImage imageNamed:@"placeHold_75x75.png"] forState:UIControlStateNormal];
        
        mosaicImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        [mosaicImg setBackgroundColor:[UIColor clearColor]];
        [self addSubview:mosaicImg];
        [self bringSubviewToFront:mosaicImg];
    }
    return self;
}

- (void) setMosaicImgURL:(NSString*) _surl{
    [mosaicImg sd_setImageWithURL:[NSURL URLWithString:_surl]
                 placeholderImage:[UIImage imageNamed:@""]];
}

- (void) setMosaicImgFrame{
    [mosaicImg setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end





//  --  .mosaic cell.
@implementation TableCell_Mosaic
@synthesize cellMosaicDelegate;
@synthesize iMosaicType;
@synthesize arrMosaicData;
@synthesize arrbtns,BtnImg0,BtnImg1,BtnImg2,BtnImg3,BtnImg4,BtnImg5;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        iMosaicType = 0;
        arrMosaicData = [[NSMutableArray alloc] initWithCapacity:0];
        
        //  --
        BtnImg0 = [EC_MosaicButton buttonWithType:UIButtonTypeCustom];
        [BtnImg0 setFrame:CGRectZero];
        [self addSubview:BtnImg0];
        
        BtnImg1 = [EC_MosaicButton buttonWithType:UIButtonTypeCustom];
        [BtnImg1 setFrame:CGRectZero];
        [self addSubview:BtnImg1];
        
        BtnImg2 = [EC_MosaicButton buttonWithType:UIButtonTypeCustom];
        [BtnImg2 setFrame:CGRectZero];
        [self addSubview:BtnImg2];
        
        BtnImg3 = [EC_MosaicButton buttonWithType:UIButtonTypeCustom];
        [BtnImg3 setFrame:CGRectZero];
        [self addSubview:BtnImg3];
        
        BtnImg4 = [EC_MosaicButton buttonWithType:UIButtonTypeCustom];
        [BtnImg4 setFrame:CGRectZero];
        [self addSubview:BtnImg4];
        
        BtnImg5 = [EC_MosaicButton buttonWithType:UIButtonTypeCustom];
        [BtnImg5 setFrame:CGRectZero];
        [self addSubview:BtnImg5];
        
        arrbtns = [[NSArray alloc] initWithObjects:BtnImg0,BtnImg1,BtnImg2,BtnImg3,BtnImg4,BtnImg5,nil];
        for (int i=0; i<arrbtns.count; i++) {
            EC_MosaicButton * btnimg = (EC_MosaicButton*)arrbtns[i];
            [btnimg setHidden:YES];
            [btnimg setFrame:CGRectZero];
            [btnimg setBackgroundColor:[UIColor whiteColor]];
            [btnimg setTitle:@"" forState:UIControlStateNormal];
            [btnimg addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) onButtonClick:(id) sender{
    EC_MosaicButton * btntmp = (EC_MosaicButton*)sender;
    if ([cellMosaicDelegate respondsToSelector:@selector(onMosaicButtonClick:requestUrl:)]) {
        [cellMosaicDelegate onMosaicButtonClick:btntmp.itype requestUrl:btntmp.apiUrl];
    }
}

- (void) bindDataBytype:(int) ptype datainfo:(NSMutableArray *) pmosaicdata{
    
    [self setFrameByType:ptype];
    
    for (int i=0; i<arrbtns.count; i++) {
        
        EC_MosaicButton * btnimg = (EC_MosaicButton*)arrbtns[i];
        if (i<pmosaicdata.count) {
            resMod_Mall_IndexBanner * dataTmp = pmosaicdata[i];
            btnimg.apiUrl = dataTmp.Url;
            btnimg.itype = dataTmp.Type;
            [btnimg setMosaicImgURL:dataTmp.ImageUrl];
            [btnimg setHidden: NO];
        }
        else{
            [btnimg setHidden: YES];
        }
    }
}

- (void) setFrameByType:(int) ptype{
    switch (ptype) {
        case 1:
            [BtnImg0 setFrame:CGRectMake(-0.5, 0, 263/2, 296/2)];
            [BtnImg1 setFrame:CGRectMake(263/2, 0, 378/2, 148/2-0.5)];
            [BtnImg2 setFrame:CGRectMake(263/2, 148/2, 188/2, 148/2)];
            [BtnImg3 setFrame:CGRectMake((263+188)/2+0.5, 148/2, 189/2, 148/2)];
            [BtnImg0 setMosaicImgFrame];
            [BtnImg1 setMosaicImgFrame];
            [BtnImg2 setMosaicImgFrame];
            [BtnImg3 setMosaicImgFrame];
            break;
            
        case 2:
            [BtnImg0 setFrame:CGRectMake(-0.5, 0, 320/2, 148/2)];
            [BtnImg1 setFrame:CGRectMake(320/2, 0, 320/2, 148/2)];
            [BtnImg0 setMosaicImgFrame];
            [BtnImg1 setMosaicImgFrame];
            break;
            
        case 3:
            [BtnImg0 setFrame:CGRectMake(-0.5, 0, 220/2, 296/2)];
            [BtnImg1 setFrame:CGRectMake(220/2, 0, 210/2, 148/2-0.5)];
            [BtnImg2 setFrame:CGRectMake((220+210)/2+0.5, 0, 210/2, 148/2-0.5)];
            [BtnImg3 setFrame:CGRectMake(220/2, 148/2, 210/2, 148/2)];
            [BtnImg4 setFrame:CGRectMake((220+210)/2+0.5, 148/2, 210/2, 148/2)];
            [BtnImg0 setMosaicImgFrame];
            [BtnImg1 setMosaicImgFrame];
            [BtnImg2 setMosaicImgFrame];
            [BtnImg3 setMosaicImgFrame];
            [BtnImg4 setMosaicImgFrame];
            break;
       
        case 4:
            [BtnImg0 setFrame:CGRectMake(-0.5, 0, 320/2, 296/2)];
            [BtnImg1 setFrame:CGRectMake(320/2, 0, 320/2, 148/2-0.5)];
            [BtnImg2 setFrame:CGRectMake(320/2, 148/2, 320/2, 148/2)];
            [BtnImg0 setMosaicImgFrame];
            [BtnImg1 setMosaicImgFrame];
            [BtnImg2 setMosaicImgFrame];
            break;

        default:
            break;
    }
}
@end







