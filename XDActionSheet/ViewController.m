//
//  ViewController.m
//  XDActionSheet
//
//  Created by  小钉钯 on 2017/5/8.
//  Copyright © 2017年 SH_iOS. All rights reserved.
//

#define REUSERCELLID  @"cell"
#import "XDActionSheet.h"
#import "ViewController.h"

@interface ViewController ()<XDActionSheetDatasource,XDActionSheetDelegate>
@property(nonatomic,strong)XDActionSheet *sheet;
@property(nonatomic,strong)NSArray *titleArrary;


@end

@implementation ViewController
- (IBAction)click:(UIButton *)sender {
    self.titleArrary = @[@"相册",@"拍照",@"取消"];
    [self sheet];
    [_sheet actionSheetShow:self.titleArrary.count];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
}
static NSString *reuserId = @"cell";
- (XDActionSheet *)sheet{
    _sheet = [[XDActionSheet alloc]initWithFrame:CGRectZero];
    _sheet.delegate = self;
    _sheet.datasource = self;
    [_sheet registerClass:[UITableViewCell class] forCellReuseIdentifier:REUSERCELLID];
    
    [self.view addSubview:_sheet];
    return _sheet;
}

- (NSInteger)popoverListView:(XDActionSheet *)sheet numberOfRowsInSection:(NSInteger)section{
    
    
    return  self.titleArrary.count - 1;
    
}

- (UITableViewCell *)popoverListView:(XDActionSheet *)sheet cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [sheet dequeueReusablePopoverCellWithIdentifier:REUSERCELLID];
        
        cell.textLabel.text = self.titleArrary[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.row < self.titleArrary.count - 2) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, [UIScreen mainScreen].bounds.size.width,0.5)];
            line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            

            [cell addSubview:line];
        }
       
        return cell;

    }else{
        UITableViewCell *cell = [sheet dequeueReusablePopoverCellWithIdentifier:REUSERCELLID];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];

        cell.textLabel.text = [self.titleArrary lastObject];
        return cell;
        
    }
    
    
}


- (void)popoverListView:(XDActionSheet *)sheet didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//相册
            

        }else{//拍照
            
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
