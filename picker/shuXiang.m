//
//  shuXiang.m
//  picker
//
//  Created by zhang on 14-8-7.
//  Copyright (c) 2014年 zhang. All rights reserved.
//

#import "shuXiang.h"

#define SCROLL_PIXELS
@interface shuXiang ()

@end

@implementation shuXiang
{
    NSArray *tuArray;
    float heightSize;
    int selectedCover;
    CAScrollLayer   * cfIntLayer;
    UIScrollView *scrollViewzx;
    NSMutableArray *imageTU;
}
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
    self.view.backgroundColor=[UIColor grayColor];
    
    UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(10, 90, 10, 460)];
    xian.image=[UIImage imageNamed:@"xian"];
    
    [self.view addSubview:xian];
   
     tuArray =@[@"啡茶不可",@"AMUN",@"科普惠农",@"七面一生",@"HD",@"时在",@"啡茶不可",@"AMUN",@"科普惠农",@"七面一生",@"HD",@"时在"];
    
    scrollViewzx=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 86, 320, 462)];
    
    [self.view addSubview:scrollViewzx];
    
    
    
    scrollViewzx.backgroundColor=[UIColor clearColor];
    scrollViewzx.contentSize=CGSizeMake(320,462*2);
    scrollViewzx.delegate=self;
//    scrollViewzx.showsHorizontalScrollIndicator=YES;
//    scrollViewzx.showsVerticalScrollIndicator=YES;
//    for (int i=0; i<[tuArray count]; i++) {
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, i*110+5*i+166, 320, 110)];
//        [scrollViewzx addSubview:imageView];
//        imageView.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tuArray[i] ofType:@"jpg"]];
//        imageView.contentMode=UIViewContentModeScaleAspectFit;
//    }
    
    [self layoutLayer:cfIntLayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView.contentInset.
//        ;
//    }
    

    [self layoutLayer:cfIntLayer];
}
-(void)layoutLayer:(CAScrollLayer *)layer{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.3f]forKey:@"animationDuration"];
    for (int i=1; i<7; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectZero];
        [scrollViewzx addSubview:imageView];
        imageView.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tuArray[i] ofType:@"jpg"]];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        switch (i ) {
            case 1:
            case 7:
            {
                imageView.frame=CGRectMake(0, 0, 320, 60);
            }
                break;
            case 2:
            case 6:
            {
                imageView.frame=CGRectMake(0, i*110+5*i+166, 320, 60);
            }
                break;
            case 3:
            case 5:
            {
                imageView.frame=CGRectMake(0, i*110+5*i+166, 320, 90);
            }
                break;
           
            case 4:
            {
                imageView.frame=CGRectMake(0, i*110+5*i+166, 320, 110);
            }
                break;

                
                

                
            default:
                break;
        }
        
    }

    
    
    [CATransaction commit];
    
}



@end
