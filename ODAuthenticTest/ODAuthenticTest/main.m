//
//  main.m
//  ODAuthenticTest
//
//  Created by 金诗书 on 2022/6/15.
//

#import <Foundation/Foundation.h>

#pragma mark - 工厂流水线最短时间
//3 5
//8 4 3 2 10
void AT21() {
    // 第一题
//5
//2
//2 4
//1
//10
//3
//2 4 7
//1
    
    int N,M;
    scanf("%d", &N);
    scanf("%d\n", &M);
    char str[1000000];
    gets(str);
    NSString *ocStr = [NSString stringWithFormat:@"%s", str];
    NSArray *dearArr = [ocStr componentsSeparatedByString:@" "];
    int k;
    scanf("%d", &k);
    
    NSMutableArray *liveArr = [NSMutableArray array];
    for (int i = 0; i < N; i++) {
        [liveArr addObject:@(1)];
    }
    
    for (int j = 0; j < dearArr.count; j++) {
        int dn = [[dearArr objectAtIndex:j] intValue];
        [liveArr replaceObjectAtIndex:dn - 1 withObject:@(0)];
    }
    
    int l = 0, r = 0, res = 0;
    for (r = 0; r < N; r++) {
        int nr = [[liveArr objectAtIndex:r] intValue];
        k -= 1 - nr;
        while (k < 0) {
            int nl = [[liveArr objectAtIndex:l] intValue];
            k += 1 - nl;
            l += 1;
        }
        res = MAX(res, r - l + 1);
    }
    printf("%d", res);
    
//    int m,n;
//    scanf("%d %d\n", &m, &n);
//    char str[10000];
//    gets(str);
//    NSString *ocStr = [NSString stringWithFormat:@"%s", str];
//    NSArray *array = [ocStr componentsSeparatedByString:@" "];
//    array = [array sortedArrayUsingSelector:@selector(compare:)];
//
//    NSMutableArray *resArr = [NSMutableArray arrayWithCapacity:m];
////    int tmp = 0;
//    for (int i = 0; i < n; i++) {
////        int nn = [[array objectAtIndex:i] intValue];
////        tmp += nn;
////        [resArr insertObject:@(tmp) atIndex:i % m];
//        resArr[i % m] = @([resArr[i % m] intValue] + [array[i] intValue]);
//    }
//    NSArray *rArr = [resArr sortedArrayUsingSelector:@selector(compare:)];
//    printf("%s", [[rArr objectAtIndex:m - 1] stringValue].UTF8String);
}

#pragma mark - 非严格递增连续数字序列
void AT1() {
    // abc2234019A334bc aaaaaa44ko543j123j7345677781 aaaaa34567778a44ko543j123j71  345678a44ko543j123j7134567778aa
    char str[256];
    scanf("%s", str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    int length = 0;
    int maxL = 0;
    char fc = '0';
    for (int i = 0; i < ocs.length; i++) {
        char c = [ocs characterAtIndex:i];
        // 是数字 且大于等于前一个字符 则符合非严格提增连续数字序列
        if (c >= fc && c <= '9') {
            fc = c;
            length++;
            maxL = MAX(maxL, length);
        } else if (c >= '0' && c <= '9') {
            // 是数字 不符合要求序列
            fc = c;
            length = 1;
        } else {
            // 不是数字
            fc = '0';
            length = 0;
        }
    }
    printf("%d\n", maxL);
}

#pragma mark - 磁盘容量排序
int convertToM(NSString *str) {
    int num = 0;
    int idx = 0;
    for (int i = 0; i < str.length; i++) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *ss = [str substringWithRange:NSMakeRange(idx, i - idx)];
        if ([s isEqualToString:@"T"]) {
            num = num + [ss intValue] * 1024 * 1024;
            idx = i + 1;
        } else if ([s isEqualToString:@"G"]) {
            num = num + [ss intValue] * 1024;
            idx = i + 1;
        } else if ([s isEqualToString:@"M"]) {
            num = num + [ss intValue];
            idx = i + 1;
        }
    }
    return num;
}

