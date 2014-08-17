//
//  hengXiang.m
//  picker
//
//  Created by zhang on 14-8-7.
//  Copyright (c) 2014年 zhang. All rights reserved.
//

#import "hengXiang.h"

#define scrollHeight 462

#define orientation 1
@interface hengXiang ()
@property(nonatomic,retain)UIScrollView *scrollView;

@end

@implementation hengXiang
{
    NSArray *imageArray;
    NSInteger _totalPages;
    NSInteger _curPage;
    CGSize _pageSize;
    NSMutableArray *_cells;
    NSRange _visibleRange;
    NSMutableArray      *_reusableCells;
    CGFloat _minimumPageAlpha;
    CGFloat _minimumPageScale;

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
    imageArray = @[@"0.tiff",@"1.tiff",@"2.tiff",@"3.tiff",@"4.tiff",@"5.tiff",@"6.tiff",@"7.tiff"];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 86, 320, 462)];
    [self.view addSubview:_scrollView];
  
    _scrollView.backgroundColor=[UIColor orangeColor];
    _scrollView.contentSize=CGSizeMake(320, scrollHeight/5*7);
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.contentOffset=CGPointMake(0, scrollHeight/5);
    _scrollView.delegate=self;
    _pageSize=CGSizeMake(320, 110);
    _visibleRange=NSMakeRange(0, 0);
    
    _reusableCells = [[NSMutableArray alloc] initWithCapacity:0];
    _cells = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    _minimumPageAlpha=0.3;
    _minimumPageScale=0.9;
    
    for (int i=0; i<7; i++) {
        [_scrollView addSubview:[self cellForPageAtIndex:i]];
    }
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1 ) value = _totalPages - 1;
    if(value == _totalPages+1) value = 1;
    if (value == _totalPages+2) value = 2;
    if(value == _totalPages+3) value = 3;
    if (value == _totalPages+4) value = 4;
    if(value == _totalPages) value = 0;
    
    
    return value;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)zxScrollView
{
    [self setPagesAtContentOffset:zxScrollView.contentOffset];
    [self refreshVisibleCellAppearance];
    
    int y = zxScrollView.contentOffset.y;
    NSInteger page = zxScrollView.contentOffset.y/((scrollHeight/5));
//    NSLog(@"第%d%ldd,pag(long)e(long));
    
    if (y>2*scrollHeight/5) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    if (y<=0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }


//    if (page>1 || page <=0) {
//        [self setAfterScrollShowView:zxScrollView andCurrentPage:1];
//    }
//    if ([_delegate respondsToSelector:@selector(scrollviewDidChangeNumber)]) {
//        [_delegate scrollviewDidChangeNumber];
//    }

}

- (void)refreshVisibleCellAppearance{
    
    if (_minimumPageAlpha == 1.0 && _minimumPageScale == 1.0) {
        return;//无需更新
    }
    switch (orientation) {
        case 0:{
            CGFloat offset = _scrollView.contentOffset.x;
            
            for (int i = _visibleRange.location; i < _visibleRange.location + _visibleRange.length; i++) {
                UIView *cell = [_cells objectAtIndex:i];
                CGFloat origin = cell.frame.origin.x;
                CGFloat delta = fabs(origin - offset);
                
                CGRect originCellFrame = CGRectMake(_pageSize.width * i, 0, _pageSize.width, _pageSize.height);//如果没有缩小效果的情况下的本该的Frame
                
                [UIView beginAnimations:@"CellAnimation" context:nil];
                if (delta < _pageSize.width) {
                    cell.alpha = 1 - (delta / _pageSize.width) * (1 - _minimumPageAlpha);
                    
                    CGFloat inset = (_pageSize.width * (1 - _minimumPageScale)) * (delta / _pageSize.width)/2.0;
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                } else {
                    cell.alpha = _minimumPageAlpha;
                    CGFloat inset = _pageSize.width * (1 - _minimumPageScale) / 2.0 ;
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                }
                [UIView commitAnimations];
            }
            break;
        }
        case 1:{
            CGFloat offset = _scrollView.contentOffset.y;
            
            for (int i = _visibleRange.location; i < _visibleRange.location + _visibleRange.length; i++) {
                UIView *cell = [_cells objectAtIndex:i];
                CGFloat origin = cell.frame.origin.y;
                CGFloat delta = fabs(origin - offset);
                
                CGRect originCellFrame = CGRectMake(0, _pageSize.height * i, _pageSize.width, _pageSize.height);//如果没有缩小效果的情况下的本该的Frame
                
                [UIView beginAnimations:@"CellAnimation" context:nil];
                if (delta < _pageSize.height) {
                    cell.alpha = 1 - (delta / _pageSize.height) * (1 - _minimumPageAlpha);
                    
                    CGFloat inset = (_pageSize.height * (1 - _minimumPageScale)) * (delta / _pageSize.height)/2.0;
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                } else {
                    cell.alpha = _minimumPageAlpha;
                    CGFloat inset = _pageSize.height * (1 - _minimumPageScale) / 2.0 ;
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                }
                [UIView commitAnimations];
            }
        }
        default:
            break;
    }
    
}

- (UIView *)dequeueReusableCell{
    UIView *cell = [_reusableCells lastObject];
    if (cell)
    {
        [_reusableCells removeLastObject];
    }
    
    return cell ;
}


