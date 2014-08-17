//
//  zxzxViewController.m
//  picker
//
//  Created by zhang on 14-8-14.
//  Copyright (c) 2014年 zhang. All rights reserved.
//

#import "zxzxViewController.h"
#import "viewtitleTable.h"

@interface zxzxViewController ()

@end

@implementation zxzxViewController
{
    NSArray *zxdataArray;
    NSDictionary *zxDictionary;
    
    NSArray *keyArray;
    NSArray *valueArray;
    viewtitleTable *viewTitle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    zxdataArray=@[@"1",@"212341242142134234"
                  ,@"212341242142134234"
                  ,@"212341242142134234"
                  ,@"212341242142134234"
                  ,@"325353534523"];
    
    zxDictionary=@{@"1": zxdataArray,
                  @"2":zxdataArray,
                   @"3":zxdataArray,
                   @"4": zxdataArray,
                   @"5":zxdataArray,
                   @"6":zxdataArray,
                   @"7": zxdataArray,
                   @"8":zxdataArray,
                   @"9":zxdataArray};
    
    
    UITableView *tableViewZX=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 504)];
//    tableViewZX.backgroundColor
    [self.view addSubview:tableViewZX];
    tableViewZX.delegate=self;
    tableViewZX.dataSource=self;
//    tableViewZX.style=UITableViewStyleGrouped;
    
    
//    valueArray=[zxDictionary allValues];
    
    NSArray *array =[[zxDictionary allKeys] copy];
    
    keyArray=[array sortedArrayUsingSelector:@selector(compare:)];
    
    

    viewTitle=[[viewtitleTable alloc]initWithFrame:CGRectMake(0, 68, 110, 495)];
    [self.view addSubview:viewTitle  ];
    viewTitle.dic=zxDictionary;
    [viewTitle addTitle:keyArray];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [keyArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    return [[zxDictionary objectForKey:keyArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel *labelViw;
    if (nil==Cell) {
        Cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        labelViw=[[UILabel alloc]initWithFrame:CGRectMake(110, 0, 210, 110)];
        [Cell.contentView addSubview:labelViw];
    }
//    labelViw.text = zxdataArray[indexPath.row];
//    NSArray *anny=[zxDictionary objectForKey:keyArray[indexPath.section]];
    labelViw.text=[zxDictionary objectForKey:keyArray[indexPath.section]][indexPath.row] ;
    return Cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 110;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return keyArray[section];
//}
//- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    //  如果是搜索状态，则不显示索引条
//    
//    return keyArray;
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [viewTitle moveTitleFrame:scrollView.contentOffset.y];

}


@end
