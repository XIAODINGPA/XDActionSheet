//
//  XDActionSheet.h
//  XDActionSheet
//
//  Created by 小钉钯 on 2017/5/8.
//  Copyright © 2017年 SH_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDActionSheet;

/**
 数据源
 */
@protocol XDActionSheetDatasource <NSObject>


/**
 设置第一组cell数量

 @param sheet XDActionSheet
 @param section 组数
 @return 第一组cell数量
 */
- (NSInteger)popoverListView:(XDActionSheet *)sheet numberOfRowsInSection:(NSInteger)section;


/**
 设置cell 可自定义cell

 @param sheet XDActionSheet
 @param indexPath indexPath
 @return cell
 */
- (UITableViewCell *)popoverListView:(XDActionSheet *)sheet cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 代理方法
 */
@protocol XDActionSheetDelegate <NSObject>

/**
 点击cell

 @param sheet XDActionSheet
 @param indexPath indexPath
 */
- (void)popoverListView:(XDActionSheet *)sheet didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface XDActionSheet : UIControl
@property (nonatomic, weak) id <XDActionSheetDelegate>delegate;
@property (nonatomic, retain) id <XDActionSheetDatasource>datasource;

//列表cell的重用
- (id)dequeueReusablePopoverCellWithIdentifier:(NSString *)identifier;

- (UITableViewCell *)popoverCellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 注册cell

 @param cellClass UITabelViewCell 可自定义
 @param identifier cell 重用id
 */
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *_Nullable)identifier;


/**
 XDActionSheet 弹出
 count 用来计算tableView 的高度
 @param count 标题数量
 */
- (void)actionSheetShow:(NSInteger)count;

/**
 XDActionSheet 消失
 */
- (void)actionSheetDissmiss;
@end
