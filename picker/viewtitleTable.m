//
//  viewtitle.m
//  picker
//
//  Created by zhang on 14-8-15.
//  Copyright (c) 2014年 zhang. All rights reserved.
//

#import "viewtitleTable.h"


//static NSUInteger iCountzx;
@interface viewtitleTable()
@property(nonatomic,retain)NSMutableArray *titleArray;
@property(nonatomic,retain)NSMutableArray *valuesArray;
@end
// i*(self.frame.size.height/2)/[array count]
//CGRectMake(0,i*(self.frame.size.height/2)/[array count], self.frame.size.width, self.frame.size.height/[array count])];


@implementation viewtitleTable
{
    
    NSUInteger abc;
    CGFloat height;
    UIView *viewBlock;
    BOOL trFV;
    UILabel *flg;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor orangeColor];

        viewBlock=[[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:viewBlock];
        viewBlock.backgroundColor=[UIColor blackColor];
        
    }
    return self;
}

-(void)addTitle:(NSArray *)array
{
    abc=[[_dic allKeys] count];
    height=self.frame.size.height/abc;

    for (int i=0; i<abc; i++) {
        UILabel *labelView=[[UILabel alloc]initWithFrame:CGRectMake(0, i*height, self.frame.size.width,height)];
        
        [self addSubview:labelView];
        labelView.text=array[i];
        labelView.textAlignment=NSTextAlignmentCenter;
        labelView.tag=1000+i;
        labelView.backgroundColor=[UIColor clearColor];
        
    }
//    [self frameMover:0];
    
}

-(void)moveTitleFrame:(float)moveLoce
{
    NSUInteger com=0;
    

    NSUInteger zzz= (NSUInteger)moveLoce/100 ;


    
    for (NSUInteger i=0; i<abc; i++) {
        UILabel *lab=nil;
        UILabel *lab1=nil;
        lab = (UILabel*)[self viewWithTag:1000+i ];
        lab1=(UILabel*)[self viewWithTag:999+i ];


        NSUInteger qian = [[_dic objectForKey:lab.text] count];

        qian+=com;
        if (zzz>=com&&zzz<=qian) {
            if (flg!=lab) {
                
                CGAffineTransform transfrom=lab.transform;
                transfrom=CGAffineTransformScale(lab.transform, 2, 2);
                lab.transform=transfrom;
                
                CGAffineTransform transfromFlg=flg.transform;
                transfromFlg=CGAffineTransformScale(flg.transform, 0.5, 0.5);
                flg.transform=transfromFlg;
                
                flg=lab;
            }
            viewBlock.frame=CGRectMake(0,moveLoce/110*(abc+1),self.frame.size.width,1);
            
            break;
        }
        com=qian;

    }

}

-(void)transFromView:(UILabel *)label
{
    if (trFV) {
        CGAffineTransform transfrom=label.transform;
        transfrom=CGAffineTransformScale(label.transform, 2, 2);
        label.transform=transfrom;

    }

}


//-(void)frameMover:(NSUInteger)index
//{
//    CGRect frame=CGRectMake(0, 0, self.frame.size.width,height);
//    for (NSUInteger i=0; i <abc; i ++) {
//        UILabel *label=nil;
//        UILabel *label1=nil;
//        label=(UILabel*)[self viewWithTag:1000+i ];
//        label1=(UILabel*)[self viewWithTag:1001+i ];
//   
//        if (i==index) {
//            frame.origin.y+=100;
//            label.frame = frame;
//    
//        }else{
//            label.frame=CGRectMake(0, i*height, self.frame.size.width,height);
//            
//        }
//    }
//
//}








@end
