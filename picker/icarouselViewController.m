//
//  icarouselViewController.m
//  picker
//
//  Created by zhang on 14-8-11.
//  Copyright (c) 2014年 zhang. All rights reserved.
//

#import "icarouselViewController.h"

@interface icarouselViewController ()

@end

@implementation icarouselViewController
{
    NSArray *tuArray;
    NSTimer *zxtimerzx;
    iCarousel *carouseView;
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
    
//    tuArray =@[@"啡茶不可",@"AMUN",@"科普惠农",@"七面一生",@"HD",@"时在"];
    tuArray=@[@"0.tiff",@"1.tiff",@"2.tiff",
              @"3.tiff",@"4.tiff",@"5.tiff",
              @"6.tiff",@"7.tiff",@"0.tiff",@"1.tiff",@"2.tiff",
              @"3.tiff",@"4.tiff",@"5.tiff",
              @"6.tiff",@"7.tiff"];
    carouseView=[[iCarousel alloc]initWithFrame:CGRectMake(0, 86, 320, 400)];
    carouseView.backgroundColor=[UIColor orangeColor];
    
    carouseView.layer.transform=CATransform3DMakeRotation(-1.56, 0, 0, 0.38);
    [self.view addSubview:carouseView];
    
    carouseView.delegate=self;
    carouseView.dataSource=self;
    carouseView.type=3;
    zxtimerzx=[NSTimer scheduledTimerWithTimeInterval:2
                                               target:self
                                             selector:@selector(timerRun)
                                             userInfo:nil
                                              repeats:YES];
 
}
-(void)timerRun
{
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [tuArray count];
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIImageView *viewCell=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,150  ,320)];
    viewCell.image=[UIImage imageNamed:tuArray[index]];
    viewCell.contentMode=UIViewContentModeScaleAspectFit;
    viewCell.backgroundColor=[UIColor blueColor];
    
    viewCell.layer.transform=CATransform3DMakeRotation(1.56, 0, 0, 0.38);
    return viewCell;
    
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
}





@end