- (void)loadData
{
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
//    [self getDisplayImagesWithCurpage:_curPage];
//    
//    for (int i = 0; i < 7; i++) {
//        UIView *v = [_curViews objectAtIndex:i];
//        //        v.userInteractionEnabled = YES;
//        //        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
//        //                                                                                    action:@selector(handleTap:)];
//        //        [v addGestureRecognizer:singleTap];
//        v.frame = CGRectOffset(v.frame, 0, v.frame.size.height * i );
//        [_scrollView addSubview:v];
//    }
    
    [_scrollView setContentOffset:CGPointMake( 0, scrollHeight/5 )];
}

- (void)setPagesAtContentOffset:(CGPoint)offset{
    //计算_visibleRange
    CGPoint startPoint = CGPointMake(offset.x - _scrollView.frame.origin.x, offset.y - _scrollView.frame.origin.y);
    CGPoint endPoint = CGPointMake(startPoint.x + _scrollView.bounds.size.width, startPoint.y + _scrollView.bounds.size.height);
    
    
    switch (orientation) {
        case 0:{
            NSInteger startIndex = 0;
            //            NSUInteger startIndex = 0;
            for (int i =0; i < [_cells count]; i++) {
                if (_pageSize.width * (i +1) > startPoint.x) {
                    startIndex = i;
                    break;
                }
            }
            
            NSInteger endIndex = startIndex;
            //            for (int i = startIndex;
            for (NSUInteger i = startIndex;
                 i < [_cells count]; i++) {
                //如果都不超过则取最后一个
                if ((_pageSize.width * (i + 1) < endPoint.x && _pageSize.width * (i + 2) >= endPoint.x) || i+ 2 == [_cells count]) {
                    endIndex = i + 1;//i+2 是以个数，所以其index需要减去1
                    break;
                }
            }
            
            //可见页分别向前向后扩展一个，提高效率
            startIndex = MAX(startIndex - 1, 0);
            endIndex = MIN(endIndex + 1, [_cells count] - 1);
            
            _visibleRange.location = startIndex;
            _visibleRange.length = endIndex - startIndex + 1;
            
            for (NSUInteger i = startIndex; i <= endIndex; i++) {
                [self setPageAtIndex:i];
            }
            
            for (NSUInteger i = 0; i < startIndex; i ++) {
                [self removeCellAtIndex:i];
            }
            
            for (NSUInteger i = endIndex + 1; i < [_cells count]; i ++) {
                [self removeCellAtIndex:i];
            }
            break;
        }
        case 1:{
            NSInteger startIndex = 0;
            for (int i =0; i < [_cells count]; i++) {
                if (_pageSize.height * (i +1) > startPoint.y) {
                    startIndex = i;
                    break;
                }
            }
            
            NSInteger endIndex = startIndex;
            for (NSUInteger i = startIndex; i < [_cells count]; i++) {
                //如果都不超过则取最后一个
                if ((_pageSize.height * (i + 1) < endPoint.y && _pageSize.height * (i + 2) >= endPoint.y) || i+ 2 == [_cells count]) {
                    endIndex = i + 1;//i+2 是以个数，所以其index需要减去1
                    break;
                }
            }
            
            //可见页分别向前向后扩展一个，提高效率
            startIndex = MAX(startIndex - 1, 0);
            endIndex = MIN(endIndex + 1, [_cells count] - 1);
            
            _visibleRange.location = startIndex;
            _visibleRange.length = endIndex - startIndex + 1;
            
            for (NSUInteger i = startIndex; i <= endIndex; i++) {
                [self setPageAtIndex:i];
            }
            
            for (NSUInteger i = 0; i < startIndex; i ++) {
                [self removeCellAtIndex:i];
            }
            
            for (NSUInteger i = endIndex + 1; i < [_cells count]; i ++) {
                [self removeCellAtIndex:i];
            }
            break;
        }
        default:
            break;
    }
    
    
    
}

- (void)setPageAtIndex:(NSInteger)pageIndex{
    NSParameterAssert(pageIndex >= 0 && pageIndex < [_cells count]);
    
    UIView *cell = [_cells objectAtIndex:pageIndex];
    
    if ((NSObject *)cell == [NSNull null]) {
        cell = [self cellForPageAtIndex:pageIndex];
        NSAssert(cell!=nil, @"datasource must not return nil");
        [_cells replaceObjectAtIndex:pageIndex withObject:cell];
        
        
        switch (orientation) {
            case 0:
                cell.frame = CGRectMake(_pageSize.width * pageIndex, 0, _pageSize.width, _pageSize.height);
                break;
            case 1:
                cell.frame = CGRectMake(0, _pageSize.height * pageIndex, _pageSize.width, _pageSize.height);
                break;
            default:
                break;
        }
        
        if (!cell.superview) {
            [_scrollView addSubview:cell];
        }
    }
}

- (void)removeCellAtIndex:(NSInteger)index{
    UIView *cell = [_cells objectAtIndex:index];
    if ((NSObject *)cell == [NSNull null]) {
        return;
    }
    
    [self queueReusableCell:cell];
    
    if (cell.superview) {
        [cell removeFromSuperview];
    }
    
    [_cells replaceObjectAtIndex:index withObject:[NSNull null]];
}
- (void)queueReusableCell:(UIView *)cell{
    [_reusableCells addObject:cell];
}


- (UIView *)cellForPageAtIndex:(NSInteger)index
{
    UIView *viewCell=[[UIView alloc]initWithFrame:CGRectMake(0, index*0, 320, 110)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(120, 0, 200, 110)];
    
    label.text=imageArray[index];
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
