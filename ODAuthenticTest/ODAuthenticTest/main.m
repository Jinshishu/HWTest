//
//  main.m
//  ODAuthenticTest
//
//  Created by 金诗书 on 2022/6/15.
//

#import <Foundation/Foundation.h>

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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        AT1();
        
//        AT2();
        
//        AT3();
        
//        AT4();
        
//        AT5();
        
//        AT6();
        
        AT9();
    }
    return 0;
}
