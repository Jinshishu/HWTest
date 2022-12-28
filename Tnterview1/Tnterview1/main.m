//
//  main.m
//  Tnterview1
//
//  Created by 金诗书 on 2022/7/9.
//

#import <Foundation/Foundation.h>

NSMutableArray *arr;

BOOL test(NSArray *arr, NSArray *start, NSArray *end) {
    // 二维数组的大小
    NSInteger y = arr.count;
    NSArray *ar = arr[0];
    NSInteger x = ar.count;
    
    // 当前起始值
    NSInteger x1 = [start[0] integerValue];
    NSInteger y1 = [start[1] integerValue];
    
    NSInteger x2 = [end[0] integerValue];
    NSInteger y2 = [end[1] integerValue];
    
    // 起始值上下左右 位置的值
    if (y1 > 0) {
        NSInteger uy1 = y1 - 1;
        NSArray *uArr = @[@(x1), @(uy1)];
        
        if (x2 == x1 && y2 == uy1) {
            NSNumber *a = arr[y2][x2];
            if ([a integerValue] == 0) {
                return YES;
            } else {
                return NO;
            }
        }
        NSNumber *a = arr[uy1][x1];
        if ([a integerValue] == 0) {
            BOOL r = test(arr, uArr, end);
            if (r) {
                return YES;
            }
        }
    }
    
    if (y1 + 1 < y) {
        NSInteger dy1 = y1 + 1;
        NSArray *dArr = @[@(x1), @(dy1)];
        
        if (x2 == x1 && y2 == dy1) {
            NSNumber *a = arr[y2][x2];
            if ([a integerValue] == 0) {
                return YES;
            } else {
                return NO;
            }
        }
        NSNumber *a = arr[dy1][x1];
        if ([a integerValue] == 0) {
            BOOL r = test(arr, dArr, end);
            if (r) {
                return YES;
            }
        }
    }
    
    if (x1 > 0) {
        NSInteger lx1 = x1 - 1;
        NSArray *lArr = @[@(lx1), @(y1)];
        if (x2 == lx1 && y2 == y1) {
            NSNumber *a = arr[y2][x2];
            if ([a integerValue] == 0) {
                return YES;
            } else {
                return NO;
            }
        }
        NSNumber *a = arr[y1][lx1];
        if ([a integerValue] == 0) {
            BOOL r = test(arr, lArr, end);
            if (r) {
                return YES;
            }
        }
    }
    
    if (x1 + 1 < x) {
        NSInteger rx1 = x1 + 1;
        NSArray *rArr = @[@(rx1), @(y1)];
        if (x2 == rx1 && y2 == y1) {
            NSNumber *a = arr[y2][x2];
            if ([a integerValue] == 0) {
                return YES;
            } else {
                return NO;
            }
        }
        NSNumber *a = arr[y1][rx1];
        if ([a integerValue] == 0) {
            BOOL r = test(arr, rArr, end);
            if (r) {
                return YES;
            }
        }
    }
    return NO;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
    }
    return 0;
}
