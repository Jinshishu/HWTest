#import <Foundation/Foundation.h>

void HJ1() {
    
        char str[10000];
        gets(str);
        NSString *ocs = [NSString stringWithFormat:@"%s", str];
        NSArray *arr = [ocs componentsSeparatedByString:@","];
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        for (int i = 0; i < arr.count; i++) {
            NSString *s = [arr objectAtIndex:i];
            NSArray *ar = [s componentsSeparatedByString:@":"];
            NSString *key = [ar objectAtIndex:0];
            NSString *val = [ar objectAtIndex:1];
            [arr1 addObject:key];
            [arr2 addObject:val];
        }
        char str1[10000];
        gets(str1);
        NSString *ocs1 = [NSString stringWithFormat:@"%s", str1];
        NSArray *tArr = [ocs1 componentsSeparatedByString:@","];

        for (int i = 0; i < arr1.count; i++) {
            for (int j = 0; j < arr1.count - i - 1; j++) {
                int aj1 = [[arr1 objectAtIndex:j] intValue];
                int aj2 = [[arr1 objectAtIndex:j + 1] intValue];
                if (aj1 > aj2) {
                    [arr1 exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                    [arr2 exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                }
            }
        }

        NSMutableArray *res = [NSMutableArray array];
        for (int j = 0; j < tArr.count; j++) {
            BOOL flag = NO;
            int sub = [[tArr objectAtIndex:j] intValue];
            for (int k = 0; k < arr1.count; k++) {
                int ck = [[arr1 objectAtIndex:k] intValue];
                int cnt = [[arr2 objectAtIndex:k] intValue];
                if (sub <= ck && cnt > 0) {
                    flag = YES;
                    [arr2 replaceObjectAtIndex:k withObject:[@(cnt - 1) stringValue]];
                    break;
                }
            }
            NSString *re = flag ? @"true" : @"false";
            [res addObject:re];
        }
        printf("%s", [res componentsJoinedByString:@","].UTF8String);
}

void HJ2() {
   
    int n, m;
            scanf("%d %d", &n, &m);
            if (n < 1 || n > 100000) {
                printf("NULL");
                return ;
            }
            if (m < 1 || m > 100000) {
                printf("NULL");
                return;
            }
            NSMutableArray *aArr = [NSMutableArray array];
            NSMutableArray *bArr = [NSMutableArray array];
            NSMutableArray *cArr = [NSMutableArray array];
            for (int i = 0; i < m; i++) {
                int a, b, c;
                scanf("%d %d %d", &a, &b, &c);
                [aArr addObject:@(a)];
                [bArr addObject:@(b)];
                [cArr addObject:@(c)];
            }
            NSMutableSet *isTeamSet = [NSMutableSet set];
            for (int i = 0; i< cArr.count; i++) {
                int c = [[cArr objectAtIndex:i] intValue];
                NSString *a = [aArr objectAtIndex:i];
                NSString *b = [bArr objectAtIndex:i];
                if ([a intValue ] > n || [a intValue] < 1 ||  [b intValue ] > n || [b intValue] < 1) {
                    printf("da pian zi\n");
                    continue;
                }
                if (c == 0) {
                    [isTeamSet addObject:a];
                    [isTeamSet addObject:b];
                    printf("we are a team\n");
                    continue;
                }
                if (c == 1) {
                    if ([isTeamSet containsObject:a] && [isTeamSet containsObject:b]) {
//                        printf("we are a team\n");
                    } else {
                        printf("we are not a team\n");
                    }
                    continue;
                }
                if (c > 1) {
                    printf("da pian zi\n");
                }
            }
    
//    for (int i = 0; i< cArr.count; i++) {
//
//    }
}

NSString * calt(NSString *str) {
//    (div 12 (sub 45 45))
    if ([str hasPrefix:@" "]) {
        str = [str substringFromIndex:1];
    }
    if ([str hasSuffix:@" "]) {
        str = [str substringToIndex:str.length - 1];
    }
    // ss = div 12 (sub 45 45);
    NSString *ss = [str substringWithRange:NSMakeRange(1, str.length - 2)];
    // op = div;
    NSString *op = [ss substringWithRange:NSMakeRange(0, 3)];
    NSMutableArray *arr = [NSMutableArray array];
    int num = 0;
    int len = (int)ss.length;
    BOOL flag = NO;
    for (int i = 3; i < len; i++) {
        char c = [ss characterAtIndex:i];
        if (c == '-') {
            flag = YES;
            continue;
        }
        if (isdigit(c)) {
            while (i < len && isdigit([ss characterAtIndex:i])) {
                num = num * 10 + c - '0';
                i++;
            }
            i--;
            if (flag) {
                num = -num;
            }
            [arr addObject:@(num)];
            num = 0;
            flag = NO;
        } else if (c == '(') {
            int j = i;
            int cnt = 0;
            for (; i < len; i++) {
                char c1 = [ss characterAtIndex:i];
                if (c1 == '(') {
                    cnt++;
                } else if (c1 == ')') {
                    cnt--;
                }
                if (cnt == 0) {
                    break;
                }
            }
            NSString *ts = [ss substringWithRange:NSMakeRange(j, i - j + 1)];
            NSString *re = calt(ts);
            if ([re isEqualToString:@"error"]) {
                return @"error";
            }
            num = [re intValue];
            if (flag) {
                num = -num;
            }
            [arr addObject:@(num)];
            num = 0;
            flag = NO;
        }
    }
    
    if ([op isEqualTo:@"add"]) {
        int n1 = [[arr objectAtIndex:0] intValue];
        int n2 = [[arr objectAtIndex:1] intValue];
        return [@(n1 + n2) stringValue];
    }
    if ([op isEqualTo:@"sub"]) {
        int n1 = [[arr objectAtIndex:0] intValue];
        int n2 = [[arr objectAtIndex:1] intValue];
        return [@(n1 - n2) stringValue];
    }
    if ([op isEqualTo:@"mul"]) {
        int n1 = [[arr objectAtIndex:0] intValue];
        int n2 = [[arr objectAtIndex:1] intValue];
        return [@(n1 * n2) stringValue];
    }
    if ([op isEqualTo:@"div"]) {
        int n1 = [[arr objectAtIndex:0] intValue];
        float n2 = [[arr objectAtIndex:1] floatValue];
        if (n2 == 0) {
            return @"error";
        }
        int c = floor(n1 / n2);
        return [@(c) stringValue];
    }
    return @"error";
}

void HJ3() {
    
    char str[512];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSString *nn = calt(ocs);
    printf("%s", nn.UTF8String);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        HJ2();
        
    }
    return 0;
}
