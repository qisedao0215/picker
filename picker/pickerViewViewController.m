//
//  pickerViewViewController.m
//  picker
//
//  Created by zhang on 14-8-8.
//  Copyright (c) 2014年 zhang. All rights reserved.
//

#import "pickerViewViewController.h"


@interface pickerViewViewController ()

@end

@implementation pickerViewViewController
{
    NSArray *imageArray;
    NSArray *textArray;
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
    
    self.navigationController.navigationBarHidden=YES;
    
    zxPickerViewFlow *hFlowView=[[zxPickerViewFlow alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    
    hFlowView.delegate = self;
    hFlowView.dataSource = self;
//    hFlowView.pageControl = hPageControl;
    hFlowView.minimumPageAlpha = 0.3;
    hFlowView.minimumPageScale = 0.9;
    hFlowView.orientation = PagedFlowViewOrientationVertical;
    
    imageArray = @[@"0.tiff",@"1.tiff",@"2.tiff",@"3.tiff",@"4.tiff",@"5.tiff",@"6.tiff",@"7.tiff"];
    textArray=@[
                @"啡茶不可：此饮料连锁店要求以奶茶和咖啡为原料，要求以时尚新颖的商标作为产品LOGO，包含茶杯形状以体现出所做产品。本设计以咖啡色和茶色互搭的形式作为主要形式，以不规则的拼凑形式表现出咖啡和茶之间的搭配方式，体现出咖啡里有茶，茶里有咖啡，再加一杯子为侧边，使得整个LOGO看起来时尚，新颖",
                @"AMUN:美联进出口有限公司要求以简单易记的形式，多元化的特点塑造个国际风范的品牌。此设计以类似花朵的形式表现出多元化的风格，以单一绿色标注为本企业的标识色。",
                @"科普惠农：此为河南电视台民生频道一科普节目标志。本设计以蓝色代表科技，绿色代表农业，从节目的角度去处理，进行了两边延伸，通过绿色的框架及蓝色的立体字表现的科技感十足，以绿色实体中间白色惠子为辅助，体现出以惠为重点，与此节目相得益彰。",
                @"7面一生：一款要求名为‘7面一生’女士时尚专用化妆品的产品LOGO。本设计以加宽的数字7形象的比喻了女士的脸庞，并以粉红渐白色为面，体现出此化妆品的效果，其他字体以粉色想呼应，并配以英文名称体现出国际风范。",
                @"HD:此企业为销售消防设备，要求以黑色红色为搭配，‘HD’为主题进行设计。本设计以变行体为主干，简单、大方、板正的形式，最终塑造为让任何人过目不忘的形象LOGO。",
                @"时在：此企业主要经营无线网络WIFI周边的物联网设备，公司名为‘时在’，要求为变形体，配色为单一颜色并包含英文名SEE-TIME。本设计通过科技感的金属灰色并加以WIFI符号的变形，以形象的形式展示出客户的主要经营范围。"];
    
    [self.view addSubview:hFlowView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)sizeForPageInFlowView:(zxPickerViewFlow *)flowView
{
    return CGSizeMake(320, 110);
}



- (NSInteger)numberOfPagesInFlowView:(zxPickerViewFlow *)flowView
{
    return textArray.count;
}

//返回给某列使用的View
- (UIView *)flowView:(zxPickerViewFlow *)flowView cellForPageAtIndex:(NSInteger)index
{
    UIView *viewCell=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 110)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(120, 0, 200, 110)];
    
    label.text=textArray[index];
    label.font=[UIFont systemFontOfSize:12];
    label.numberOfLines=10;
    [viewCell addSubview:label];
    
    return viewCell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
