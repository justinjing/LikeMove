//
//  LMSportBLDelegate.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LMSportBLDelegate <NSObject>

@optional
-(void)stepCountChange:(NSString*) stepCount ;
-(void)sportTimeChange:(int)sportTime;
-(void)getMonthMoveDaysSuccess:(NSInteger)days;
-(void)getWeekRecordSuccess:(NSArray *)steps withWeeks:(NSArray*)weeks;
@end