void AT2() {
//3
//1G
//2G
//1024M
    int n;
    scanf("%d", &n);
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < n; i++) {
        char str[30];
        scanf("%s", str);
        NSString *ocs = [NSString stringWithFormat:@"%s", str];
        [arr addObject:ocs];
    }
    for (int j = 0; j < arr.count; j++) {
        for (int k = 0; k < arr.count - j - 1; k++) {
            NSString *s1 = [arr objectAtIndex:k];
            NSString *s2 = [arr objectAtIndex:k + 1];
            int sn1 = convertToM(s1);
            int sn2 = convertToM(s2);
            if (sn1 > sn2) {
                [arr exchangeObjectAtIndex:k withObjectAtIndex:k + 1];
            }
        }
    }
    for (NSString *obj in arr) {
        printf("%s\n", obj.UTF8String);
    }
}

#pragma mark - 二叉树中序遍历
int findRightIndex(NSString *str) {
    int idx = 0;
    for (int i = 0; i < str.length; i++) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"{"]) {
            idx += 1;
        } else if ([s isEqualToString:@"}"]) {
            idx -= 1;
        } else if ([s isEqualToString:@","] && idx == 0) {
            return i;
        }
    }
    return -1;
}

NSString *getResult(NSString *str) {
    if ([str containsString:@"{"]) {
        NSString *h0 = [str substringWithRange:NSMakeRange(0, 1)];
        NSString *sub = [str substringWithRange:NSMakeRange(2, str.length - 1 - 2)];
        NSString *s1 = @"";
        NSString *s2 = @"";
        int idx = findRightIndex(sub);
        if (idx != -1) {
            s1 = [sub substringToIndex:idx];
            s2 = [sub substringFromIndex:idx + 1];
        } else {
            s1 = sub;
        }
        return [getResult(s1) stringByAppendingFormat:@"%@%@", h0, getResult(s2)];
    }
    return str;
}

