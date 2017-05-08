//
//  XDActionSheet.m
//  XDActionSheet
//
//  Created by  小钉钯 on 2017/5/8.
//  Copyright © 2017年 SH_iOS. All rights reserved.
//
static const float  tableviewCellHeight = 40;

//屏幕宽
#define SCREENW     [UIScreen mainScreen].bounds.size.width
//屏幕高
#define SCREENH     [UIScreen mainScreen].bounds.size.height
//字体
#define KFONT(font) [UIFont systemFontOfSize:font]


#import "XDActionSheet.h"
@interface XDActionSheet()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tabView;
@property(nonatomic,assign)NSInteger counts;



@end

@implementation XDActionSheet

- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0, 0, SCREENW, SCREENH);
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addTarget:self action:@selector(actionSheetDissmiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}


- (UITableView *)tabView{
    if(!_tabView){
        
        _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0,SCREENH,SCREENW ,SCREENH) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.scrollEnabled = YES;
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tabView];
    }
    
    return _tabView;
}


#pragma mark - UITableViewDatasource
#pragma mark - 共2组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
#pragma mark - 设置每组cell 高度
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.datasource && [self.datasource respondsToSelector:@selector(popoverListView:numberOfRowsInSection:)])
        {
            return [self.datasource popoverListView:self numberOfRowsInSection:section];
        }
    }else{
        
        return 1;
    }
   
    return 0;
}

#pragma mark - 设置cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return  tableviewCellHeight;
}
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datasource && [self.datasource respondsToSelector:@selector(popoverListView:cellForRowAtIndexPath:)])
    {
        return [self.datasource popoverListView:self cellForRowAtIndexPath:indexPath];
    }
    return  nil;
}

#pragma mark - 设置组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}
#pragma mark - 设置尾部高度为0
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
#pragma mark - 设置组头背景颜色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW,10)];
    view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    return view;
}
#pragma mark - UITableViewDelegate 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListView:didSelectRowAtIndexPath:)])
    {   [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.delegate popoverListView:self didSelectRowAtIndexPath:indexPath];
    }
    [self actionSheetDissmiss];
}

#pragma mark - Reuse Cycle
- (id)dequeueReusablePopoverCellWithIdentifier:(NSString *)identifier
{
    return [self.tabView dequeueReusableCellWithIdentifier:identifier];
}

- (UITableViewCell *)popoverCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tabView cellForRowAtIndexPath:indexPath];
}

#pragma mark - 注册cell
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *_Nullable)identifier{
    [self.tabView registerClass:cellClass forCellReuseIdentifier:identifier];
}

#pragma mark - 页面弹出
- (void)actionSheetShow:(NSInteger)count{
    
    [self tabView];
    CGRect frame =  self.tabView.frame;
    frame.origin.y  = SCREENH - count * tableviewCellHeight - 10;
    self.counts = count;
    frame.size.height = count * tableviewCellHeight + 10;
    [UIView animateWithDuration:.2 animations:^{
        
        self.tabView.frame = frame;
        
    } completion:^(BOOL finished){
        
        [self.tabView reloadData];
        
        
    }];
   

}

#pragma mark - 页面消失
- (void)actionSheetDissmiss{
    CGRect frame =  self.tabView.frame;
    frame.origin.y  = SCREENH ;
 
    [UIView animateWithDuration:.2 animations:^{
        
        self.tabView.frame = frame;
        self.alpha = 0;
    } completion:^(BOOL finished){
   
        [self removeFromSuperview];

        
    }];

}


@end