void AT3() {
    // a{b{d,e{g,h{,i}}},c{f}}
    char str[10000];
    scanf("%s", str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    printf("%s\n", getResult(ocs).UTF8String);
}

#pragma mark - 靠谱的车
void AT4() {
//    int n;
//    scanf("%d", &n);
//    int cnt = 0;
//    for (int i = 1; i < n; i++) {
//        NSString *s = [@(i) stringValue];
//        if ([s containsString:@"4"]) {
//            cnt += 1;
//        }
//    }
//    printf("%d\n", n - cnt);
    // 9进制 转 10进制
    int n;
    scanf("%d", &n);
    int ans = n;    // 计价表要付的钱数
    int tmp = 0;    // 跳4次数
    int k = 0;      // 跳4次数
    int j = 1;      // 表示位数， 1：个位 10：十位 100：百位...
    while (n > 0) {
        if (n % 10 > 4) {
            tmp += (n % 10 - 1) * k + j;
        } else {
            tmp += (n % 10) * k;
        }
        k = k % 9 + j;
        j *= 10;
        n /= 10;
    }
    printf("%d\n", ans - tmp);
}

#pragma mark - VLAN资源池
void AT5() {
    char str[5000];
    scanf("%s", str);
    int vid;
    scanf("%d", &vid);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSArray *array = [ocs componentsSeparatedByString:@","];
    NSMutableArray *vArr = [NSMutableArray array];
    for (NSString *obj in array) {
        if ([obj containsString:@"-"]) {
            NSArray *aa = [obj componentsSeparatedByString:@"-"];
            // 连续vlan格式  3-5: 3个vlan 3,4,5
            int begin = [[aa objectAtIndex:0] intValue];
            int end = [[aa objectAtIndex:1] intValue];
            if (begin == vid) {
                NSString *s = [[@(begin + 1) stringValue] stringByAppendingFormat:@"-%d",end];
                [vArr addObject:s];
            } else if (end == vid) {
                NSString *s = [[@(begin) stringValue] stringByAppendingFormat:@"-%d", (end - 1)];
                [vArr addObject:s];
            } else if (begin + 1 == vid) {
                NSString *s1 = [@(begin) stringValue];
                [vArr addObject:s1];
                NSString *s2 = [[@(vid + 1) stringValue] stringByAppendingFormat:@"-%d", end];
                [vArr addObject:s2];
            } else if (end - 1 == vid) {
                NSString *s1 = [[@(begin) stringValue] stringByAppendingFormat:@"-%d",vid - 1];
                [vArr addObject:s1];
                NSString *s2 = [@(vid + 1) stringValue];
                [vArr addObject:s2];
            } else if (vid > begin && vid < end) {
                NSString *s1 = [[@(begin) stringValue] stringByAppendingFormat:@"-%d",vid - 1];
                [vArr addObject:s1];
                NSString *s2 = [[@(vid + 1) stringValue] stringByAppendingFormat:@"-%d", end];
                [vArr addObject:s2];
            } else {
                [vArr addObject:obj];
            }
//            int cnt = end - begin + 1;
//            for (int i = 0; i < cnt; i++) {
//                int cn = begin + i;
//                if (cn == vid) {
//                    continue;
//                }
//                [vArr addObject:[@(cn) stringValue]];
//            }
        } else {
            if ([obj intValue] == vid) {
                continue;
            }
            [vArr addObject:obj];
        }
    }

    for (int i = 0; i < vArr.count; i++) {
        for (int j = 0; j < vArr.count - i - 1; j++) {
            NSString *s1 = [vArr objectAtIndex:j];
            NSString *s2 = [vArr objectAtIndex:j + 1];
            int c1, c2;
            if ([s1 containsString:@"-"]) {
                c1 = [[s1 componentsSeparatedByString:@"-"][0] intValue];
            } else {
                c1 = [s1 intValue];
            }
            if ([s2 containsString:@"-"]) {
                c2 = [[s2 componentsSeparatedByString:@"-"][0] intValue];
            } else {
                c2 = [s2 intValue];
            }
            if (c1 > c2) {
                [vArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    printf("%s\n", [vArr componentsJoinedByString:@","].UTF8String);
}

#pragma mark - 目录删除
//5
//8 6
//10 8
//6 0
//20 8
//2 6
//8
NSMutableArray *deleteNode(NSMutableArray *allIDArr, NSDictionary *dic, int tID) {
    [allIDArr removeObject:@(tID)];
    NSMutableDictionary *dict = dic.mutableCopy;
    for (NSNumber *key in dict.allKeys) {
        // 删除的是个父节点
        if ([key intValue] == tID) {
            [dict removeObjectForKey:key];
            // 清除当前父节点下的子节点所有的节点
            NSMutableArray *arr = [dic objectForKey:key];
            [allIDArr removeObjectsInArray:arr];
            for (NSNumber *sid in arr) {
                allIDArr = deleteNode(allIDArr, dict, [sid intValue]);
            }
        }
    }
    [allIDArr removeObject:@(0)];
    return allIDArr;
}
void AT6() {
    int n;
    scanf("%d", &n);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableSet *allIDSet = [NSMutableSet set];
    for (int i = 0; i < n; i++) {
        int a, b;
        scanf("%d %d", &a, &b);
        NSMutableArray *arr = [dic objectForKey:@(b)];
        if (!arr) {
            arr = [NSMutableArray array];
        }
        [arr addObject:@(a)];
        [dic setObject:arr forKey:@(b)];
        [allIDSet addObject:@(a)];
        [allIDSet addObject:@(b)];
    }
    int tID;
    scanf("%d", &tID);
    NSMutableArray *allIDArr = [allIDSet allObjects].mutableCopy;
    NSMutableArray *tArr = deleteNode(allIDArr, dic, tID);
    NSArray *sArr = [tArr sortedArrayUsingSelector:@selector(compare:)];
    printf("%s\n", [sArr componentsJoinedByString:@" "].UTF8String);
    
}

#pragma mark - 二叉树的广度优先遍历
typedef struct Tree {
    NSString *data;
    struct Tree *leftTree;
    struct Tree *rightTree;
} Node;

NSString *str;
Node *createNode(NSString *str1, NSString *str2) {
    if (str1.length == 0) {
        // 后序序列遍历结束
        return NULL;
    }
    if (str2.length == 0) {
        // 中序序列遍历结束
        return NULL;
    }
    // 先从后序序列中取节点
    NSString *val = [str1 substringWithRange:NSMakeRange(str1.length - 1, 1)];
    str = [str1 substringWithRange:NSMakeRange(0, str1.length - 1)];
    // 从中序序列中找到该节点的左右子树中序列
    NSRange range = [str2 rangeOfString:val];
    NSString *left, *right;
    if (range.length == 0) {
        left = @"";
        right = @"";
    } else {
        left = [str2 substringToIndex:range.location];
        right = [str2 substringFromIndex:range.location + 1];
    }
    
    // 递归生成节点
    Node *nd = (Node *)malloc(sizeof(Node));
    nd->data = val;
    nd->rightTree = createNode(str, right);
    nd->leftTree = createNode(str, left);
    return nd;
}

// 先序遍历 dlr
void preorderTraversal(Node *nd) {
    if (nd == NULL) {
        return;
    }
    printf("%s", nd->data.UTF8String);
    if (nd->leftTree) {
        preorderTraversal(nd->leftTree);
    }
    if (nd->rightTree) {
        preorderTraversal(nd->rightTree);
    }
}

// 中序遍历 ldr
void inorderTraversal(Node *nd) {
    if (nd == NULL) {
        return;
    }
    if (nd->leftTree) {
        inorderTraversal(nd->leftTree);
    }
    printf("%s", nd->data.UTF8String);
    if (nd->rightTree) {
        inorderTraversal(nd->rightTree);
    }
}

// 后序遍历 lrd
void postorderTransversa(Node *nd) {
    if (nd == NULL) {
        return;
    }
    if (nd->leftTree) {
        postorderTransversa(nd->leftTree);
    }
    if (nd->rightTree) {
        postorderTransversa(nd->rightTree);
    }
    printf("%s", nd->data.UTF8String);
}

// 层次遍历
void levelOrderTraverl(Node *nd) {
    if (nd == NULL) {
        return;
    }
    // 申请临时数组 保存下一个节点
    Node **nodes = (Node **)calloc(10000, sizeof(Node *));
    nodes[0] = nd;
    int pre = 0;
    int pos = 1;
    while (pos > pre) {
        int num = pos - pre;
        for (int i = 0; i < num; i++) {
            printf("%s", nodes[i + pre]->data.UTF8String);
            if (nodes[i + pre]->leftTree != NULL) {
                nodes[pos++] = nodes[i + pre]->leftTree;
            }
            if (nodes[i + pre]->rightTree != NULL) {
                nodes[pos++] = nodes[i + pre]->rightTree;
            }
        }
        pre += num;
    }
    free(nodes);
}

//CBEFDA CBAEDF===>ABDCEF
void AT9() {
    char str1[26], str2[26];
    scanf("%s %s", str1, str2);
    NSString *backStr = [NSString stringWithFormat:@"%s", str1];
    NSString *midStr = [NSString stringWithFormat:@"%s", str2];
    
    Node *tree = createNode(backStr, midStr);
    levelOrderTraverl(tree);
    printf("\n");
    preorderTraversal(tree);
    printf("\n");
    inorderTraversal(tree);
    printf("\n");
    postorderTransversa(tree);
    
}

#pragma mark - 消消乐游戏
// mMbccbc
void AT10() {
    char str[1000];
    scanf("%s", str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < ocs.length; i++) {
        NSString *s = [ocs substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:[arr lastObject]]) {
            [arr removeLastObject];
        } else {
            [arr addObject:s];
        }
    }
    printf("%lu", (unsigned long)arr.count);
}

#pragma mark - 找终点
// 7 5 9 4 2 6 8 3 5 4 3 9 -> 2
// 1 2 3 7 1 5 9 3 2 1 -> -1
void AT11() {
    char num[1000];
    gets(num);
    NSString *ocs = [NSString stringWithFormat:@"%s", num];
    NSArray *arr = [ocs componentsSeparatedByString:@" "];
    int l = (int)arr.count / 2;
    int res = INT_MAX;
    for (int i = 1; i < l; i++) {
        int sum = i;
        int cnt = 1;
        while (sum < arr.count - 1) {
            sum = sum + [[arr objectAtIndex:sum] intValue];
            cnt += 1;
        }
        if (sum == arr.count - 1) {
            res = MIN(cnt, res);
        }
    }
    if (res == INT_MAX) {
        printf("-1\n");
    } else {
        printf("%d\n", res);
    }
}

#pragma mark - 分月饼
// 2 4  -> 2
int distribute(int m, int p, int k) {
    if (p <= 0) {
        return 0;;
    }
    if (m <= 0) {
        return 0;
    }
    if (m == 1) {
        if (p >= k && p <= k + 3) {
            return 1;
        }
        return 0;
    }
    int ncount=0;
    for (int i = k; i <= k+3; i++) {
        ncount = ncount + distribute(m-1, p-i, i);
    }
    return ncount;
}

void AT12() {
    int m, n;
    scanf("%d %d", &m, &n);
    int p = n - m;
    int count = 0;
    
    for(int i = 0;i < p; i++) {
        count = count + distribute(m - 1, p - i, i);
    }
    printf("%d", count);
}

#pragma mark - 工号不够用了怎么办
// 260 1
void AT13() {
    int x, y;
    scanf("%d %d", &x, &y);
    if (x <= 26) {
        printf("1");
        return;
    }
    int del = 1;
    for (int i = 0; i < y; i++) {
        del *= 26;
    }
    int r = 1;
    del *= 10;
    while (del < x) {
        del *= 10;
        r++;
    }
    printf("%d", r);
}

#pragma mark - 火锅
void AT14() {
    
}

#pragma mark - 找朋友
//2
//100 95 -> 0 0
//8
//123 124 125 121 119 122 126 123 -> 1 2 6 5 5 6 0 0
void AT15() {
    int n;
    scanf("%d\n", &n);
    char h[1000];
    gets(h);
    NSString *ocs = [NSString stringWithFormat:@"%s", h];
    NSArray *hArr = [ocs componentsSeparatedByString:@" "];
    
    NSMutableArray *fArr = [NSMutableArray array];
    for (int j = 0; j < hArr.count; j++) {
        NSNumber *f = @(0);
        for (int k = j + 1; k < hArr.count; k++) {
            int h1 = [[hArr objectAtIndex:j] intValue];
            int h2 = [[hArr objectAtIndex:k] intValue];
            if (h2 > h1) {
                f = @(k);
                break;
            }
        }
        [fArr addObject:f];
    }
    printf("%s\n", [fArr componentsJoinedByString:@" "].UTF8String);
}

#pragma mark - 最大花费金额
//23,26,36,27
//78
void AT16() {
    char str[10000];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSArray *arr = [ocs componentsSeparatedByString:@","];
    
    int n;
    scanf("%d", &n);
    int max = -1;
    for (int i = 0; i < arr.count; i++) {
        for (int j = i + 1; j < arr.count; j++) {
            for (int k = j + 1; k < arr.count; k++) {
                int k1 = [[arr objectAtIndex:i] intValue];
                int k2 = [[arr objectAtIndex:j] intValue];
                int k3 = [[arr objectAtIndex:k] intValue];
                int sum = k1 + k2 + k3;
                if (sum <= n) {
                    max = MAX(sum, max);
                }
            }
        }
    }
    printf("%d", max);
}

#pragma mark - 最大值
// str1是否小于str2
BOOL compareStr(NSString *str1, NSString *str2) {
    NSString *s1 = [str1 stringByAppendingString:str2];
    NSString *s2 = [str2 stringByAppendingString:str1];
    
    return [s1 intValue] < [s2 intValue];
    
//    if (str1.length > str2.length) {
//        // str1=3, str=34 -> str1=33, str2=34
//        // 取短子串即str2的最后一位
//        NSString *lastS = [str2 substringWithRange:NSMakeRange(str2.length - 1, 1)];
//        NSInteger len = str1.length - str2.length;
//        for (int i = 0; i < len; i++) {
//            str2 = [str2 stringByAppendingString:lastS];
//        }
//        if ([str1 intValue] < [str2 intValue]) {
//            return YES;
//        }
//        return NO;
//    }
//    NSString *lastS = [str1 substringWithRange:NSMakeRange(str1.length - 1, 1)];
//    NSInteger len = str2.length - str1.length;
//    for (int i = 0; i < len; i++) {
//        str1 = [str1 stringByAppendingString:lastS];
//    }
//    if ([str1 intValue] < [str2 intValue]) {
//        return YES;
//    }
//    return NO;
}
// 1,20,23,4,8 => 8423201
// 3,30,34,5,9 => 9534330
void AT17() {
    char str[1000];
    scanf("%s", str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSMutableArray *arr = [ocs componentsSeparatedByString:@","].mutableCopy;
    for (int i = 0; i < arr.count; i++) {
        for (int j = 0; j < arr.count - i - 1; j++) {
            NSString *str1 = [arr objectAtIndex:j];
            NSString *str2 = [arr objectAtIndex:j + 1];
            if (compareStr(str1, str2)) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    printf("%s\n", [arr componentsJoinedByString:@""].UTF8String);
}

#pragma mark - 寻找身高相近的小朋友
//100 10
//95 96 97 98 99 101 102 103 104 105   => 99 101 98 102 97 103 96 104 95 105
void AT18() {
    int h, n;
    scanf("%d %d\n", &h, &n);
    char str[1000];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSArray *arr = [ocs componentsSeparatedByString:@" "];
    NSMutableArray *hArr = [NSMutableArray array];
    NSMutableArray *lArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        int a = [[arr objectAtIndex:i] intValue];
        int b = abs(h - a);
        [hArr addObject:@(a)];
        [lArr addObject:@(b)];
    }
    
    for (int j = 0; j < lArr.count; j++) {
        for (int k = 0; k < lArr.count - j - 1; k++) {
            int aa = [[lArr objectAtIndex:k] intValue];
            int bb = [[lArr objectAtIndex:k + 1] intValue];
            if (aa > bb) {
                [lArr exchangeObjectAtIndex:k withObjectAtIndex:k + 1];
                [hArr exchangeObjectAtIndex:k withObjectAtIndex:k + 1];
            }
            if (aa == bb) {
                int hh1 = [[hArr objectAtIndex:k] intValue];
                int hh2 = [[hArr objectAtIndex:k + 1] intValue];
                if (hh1 > hh2) {
                    [lArr exchangeObjectAtIndex:k withObjectAtIndex:k + 1];
                    [hArr exchangeObjectAtIndex:k withObjectAtIndex:k + 1];
                }
            }
        }
    }
    printf("%s", [hArr componentsJoinedByString:@" "].UTF8String);
}

#pragma mark - 相对开音节
// ekam a ekac
// !ekam a ekekac
void AT20() {
    char str[1000];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSArray *arr = [ocs componentsSeparatedByString:@" "];
    int cnt = 0;
    for (int i = 0; i < arr.count; i++) {
        NSString *cs = [arr objectAtIndex:i];
        if (cs.length < 4) {
            continue;
        }
        BOOL flag = YES;
        for (int j = 0; j < cs.length; j++) {
            char c = [cs characterAtIndex:j];
            if (!(c >= 'a' && c <= 'z')) {
                flag = NO;
                break;
            }
            
        }
        if (!flag) {
            continue;
        }
        NSString *res = @"";
        for (int j = cs.length - 1; j >= 0; j--) {
            NSString *c = [cs substringWithRange:NSMakeRange(j, 1)];
            res = [res stringByAppendingString:c];
        }
        NSString *subword = @"";
        for (int k = 0; k < res.length; k++) {
            if (k + 4 > res.length) {
                break;
            }
            subword = [res substringWithRange:NSMakeRange(k, 4)];
            NSString *s1 = [subword substringWithRange:NSMakeRange(0, 1)];
            if ([@"aeiou" containsString:s1]) {
                continue;
            }
            NSString *s2 = [subword substringWithRange:NSMakeRange(1, 1)];
            if (![@"aeiou" containsString:s2]) {
                continue;
            }
            NSString *s3 = [subword substringWithRange:NSMakeRange(2, 1)];
            if ([@"aeiour" containsString:s3]) {
                continue;
            }
            NSString *s4 = [subword substringWithRange:NSMakeRange(3, 1)];
            if (![@"e" isEqualToString:s4]) {
                continue;
            }
            cnt++;
        }
    }
    printf("%d", cnt);
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        AT1();
        
//        AT2();
        
//        AT3();
        
//        AT4();
        
//        AT5();
        
//        AT6();
        
//        AT9();
        
//        AT10();
        
//        AT11();
        
//        AT12();
        
//        AT13();
        
        AT14();
        
//        AT15();
        
//        AT16();
        
//        AT17();
        
//        AT18();
        
//        AT20();
        
        AT21();
    }
    return 0;
}
