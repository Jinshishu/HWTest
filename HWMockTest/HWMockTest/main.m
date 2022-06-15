//
//  main.m
//  HWTest
//
//  Created by 金诗书 on 2022/5/16.
//

#import <Foundation/Foundation.h>

//描述
//计算字符串最后一个单词的长度，单词以空格隔开，字符串长度小于5000。（注：字符串末尾不以空格为结尾）
//输入描述：
//输入一行，代表要计算的字符串，非空，长度小于5000。
//
//输出描述：
//输出一个整数，表示输入字符串最后一个单词的长度。
void HJ1() {
    char s[4999];
    gets(s);
    NSString *sC = [NSString stringWithFormat:@"%s", s];
    NSArray *sArray = [sC componentsSeparatedByString:@" "];
    NSString *tS = [sArray lastObject];
    printf("%d", tS.length);
}

//描述
//写出一个程序，接受一个由字母、数字和空格组成的字符串，和一个字符，然后输出输入字符串中该字符的出现次数。（不区分大小写字母）
//
//数据范围： 1≤n≤1000
//输入描述：
//第一行输入一个由字母和数字以及空格组成的字符串，第二行输入一个字符。
//
//输出描述：
//输出输入字符串中含有该字符的个数。（不区分大小写字母）
void HJ2() {
    char str[1001], ch;
    scanf("%[^\n]\n", str);
    scanf("%c", &ch);
    NSString *strC = [[NSString stringWithFormat:@"%s", str] lowercaseString];
    NSString *cC = [[NSString stringWithFormat:@"%c", ch] lowercaseString];
    NSInteger num = strC.length - [strC stringByReplacingOccurrencesOfString:cC withString:@""].length;
    printf("%lu\n", (unsigned long)num);
}

//描述
//•输入一个字符串，请按长度为8拆分每个输入字符串并进行输出；
//
//•长度不是8整数倍的字符串请在后面补数字0，空字符串不处理。
//输入描述：
//连续输入字符串(每个字符串长度小于等于100)
//
//输出描述：
//依次输出所有分割后的长度为8的新字符串
void HJ4() {
    char strC[100];
    while(scanf("%8s", strC) != EOF) {
        NSString *str = [NSString stringWithFormat:@"%s", strC];
        int len = (int)(8 - str.length);
        printf("%s", [str UTF8String]);
        for (int i = 0; i < len; i++) {
            printf("0");
        }
        printf("\n");
    }
}

//描述
//写出一个程序，接受一个十六进制的数，输出该数值的十进制表示。
//
//数据范围：保证结果在 1≤n≤2^31-1
//输入描述：
//输入一个十六进制的数值字符串。
//
//输出描述：
//输出该数值的十进制字符串。不同组的测试用例用\n隔开。
void HJ5() {
    char strC[50];
    while(scanf("%s", strC) != EOF) {
        NSString *str = [NSString stringWithFormat:@"%s", strC];
        unsigned long long decimal = 0;
        NSScanner *scanner = [NSScanner scannerWithString:str];
        [scanner scanHexLongLong:&decimal];
        printf("%d\n", [@(decimal) intValue]);
    }
}

//描述
//功能:输入一个正整数，按照从小到大的顺序输出它的所有质因子（重复的也要列举）（如180的质因子为2 2 3 3 5 ）
//
//
//数据范围： 1≤n≤2×10^9+14
//输入描述：
//输入一个整数
//
//输出描述：
//按照从小到大的顺序输出它的所有质数的因子，以空格隔开。
void HJ6() {
    NSUInteger u;
    while (scanf("%lu", &u) != EOF) {
        for (int i = 2; i * i <= u; i++) {
            if (u % i == 0) {
                while (u % i == 0) {
                    printf("%d ", i);
                    u /= i;
                }
            }
        }
        if (u != 1) {
            printf("%lu ", (unsigned long)u);
        }
        printf("\n");
    }
}

//描述
//数据表记录包含表索引index和数值value（int范围的正整数），请对表索引相同的记录进行合并，即将相同索引的数值进行求和运算，输出按照index值升序进行输出。
//
//
//提示:
//0 <= index <= 11111111
//1 <= value <= 100000
//
//输入描述：
//先输入键值对的个数n（1 <= n <= 500）
//接下来n行每行输入成对的index和value值，以空格隔开
//
//输出描述：
//输出合并后的键值对（多行）
void HJ8() {
    int n;
    while (scanf("%d", &n) != EOF) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (int i = 0; i < n; i++) {
            int a, b;
            scanf("%d %d", &a, &b);
            NSString *aS = [NSString stringWithFormat:@"%d", a];
            if ([dic.allKeys containsObject:aS]) {
                int c = [[dic valueForKey:aS] intValue] + b;
                [dic setValue:@(c) forKey:aS];
            } else {
                [dic setValue:@(b) forKey:aS];
            }
        }
        NSMutableArray *keyArray = dic.allKeys.mutableCopy;
        int count = (int)keyArray.count;
        for (int i = 0; i < count - 1; i++) {
            for (int j = 0; j < count - 1 - i; j++) {
                int aN = [[keyArray objectAtIndex:j] intValue];
                int bN = [[keyArray objectAtIndex:j + 1] intValue];
                if (aN >= bN) {
                    [keyArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
        for (NSString *key in keyArray) {
            printf("%d %d\n", [key intValue], [[dic valueForKey:key] intValue]);
        };
    }
}

//描述
//编写一个函数，计算字符串中含有的不同字符的个数。字符在 ASCII 码范围内( 0~127 ，包括 0 和 127 )，换行表示结束符，不算在字符里。不在范围内的不作统计。多个相同的字符只计算一次
//例如，对于字符串 abaca 而言，有 a、b、c 三种不同的字符，因此输出 3 。
//
//数据范围： 1≤n≤500
//输入描述：
//输入一行没有空格的字符串。
//
//输出描述：
//输出 输入字符串 中范围在(0~127，包括0和127)字符的种数。
void HJ10 () {
    char cs[500];
    scanf("%s", cs);
    NSString *ocs = [NSString stringWithFormat:@"%s", cs];
    NSMutableSet *set = [NSMutableSet set];
    for (int i = 0; i < ocs.length; i ++) {
        NSString *s = [ocs substringWithRange:NSMakeRange(i, 1)];
        [set addObject:s];
    }
    printf("%d", set.count);
}

//描述
//输入一个整数，将这个整数以字符串的形式逆序输出
//程序不考虑负数的情况，若数字含有0，则逆序形式也含有0，如输入为100，则输出为001
//
//
//数据范围： 0≤n≤2^{30}-1
//输入描述：
//输入一个int整数
//
//输出描述：
//将这个整数以字符串的形式逆序输出
void HJ11 () {
    int n;
    scanf("%d", &n);
    NSString *ocs = [NSString stringWithFormat:@"%d", n];
    for (int i = ocs.length - 1; i >= 0; i--) {
        NSString *s = [ocs substringWithRange:NSMakeRange(i, 1)];
        printf("%s", s.UTF8String);
    }
}

//描述
//接受一个只包含小写字母的字符串，然后输出该字符串反转后的字符串。（字符串长度不超过1000）
//
//输入描述：
//输入一行，为一个只包含小写字母的字符串。
//
//输出描述：
//输出该字符串反转后的字符串。
void HJ12 () {
    char cs[1000];
    scanf("%s", cs);
    NSString *ocs = [NSString stringWithFormat:@"%s", cs];
    for (int i = ocs.length - 1; i >= 0; i--) {
        NSString *s = [ocs substringWithRange:NSMakeRange(i, 1)];
        printf("%s", s.UTF8String);
    }
}

//描述
//将一个英文语句以单词为单位逆序排放。例如“I am a boy”，逆序排放后为“boy a am I”
//
//所有单词之间用一个空格隔开，语句中除了英文字母外，不再包含其他字符
//
//数据范围：输入的字符串长度满足 1≤n≤1000
//
//注意本题有多组输入
//输入描述：
//输入一个英文语句，每个单词用空格隔开。保证输入只包含空格和字母。
//
//输出描述：
//得到逆序的句子
void HJ13 () {
    char cs[1000];
    scanf("%[^\n]", cs);
    NSString *ocs = [NSString stringWithFormat:@"%s", cs];
    NSArray *sArr = [[[ocs componentsSeparatedByString:@" "] reverseObjectEnumerator] allObjects];
    NSString *tS = [sArr componentsJoinedByString:@" "];
    printf("%s", tS.UTF8String);
}

//描述
//给定 n 个字符串，请对 n 个字符串按照字典序排列。
//
//数据范围： 1≤n≤1000  ，字符串长度满足 1≤len≤100
//输入描述：
//输入第一行为一个正整数n(1≤n≤1000),下面n行为n个字符串(字符串长度≤100),字符串中只含有大小写字母。
//输出描述：
//数据输出n行，输出结果为按照字典序排列的字符串。
void HJ14() {
    int n;
    scanf("%d", &n);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:n];
    for (int i = 0; i < n; i++) {
        char str[100];
        scanf("%s", str);
        NSString *strC = [NSString stringWithUTF8String:str];
        [array addObject:strC];
    }
    NSArray *arr = [array sortedArrayUsingSelector:@selector(compare:)];
    NSString *result = [arr componentsJoinedByString:@"\n"];
    printf("%s", result.UTF8String);
}

//描述
//输入一个 int 型的正整数，计算出该 int 型数据在内存中存储时 1 的个数。
//
//数据范围：保证在 32 位整型数字范围内
//输入描述：
// 输入一个整数（int类型）
//
//输出描述：
// 这个数转换成2进制后，输出1的个数
void HJ15() {
    int i,k=0;
    scanf("%d", &i);
    while (i) {
        if (i % 2 == 1) {
            k++;
        }
        i = i / 2;
        if (i == 1) {
            k++;
        }
    }
    printf("%d", k);
}

void HJ16() {
    
}

//描述
//现在有一种密码变换算法。
//九键手机键盘上的数字与字母的对应： 1--1， abc--2, def--3, ghi--4, jkl--5, mno--6, pqrs--7, tuv--8 wxyz--9, 0--0，把密码中出现的小写字母都变成九键键盘对应的数字，如：a 变成 2，x 变成 9.
//而密码中出现的大写字母则变成小写之后往后移一位，如：X ，先变成小写，再往后移一位，变成了 y ，例外：Z 往后移是 a 。
//数字和其它的符号都不做变换。
//数据范围： 输入的字符串长度满足 1≤n≤100
//输入描述：
//输入一组密码，长度不超过100个字符。
//
//输出描述：
//输出密码变换后的字符串
void HJ21() {
    NSString *oS = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *tS = @"012345678922233344455566677778889999bcdefghijklmnopqrstuvwxyza";
    char str[100];
    scanf("%s", str);
    NSString *strC = [NSString stringWithUTF8String:str];
    for (int i = 0; i < strC.length; i++) {
        NSString *ss = [strC substringWithRange:NSMakeRange(i, 1)];
        NSRange r = [oS rangeOfString:ss];
        NSString *trS = [tS substringWithRange:r];
        printf("%s", trS.UTF8String);
    }
}

//描述
//某商店规定：三个空汽水瓶可以换一瓶汽水，允许向老板借空汽水瓶（但是必须要归还）。
//小张手上有n个空汽水瓶，她想知道自己最多可以喝到多少瓶汽水。
//数据范围：输入的正整数满足 1≤n≤100
//
//注意：本题存在多组输入。输入的 0 表示输入结束，并不用输出结果。
//输入描述：
//输入文件最多包含 10 组测试数据，每个数据占一行，仅包含一个正整数 n（ 1<=n<=100 ），表示小张手上的空汽水瓶数。n=0 表示输入结束，你的程序不应当处理这一行。
//
//输出描述：
//对于每组测试数据，输出一行，表示最多可以喝的汽水瓶数。如果一瓶也喝不到，输出0。
void HJ22() {
    int n;
    while (scanf("%d", &n) != EOF) {
        if (n == 0) {
            break;
        }
        int k = 0;
        while (n / 3 != 0) {
            int a = n / 3;
            int b = n % 3;
            k += a;
            if (a + b == 2) {
                n = a + b + 1;
            } else {
                n = a + b;
            }
        }
        printf("%d",k);
    }
}

//描述
//实现删除字符串中出现次数最少的字符，若出现次数最少的字符有多个，则把出现次数最少的字符都删除。输出删除这些单词后的字符串，字符串中其它字符保持原来的顺序。
//
//数据范围：输入的字符串长度满足 1≤n≤20  ，保证输入的字符串中仅出现小写字母
//输入描述：
//字符串只包含小写英文字母, 不考虑非法输入，输入的字符串长度小于等于20个字节。
//
//输出描述：
//删除字符串中出现次数最少的字符后的字符串。
void HJ23() {
    char str[20];
    while (scanf("%s", str) != EOF) {
        NSString *strC = [NSString stringWithFormat:@"%s", str];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (int i = 0; i < strC.length; i++) {
            NSString *c = [strC substringWithRange:NSMakeRange(i, 1)];
            NSNumber *n = [dic valueForKey:c];
            if (n) {
                [dic setValue:@([n integerValue] + 1) forKey:c];
            } else {
                [dic setValue:@(1) forKey:c];
            }
        }
        NSInteger minNum = 20;  // 最多出现20次
        for (NSNumber *num in dic.allValues) {
            minNum = MIN([num integerValue], minNum);
        }
        
        for (NSString *key in dic.allKeys) {
            if ([[dic valueForKey:key] integerValue] == minNum) {
                strC = [strC stringByReplacingOccurrencesOfString:key withString:@""];
            }
        }
        printf("%s", strC.UTF8String);
    }
}

//描述
//编写一个程序，将输入字符串中的字符按如下规则排序。
//
//规则 1 ：英文字母从 A 到 Z 排列，不区分大小写。
//
//如，输入： Type 输出： epTy
//
//规则 2 ：同一个英文字母的大小写同时存在时，按照输入顺序排列。
//
//如，输入： BabA 输出： aABb
//
//规则 3 ：非英文字母的其它字符保持原来的位置。
//
//
//如，输入： By?e 输出： Be?y
//
//数据范围：输入的字符串长度满足 1≤n≤1000
//
//输入描述：
//输入字符串
//输出描述：
//输出字符串
void HJ26() {
    char buffer[1000];
    gets(buffer);
    NSString *strC = [NSString stringWithUTF8String:buffer];
    
    // 存放字母
    NSMutableArray *sArray = [NSMutableArray array];
    // 按原位置存放非字母字符
    NSMutableArray *tArray = [NSMutableArray arrayWithCapacity:strC.length];
    for (int i = 0; i < strC.length; i++) {
        NSString *temS = [strC substringWithRange:NSMakeRange(i, 1)];
        NSString *tS = [temS stringByTrimmingCharactersInSet:NSCharacterSet.letterCharacterSet];
        if (tS.length > 0) {
            [tArray addObject:tS];
        } else {
            [tArray addObject:[NSNull null]];
            [sArray addObject:temS];
        }
    }
    for (int j = 0; j < sArray.count - 1; j++) {
        for (int k = 0; k < sArray.count - 1 - j; k++) {
            NSString *a = [sArray objectAtIndex:k];
            NSString *b = [sArray objectAtIndex:k + 1];
            if ([a.lowercaseString compare:b.lowercaseString] != NSOrderedAscending &&
                ![a.lowercaseString isEqualToString:b.lowercaseString]) {
                [sArray exchangeObjectAtIndex:k withObjectAtIndex:k + 1];
            }
        }
    }
    int n = 0;
    for (int m = 0; m < tArray.count; m++) {
        id value = [tArray objectAtIndex:m];
        if ([value isKindOfClass:[NSNull class]]) {
            NSString *ss = [sArray objectAtIndex:n];
            [tArray setObject:ss atIndexedSubscript:m];
            n++;
        }
    }
    printf("%s", [tArray componentsJoinedByString:@""].UTF8String);
}

//描述
//对输入的字符串进行加解密，并输出。
//
//加密方法为：
//
//当内容是英文字母时则用该英文字母的后一个字母替换，同时字母变换大小写,如字母a时则替换为B；字母Z时则替换为a；
//
//当内容是数字时则把该数字加1，如0替换1，1替换2，9替换0；
//
//其他字符不做变化。
//
//解密方法为加密的逆过程。
//数据范围：输入的两个字符串长度满足1≤n≤1000  ，保证输入的字符串都是只由大小写字母或者数字组成
//输入描述：
//第一行输入一串要加密的密码
//第二行输入一串加过密的密码
//
//输出描述：
//第一行输出加密后的字符
//第二行输出解密后的字符
void HJ29() {
    char str1[1000], str2[1000];
    scanf("%s\n%s", str1, str2);
    NSString *ocs1 = [NSString stringWithFormat:@"%s", str1];
    for (int i = 0; i < ocs1.length; i++) {
        char c = [ocs1 characterAtIndex:i];
        if (c >= 'a' && c < 'z') {
            int a = c - 32 + 1;
            printf("%c", (char)a);
            continue;
        }
        if (c == 'z') {
            printf("A");
            continue;
        }
        if (c >= 'A' && c < 'Z') {
            int a = c + 32 + 1;
            printf("%c", (char)a);
            continue;
        }
        if (c == 'Z') {
            printf("a");
            continue;
        }
        if (c >= '0' && c < '9') {
            printf("%c", (char)(c + 1));
            continue;
        }
        if (c == '9') {
            printf("0");
        }
    }
    printf("\n");
    NSString *ocs2 = [NSString stringWithFormat:@"%s", str2];
    for (int i = 0; i < ocs1.length; i++) {
        char c = [ocs2 characterAtIndex:i];
        if (c > 'a' && c <= 'z') {
            int a = c - 32 - 1;
            printf("%c", (char)a);
            continue;
        }
        if (c == 'a') {
            printf("Z");
            continue;
        }
        if (c > 'A' && c <= 'Z') {
            int a = c + 32 - 1;
            printf("%c", (char)a);
            continue;
        }
        if (c == 'A') {
            printf("z");
            continue;
        }
        if (c > '0' && c <= '9') {
            printf("%c", (char)(c - 1));
            continue;
        }
        if (c == '0') {
            printf("9");
        }
    }
}

//描述
//对字符串中的所有单词进行倒排。
//
//说明：
//
//1、构成单词的字符只有26个大写或小写英文字母；
//
//2、非构成单词的字符均视为单词间隔符；
//
//3、要求倒排后的单词间隔符以一个空格表示；如果原字符串中相邻单词间有多个间隔符时，倒排转换后也只允许出现一个空格间隔符；
//
//4、每个单词最长20个字母；
//
//数据范围：字符串长度满足 1≤n≤10000
//输入描述：
//输入一行，表示用来倒排的句子
//
//输出描述：
//输出句子的倒排结果
void HJ31() {
    char str[10000];
    gets(str);
    NSString *strC = [NSString stringWithUTF8String:str];
//    NSString *reg = @"[^a-zA-Z ]";
//    strC = [strC stringByReplacingOccurrencesOfString:reg withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, strC.length)];
    for (int i = 0; i < strC.length; i++) {
        char c = [strC characterAtIndex:i];
        if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
            
        } else {
            NSString *cS = [NSString stringWithFormat:@"%c", c];
            strC = [strC stringByReplacingOccurrencesOfString:cS withString:@" "];
        }
        
    }
    
    while ([strC containsString:@"  "]) {
        strC = [strC stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    NSArray *strArr = [[[strC componentsSeparatedByString:@" "] reverseObjectEnumerator] allObjects];
    NSString *tS = [strArr componentsJoinedByString:@" "];
    printf("%s", tS.UTF8String);
}

//描述
//Lily上课时使用字母数字图片教小朋友们学习英语单词，每次都需要把这些图片按照大小（ASCII码值从小到大）排列收好。请大家给Lily帮忙，通过代码解决。
//Lily使用的图片使用字符"A"到"Z"、"a"到"z"、"0"到"9"表示。
//
//数据范围：每组输入的字符串长度满足 1≤n≤1000
//
//输入描述：
//一行，一个字符串，字符串中的每个字符表示一张Lily使用的图片。
//
//输出描述：
//Lily的所有图片按照从小到大的顺序输出
void HJ34() {
    char cs[1000];
    scanf("%s", cs);
    NSString *ocs = [NSString stringWithFormat:@"%s", cs];
    NSMutableArray *sArr = [NSMutableArray array];
    for (int i = 0; i < ocs.length; i++) {
        NSString *cs = [ocs substringWithRange:NSMakeRange(i, 1)];
        [sArr addObject:cs];
    }
    for (int i = 0; i < sArr.count - 1; i++) {
        for (int j = 0; j < sArr.count - i - 1; j++) {
            char c1 = [[sArr objectAtIndex:j] characterAtIndex:0];
            char c2 = [[sArr objectAtIndex:j+1] characterAtIndex:0];
            if (c1 > c2) {
                [sArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSString *ss = [sArr componentsJoinedByString:@""];
    printf("%s\n", ss.UTF8String);
}

//描述
//蛇形矩阵是由1开始的自然数依次排列成的一个矩阵上三角形。
//
//例如，当输入5时，应该输出的三角形为：
//
//1 3 6 10 15
//
//2 5 9 14
//
//4 8 13
//
//7 12
//
//11
//
//
//输入描述：
//输入正整数N（N不大于100）
//
//输出描述：
//输出一个N行的蛇形矩阵。
void HJ35() {
    int n;
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        int k = 1 + (i * (i + 1) / 2);  // 每行的第一位数
        printf("%d ", k);
        for (int j = 1; j < n - i; j++) {
            k = (i + 1) + (j + k);  // 每行从第二位数开始计算
            printf("%d ", k);
        }
        printf("\n");
    }
}

//描述
//有一种兔子，从出生后第3个月起每个月都生一只兔子，小兔子长到第三个月后每个月又生一只兔子。
//例子：假设一只兔子第3个月出生，那么它第5个月开始会每个月生一只兔子。
//一月的时候有一只兔子，假如兔子都不死，问第n个月的兔子总数为多少？
//数据范围：输入满足 1≤n≤31
//输入描述：
//输入一个int型整数表示第n个月
//
//输出描述：
//输出对应的兔子总数
void HJ36() {
    int n;
    scanf("%d", &n);
    int cnt = 0;
    if (n < 3) {
        cnt = 1;
    } else {
        int a = 1;  // 上上月数量
        int b = 1;  // 上月数量
        for (int i = 3; i <= n; i ++) {
            cnt = a + b;
            a = b;
            b = cnt;
        }
    }
    printf("%d", cnt);
//    for (int i = 1; i <= n; i ++) {
//        if (i < 3) {
//            [arr addObject:@"1"];
//        } else {
//            int a = [[arr objectAtIndex:(i - 3)] intValue];
//            int b = [[arr objectAtIndex:(i - 2)] intValue];
//            [arr addObject:[@(a + b) stringValue]];
//        }
//    }
//    printf("%d", [[arr objectAtIndex:(n - 1)] intValue]);
}

//描述
//输入一行字符，分别统计出包含英文字母、空格、数字和其它字符的个数。
//
//数据范围：输入的字符串长度满足 1≤n≤1000
//
//输入描述：
//输入一行字符串，可以有空格
//
//输出描述：
//统计其中英文字符，空格字符，数字字符，其他字符的个数
void HJ40() {
    char str[1000];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    int j = 0, k = 0, m =0, n = 0;
    for (int i = 0; i < ocs.length; i++) {
        NSString *ss = [ocs substringWithRange:NSMakeRange(i, 1)];
        char cs = [ocs characterAtIndex:i];
        // 英文
//        if ((cs > 64 && cs < 91) || (cs > 96 && cs < 123)) {
        if ((cs >= 'A' && cs <= 'Z') || (cs >= 'a' && cs <= 'z')) {
            j++;
            continue;
        }
        // 空格
        if ([ss isEqualToString:@" "]) {
            k++;
            continue;
        }
        // 数字
        if (cs >= '0' && cs <= '9') {
            m++;
            continue;
        }
        // 其他字符
        n++;
    }
    printf("%d\n%d\n%d\n%d", j, k, m, n);
}

typedef struct ListNode {
    int m_nKey;
    struct ListNode *m_pNext;
} ListNode;

void HJ51() {
    int n;
    while (scanf("%d", &n) != EOF) {
        
        int h;
        scanf("%d", &h);
        
        ListNode *head;
        ListNode *new_data;
        ListNode *ptr;
        head = (ListNode *)malloc(sizeof(ListNode *));
        head->m_nKey = h;
        head->m_pNext = NULL;
        ptr = head;
        for (int i = 1; i < n; i++) {
            int s;
            scanf("%d", &s);
            new_data = (ListNode *)malloc(sizeof(ListNode *));
            new_data->m_nKey = s;
            ptr->m_pNext = new_data;
            new_data->m_pNext = NULL;
            ptr = ptr->m_pNext;
        }
        
        int k;
        scanf("%d", &k);
        if (k > n || k <= 0) {
            printf("0\n");
        } else {
            ListNode *rr;
            rr = head;
            for(int i = 0; i < n-k+1; i++) {
                rr = rr->m_pNext;
            }
            printf("%d\n", rr->m_nKey);
        }
    }
}

//杨辉三角形的数阵，第一行只有一个数1，以下每行的每个数，是恰好是它上面的数、左上角数和右上角的数，3个数之和（如果不存在某个数，认为该数就是0）。
//
//求第n行第一个偶数出现的位置。如果没有偶数，则输出-1。例如输入3,则输出2，输入4则输出3，输入2则输出-1。
//
//数据范围： 1≤n≤10^9
//
//
//输入描述：
//输入一个int整数
//
//输出描述：
//输出返回的int值
void HJ53() {
//    int n;
//    scanf("%d", &n);
//    int l = 2 * (n - 1) + 1;    // 三角形底边数字的数量
//    NSMutableArray *nArr = [NSMutableArray array];
//    NSMutableArray *lArr = @[].mutableCopy;
//    for (int i = 0; i < l; i++) {
//        if (i == l/2 + l%2 - 1) {
//            [lArr insertObject:@"1" atIndex:i];
//        } else {
//            [lArr insertObject:@"0" atIndex:i];
//        }
//    }
//    [nArr addObject:lArr];
//    for (int i = 1; i < n; i++) {
//        lArr = lArr;
//        for (int j = 1; j < l-1; j++) {
//            int a = [[lArr objectAtIndex:j - 1] intValue];
//            int b = [[lArr objectAtIndex:j] intValue];
//            int c = [[lArr objectAtIndex:j + 1] intValue];
//            [lArr replaceObjectAtIndex:j withObject:@(a + b + c)];
//        }
//        [nArr insertObject:lArr atIndex:i];
//        printf("\n");
//    }
}

//描述
//给定一个字符串描述的算术表达式，计算出结果值。
//
//输入字符串长度不超过 100 ，合法的字符包括 ”+, -, *, /, (, )” ， ”0-9” 。
//
//数据范围：运算过程中和最终结果均满足 ∣val∣≤2^31−1  ，即只进行整型运算，确保输入的表达式合法
//输入描述：
//输入算术表达式
//
//输出描述：
//计算出结果值
void HJ54() {
//    char str[100];
//    gets(str);
//    NSString *ocs = [NSString stringWithFormat:@"%s", str];
//    NSMutableArray *arr1 = [NSMutableArray array];  // 存数值
//    NSMutableArray *arr2 = [NSMutableArray array];  // 存符号
////    [ocs stringByReplacingOccurrencesOfString:@"{" withString:@")"];
////    [ocs stringByReplacingOccurrencesOfString:@"}" withString:@")"];
////    [ocs stringByReplacingOccurrencesOfString:@"[" withString:@")"];
////    [ocs stringByReplacingOccurrencesOfString:@"]" withString:@")"];
//    BOOL isNum = NO;
//    for (int i = 0; i < ocs.length; i++) {
//        NSString *s = [ocs substringWithRange:NSMakeRange(i, 1)];
//        char c = [ocs characterAtIndex:i];
//        if (c >= '0' && c <= '9') {
//            [arr1 addObject:s];
//            isNum = YES;
//            continue;
//        }
//        if (isNum && [s isEqualToString:@"-"]) {
//            arr1 addObject:<#(nonnull id)#>
//        }
//        isNum = NO;
//
//    }
}

//描述
//完全数（Perfect number），又称完美数或完备数，是一些特殊的自然数。
//
//它所有的真因子（即除了自身以外的约数）的和（即因子函数），恰好等于它本身。
//
//例如：28，它有约数1、2、4、7、14、28，除去它本身28外，其余5个数相加，1+2+4+7+14=28。
//
//输入n，请输出n以内(含n)完全数的个数。
//
//数据范围：1≤n≤5×10^5
//
//输入描述：
//输入一个数字n
//
//输出描述：
//输出不超过n的完全数的个数
void HJ56() {
    int n;
    scanf("%d", &n);
    int cnt = 0;
    for (int i = 1; i < n; i++) {
        int k = 0;
        for (int j = 1; j < i; j++) {
            if (i % j == 0) {
                k = k + j;
            }
        }
        if (k == i) {
            cnt++;
        }
    }
    printf("%d", cnt);
}

//任意一个偶数（大于2）都可以由2个素数组成，组成偶数的2个素数有很多种情况，本题目要求输出组成指定偶数的两个素数差值最小的素数对。
//
//数据范围：输入的数据满足 4≤n≤1000
//输入描述：
//输入一个大于2的偶数
//
//输出描述：
//从小到大输出两个素数
void HJ60() {
    int n;
    scanf("%d", &n);
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 2; i <= n; i++) {
        int j = 0;
        for (j = 2; j <= i; j++) {
            if (i % j == 0) {
                break;
            }
        }
        if (j >= i) {
            [arr addObject:@(i)];
        }
    }
    NSMutableArray *sArr = [NSMutableArray array];
    int m = n;  //最大差值
    for (int i = 0; i < arr.count - 1; i ++) {
        int k = [[arr objectAtIndex:i] intValue];
        int j = n - k;
        if ([arr containsObject:@(j)]) {
            int x = abs(k - j);
            if (x < m) {
                if (k < j) {
                    [sArr insertObject:@(k) atIndex:0];
                    [sArr insertObject:@(j) atIndex:1];
                } else {
                    [sArr insertObject:@(j) atIndex:0];
                    [sArr insertObject:@(k) atIndex:1];
                }
                m = x;
            }
        }
    }
    printf("%d\n%d", [[sArr objectAtIndex:0] intValue], [[sArr objectAtIndex:1] intValue]);
}

void HJ61() {
//    int m, n;
//    scanf("%d %d", &m, &n);
//    NSMutableArray *pArr = [NSMutableArray array];
//    for (int i = 0; i < n; i++) {
//        [pArr addObject:@(0)];
//    }
//    for (int j = 0; j < m; j++) {
//
//    }
}

//描述
//输入一个正整数，计算它在二进制下的1的个数。
//注意多组输入输出！！！！！！
//
//数据范围：1≤n≤2^31−1
//输入描述：
//输入一个整数
//
//输出描述：
//计算整数二进制中1的个数
void HJ62() {
    int n;
    while (scanf("%d", &n) != EOF) {
        int cnt = 0;
        while (n / 2 != 0) {
            if (n % 2 == 1) {
                cnt++;
            }
            n = n / 2;
            if (n == 1) {
                cnt++;
            }
        }
        printf("%d\n", cnt);
    }
}

//描述
//公元五世纪，我国古代数学家张丘建在《算经》一书中提出了“百鸡问题”：鸡翁一值钱五，鸡母一值钱三，鸡雏三值钱一。百钱买百鸡，问鸡翁、鸡母、鸡雏各几何？
//现要求你打印出所有花一百元买一百只鸡的方式。
//输入描述：
//输入任何一个整数，即可运行程序。
//
//输出描述：
// 输出有数行，每行三个整数，分别代表鸡翁，母鸡，鸡雏的数量
void HJ72() {
    int n;
    scanf("%d", &n);
    int a, b, c;
    for (int i = 0; i < 4; i++) {
        a = 4 * i;
        b = 25 - 7 * i;
        c = 100 - a - b;
        printf("%d %d %d\n", a, b, c);
    }
}

//描述
//根据输入的日期，计算是这一年的第几天。
//保证年份为4位数且日期合法。
//进阶：时间复杂度：O(n)\O(n) ，空间复杂度：O(1)\O(1)
//输入描述：
//输入一行，每行空格分割，分别是年，月，日
//
//输出描述：
//输出是这一年的第几天
void HJ73() {
    char str[20];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSArray *arr = [ocs componentsSeparatedByString:@" "];
    int year = [[arr objectAtIndex:0] intValue];
    int month = [[arr objectAtIndex:1] intValue];
    int day = [[arr objectAtIndex:2] intValue];
    NSMutableDictionary *dic = @{@(1) : @(31),
                                 @(2) : @(28),
                                 @(3) : @(31),
                                 @(4) : @(30),
                                 @(5) : @(31),
                                 @(6) : @(30),
                                 @(7) : @(31),
                                 @(8) : @(31),
                                 @(9) : @(30),
                                 @(10) : @(31),
                                 @(11) : @(30),
                                 @(12) : @(31)}.mutableCopy;
    if ((year % 4 == 0 && year % 100 != 0) || (year % 100 == 0 && year % 400 == 0)) {
        [dic setObject:@(29) forKey:@(2)];
    }
    int days = day;
    for (int i = 1; i < month; i++) {
        NSNumber *num = [dic objectForKey:@(i)];
        days = days + [num intValue];
    }
    printf("%d", days);
}

//描述
//验证尼科彻斯定理，即：任何一个整数m的立方都可以写成m个连续奇数之和。
//
//例如：
//
//1^3=1
//
//2^3=3+5
//
//3^3=7+9+11
//
//4^3=13+15+17+19
//
//输入一个正整数m（m≤100），将m的立方写成m个连续奇数之和的形式输出。
//数据范围：1≤m≤100
//进阶：时间复杂度：O(m)\O(m) ，空间复杂度：O(1)\O(1)
//
//输入描述：
//输入一个int整数
//
//输出描述：
//输出分解后的string
void HJ76() {
    // S: (n - 1) ^ 2 + n
    int n;
    scanf("%d", &n);
    int s = (n - 1) * (n - 1) + n;
    printf("%d", s);
    for (int i = 1; i < n; i++) {
         s = s + 2;
        printf("+%d", s);
    }
}

//描述
//题目标题：
//
//将两个整型数组按照升序合并，并且过滤掉重复数组元素。
//输出时相邻两数之间没有空格。
//
//
//
//输入描述：
//输入说明，按下列顺序输入：
//1 输入第一个数组的个数
//2 输入第一个数组的数值
//3 输入第二个数组的个数
//4 输入第二个数组的数值
//
//输出描述：
//输出合并之后的数组
void HJ80() {
    int n;
    scanf("%d", &n);
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < n; i++) {
        int k;
        scanf("%d", &k);
        [arr1 addObject:@(k)];
    }
    
    int m;
    scanf("%d", &m);
    NSMutableArray *arr2 = [NSMutableArray array];
    for (int i = 0; i < m; i++) {
        int k;
        scanf("%d", &k);
        [arr2 addObject:@(k)];
    }
    
    NSArray *arr3 = [arr1 arrayByAddingObjectsFromArray:arr2];
    NSSet *set = [NSSet setWithArray:arr3];
    NSArray *arr4 = set.allObjects;
    NSArray *arr5 = [arr4 sortedArrayUsingSelector:@selector(compare:)];
    NSString *s = [arr5 componentsJoinedByString:@""];
    printf("%s", s.UTF8String);
}

//描述
//判断短字符串S中的所有字符是否在长字符串T中全部出现。
//请注意本题有多组样例输入。
//数据范围:1≤len(S),len(T)≤200
//进阶：时间复杂度：O(n)\O(n) ，空间复杂度：O(n)\O(n)
//输入描述：
//输入两个字符串。第一个为短字符串，第二个为长字符串。两个字符串均由小写字母组成。
//
//输出描述：
//如果短字符串的所有字符均在长字符串中出现过，则输出字符串"true"。否则输出字符串"false"。
void HJ81() {
    char dStr[200], cStr[200];
    scanf("%s\n%s", dStr, cStr);
    NSString *dStrs = [NSString stringWithFormat:@"%s", dStr];
    NSString *cStrs = [NSString stringWithFormat:@"%s", cStr];
    BOOL flag = NO;
    for (int i = 0; i < dStrs.length; i++) {
        NSString *c = [dStrs substringWithRange:NSMakeRange(i, 1)];
        if (![cStrs containsString:c]) {
            flag = YES;
            break;
        }
    }
    if (flag) {
        printf("false");
    } else {
        printf("true");
    }
}

//描述
//有一个m∗n 大小的数据表，你会依次进行以下5种操作：
//1.输入m和n，初始化m∗n 大小的表格。
//2.输入x1、y1、x2、y2，交换坐标在(x1,y1)和(x2,y2)的两个数。
//3.输入x，在第x行上方添加一行。
//4.输入y，在第y列左边添加一列。
//5.输入x、y，查找坐标为(x,y)的单元格的值。
//请编写程序，判断对表格的各种操作是否合法。
//
//详细要求:
//
//1.数据表的最大规格为9行*9列，对表格进行操作时遇到超出规格应该返回错误。
//2.对于插入操作，如果插入后行数或列数超过9了则应返回错误。如果插入成功了则将数据表恢复至初始化的m*n大小，多出的数据则应舍弃。
//3.所有输入坐标操作，对m*n大小的表格，行号坐标只允许0~m-1，列号坐标只允许0~n-1。超出范围应该返回错误。
//
//本题含有多组样例输入！行列从0开始标号
//数据范围：数据组数：1≤t≤5
//进阶：时间复杂度：O(1)，空间复杂度：O(1)
//输入描述：
//输入数据按下列顺序输入：
//1 表格的行列值
//2 要交换的两个单元格的行列值
//3 输入要插入的行的数值
//4 输入要插入的列的数值
//5 输入要查询的单元格的坐标
//
//输出描述：
//输出按下列顺序输出：
//1 初始化表格是否成功，若成功则返回0， 否则返回-1
//2 输出交换单元格是否成功
//3 输出插入行是否成功
//4 输出插入列是否成功
//5 输出查询单元格数据是否成功
void HJ83() {
    int m, n;
    while (scanf("%d %d", &m, &n) != EOF) {
        int x1, y1, x2, y2;
        scanf("%d %d %d %d", &x1, &y1, &x2, &y2);
        
        int x;
        scanf("%d", &x);
        
        int y;
        scanf("%d", &y);
        
        int x3, y3;
        scanf("%d %d", &x3, &y3);
        
        if (m > 9 || n > 9) {
            printf("-1\n");
        } else {
            printf("0\n");
        }
        
        if (x1 > m - 1 || y1 > n - 1 || x2 > m - 1 || y2 > n - 1) {
            printf("-1\n");
        } else {
            printf("0\n");
        }
        
        if (m + 1 > 9 || x < 0 || x > m - 1) {
            printf("-1\n");
        } else {
            printf("0\n");
        }
        
        if (n + 1 > 9 || y < 0 || y > n - 1) {
            printf("-1\n");
        } else {
            printf("0\n");
        }
        
        if (x3 > m - 1 || x3 < 0 || y3 > n - 1 || y3 < 0) {
            printf("-1\n");
        } else {
            printf("0\n");
        }
    }
}

//描述
//找出给定字符串中大写字符(即'A'-'Z')的个数。
//数据范围：字符串长度：1≤∣s∣≤250
//字符串中可能包含空格或其他字符
//进阶：时间复杂度：O(n)\O(n) ，空间复杂度：O(n)\O(n)
//输入描述：
//对于每组样例，输入一行，代表待统计的字符串
//
//输出描述：
//输出一个整数，代表字符串中大写字母的个数
void HJ84() {
    char str[250];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    int cnt = 0;
    for (int i = 0; i < ocs.length; i++) {
        char c = [ocs characterAtIndex:i];
        if (c >= 'A' && c <= 'Z') {
            cnt++;
        }
    }
    printf("%d", cnt);
}

//描述
//给定一个仅包含小写字母的字符串，求它的最长回文子串的长度。
//所谓回文串，指左右对称的字符串。
//所谓子串，指一个字符串删掉其部分前缀和后缀（也可以不删）的字符串
//数据范围：字符串长度1≤s≤350
//进阶：时间复杂度：O(n) ，空间复杂度：O(n)
//输入描述：
//输入一个仅包含小写字母的字符串
//
//输出描述：
//返回最长回文子串的长度
void HJ85() {
    char str[350];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    int maxCnt = 0;
    for (int i = 0; i < ocs.length; i++) {
        for (int j = i + 1; j < ocs.length + 1; j++) {
            NSString *s = [ocs substringWithRange:NSMakeRange(i, j - i)];
            BOOL flag = YES;
            for (int k = 0; k < s.length / 2; k++) {
                NSString *s1 = [s substringWithRange:NSMakeRange(k, 1)];
                NSString *s2 = [s substringWithRange:NSMakeRange(s.length - k - 1, 1)];
                if (![s1 isEqualToString:s2]) {
                    flag = NO;
                    break;
                }
            }
            if (flag) {
                maxCnt = MAX((int)s.length, maxCnt);
            }
        }
    }
    printf("%d", maxCnt);
}

//描述
//求一个int类型数字对应的二进制数字中1的最大连续数，例如3的二进制为00000011，最大连续2个1
//
//数据范围：数据组数：1≤t≤5 ，1≤n≤500000
//进阶：时间复杂度：O(logn)\O(logn) ，空间复杂度：O(1)\O(1)
//输入描述：
//输入一个int类型数字
//
//输出描述：
//输出转成二进制之后连续1的个数
void HJ86() {
    int n;
    scanf("%d", &n);
    NSMutableArray *arr = [NSMutableArray array];
    while (n) {
        int a = n % 2;
        [arr addObject:@(a)];
        n /= 2;
    }
    
    int cnt = 0;
    int maxCnt = 0;
    for (int i = 0; i < arr.count; i++) {
        int a = [[arr objectAtIndex:i] intValue];
        if (a == 1) {
            cnt++;
            maxCnt = maxCnt < cnt ? cnt : maxCnt;
        } else {
            maxCnt = maxCnt < cnt ? cnt : maxCnt;
            cnt = 0;
        }
    }
    printf("%d", maxCnt);
}

//描述
//密码按如下规则进行计分，并根据不同的得分为密码进行安全等级划分。
//
//一、密码长度:
//5 分: 小于等于4 个字符
//10 分: 5 到7 字符
//25 分: 大于等于8 个字符
//
//二、字母:
//0 分: 没有字母
//10 分: 密码里的字母全都是小（大）写字母
//20 分: 密码里的字母符合”大小写混合“
//
//三、数字:
//0 分: 没有数字
//10 分: 1 个数字
//20 分: 大于1 个数字
//
//四、符号:
//0 分: 没有符号
//10 分: 1 个符号
//25 分: 大于1 个符号
//
//五、奖励（只能选符合最多的那一种奖励）:
//2 分: 字母和数字
//3 分: 字母、数字和符号
//5 分: 大小写字母、数字和符号
//
//最后的评分标准:
//>= 90: 非常安全
//>= 80: 安全（Secure）
//>= 70: 非常强
//>= 60: 强（Strong）
//>= 50: 一般（Average）
//>= 25: 弱（Weak）
//>= 0:  非常弱（Very_Weak）
//
//对应输出为：
//
//VERY_SECURE
//SECURE
//VERY_STRONG
//STRONG
//AVERAGE
//WEAK
//VERY_WEAK
//
//请根据输入的密码字符串，进行安全评定。
//
//注：
//字母：a-z, A-Z
//数字：0-9
//符号包含如下： (ASCII码表可以在UltraEdit的菜单view->ASCII Table查看)
//!"#$%&'()*+,-./     (ASCII码：0x21~0x2F)
//:;<=>?@             (ASCII码：0x3A~0x40)
//[\]^_`              (ASCII码：0x5B~0x60)
//{|}~                (ASCII码：0x7B~0x7E)
//
//提示:
//1 <= 字符串的长度<= 300
//输入描述：
//输入一个string的密码
//
//输出描述：
//输出密码等级
void HJ87() {
    char str[300];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    int grade = 0;
    int k = 0, l = 0, m = 0, n = 0;
    for (int i = 0; i < ocs.length; i++) {
        char c = [ocs characterAtIndex:i];
        if (c >= 'a' && c <= 'z') {
            k++;
            continue;
        }
        if (c >= 'A' && c <= 'Z') {
            l++;
            continue;
        }
        if (c >= '0' && c <= '9') {
            m++;
            continue;
        }
        if ((c >= '!' && c <= '/') ||
            (c >= ':' && c <= '@') ||
            (c >= '[' && c <= '`') ||
            (c >= '{' && c <= '~')) {
            n++;
            continue;
        }
    }
    
    // 长度
    if (ocs.length <= 4) {
        grade += 5;
    } else if (ocs.length >= 8) {
        grade += 25;
    } else {
        grade += 10;
    }
    
    // 字母
    if (k == 0 && l == 0) {
        grade += 0;
    } else if ((k == 0 && l > 0) || (k > 0 && l ==0)) {
        grade += 10;
    } else {
        grade += 20;
    }
    
    // 数字
    if (m == 0) {
        grade += 0;
    } else if (m == 1) {
        grade += 10;
    } else {
        grade += 20;
    }
    
    // 符号
    if (n == 0) {
        grade += 0;
    } else if (n == 1) {
        grade += 10;
    } else {
        grade += 25;
    }
    
    // 奖励
    if (k > 0 && l > 0 && m > 0 && n > 0) {
        grade += 5;
    } else if ((k > 0 || l > 0) && m > 0 && n > 0) {
        grade += 3;
    } else if ((k > 0 || l > 0) && m > 0) {
        grade += 2;
    }
    
    if (grade >= 90) {
        printf("VERY_SECURE");
    } else if (grade >= 80 && grade < 90) {
        printf("SECURE");
    } else if (grade >= 70 && grade < 80) {
        printf("VERY_STRONG");
    } else if (grade >= 60 && grade < 70) {
        printf("STRONG");
    } else if (grade >= 50 && grade < 60) {
        printf("AVERAGE");
    } else if (grade >= 25 && grade < 50) {
        printf("WEAK");
    } else {
        printf("VERY_WEAK");
    }
}

//请计算n*m的棋盘格子（n为横向的格子数，m为竖向的格子数）从棋盘左上角出发沿着边缘线从左上角走到右下角，总共有多少种走法，要求不能走回头路，即：只能往右和往下走，不能往左和往上走。
//
//注：沿棋盘格之间的边缘线行走
//
//数据范围：1≤n,m≤8
//
//
//输入描述：
//输入两个正整数n和m，用空格隔开。(1≤n,m≤8)
//
//输出描述：
//输出一行结果
void HJ91() {
    
}

//描述
//请实现一个计票统计系统。你会收到很多投票，其中有合法的也有不合法的，请统计每个候选人得票的数量以及不合法的票数。
//（注：不合法的投票指的是投票的名字不存在n个候选人的名字中！！）
//
//数据范围：每组输入中候选人数量满足1≤n≤100  ，总票数量满足 1≤n≤100
//输入描述：
//第一行输入候选人的人数n，第二行输入n个候选人的名字（均为大写字母的字符串），第三行输入投票人的人数，第四行输入投票。
//
//输出描述：
//按照输入的顺序，每行输出候选人的名字和得票数量（以" : "隔开，注：英文冒号左右两边都有一个空格！），最后一行输出不合法的票数，格式为"Invalid : "+不合法的票数。
void HJ94() {
    int n;
    scanf("%d", &n);
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < n; i++) {
        char str[100];
        scanf("%s", str);
        NSString *strc = [NSString stringWithFormat:@"%s", str];
        [arr1 addObject:strc];
    }
    
    int m;
    scanf("%d", &m);
    NSMutableArray *arr2 = [NSMutableArray array];
    for (int i = 0; i < m; i++) {
        char str[100];
        scanf("%s", str);
        NSString *strc = [NSString stringWithFormat:@"%s", str];
        [arr2 addObject:strc];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < arr2.count; i++) {
        NSString *a = [arr2 objectAtIndex:i];
        if (![arr1 containsObject:a]) {
            a = @"Invalid";
        }
        NSNumber *cnt = [dic objectForKey:a];
        if (cnt) {
            [dic setObject:@([cnt intValue] + 1) forKey:a];
        } else {
            [dic setObject:@(1) forKey:a];
        }
    }
    for (int i = 0; i < arr1.count; i++) {
        NSString *a = [arr1 objectAtIndex:i];
        NSNumber *cnt = [dic objectForKey:a];
        if (cnt) {
            printf("%s : %d\n", a.UTF8String, [cnt intValue]);
        } else {
            printf("%s : 0\n", a.UTF8String);
        }
    }
    NSNumber *cnt = [dic objectForKey:@"Invalid"];
    printf("Invalid : %d\n", [cnt intValue]);
   
}

//描述
//将一个字符中所有的整数前后加上符号“*”，其他字符保持不变。连续的数字视为一个整数。
//
//
//数据范围：字符串长度满足 1≤n≤100
//输入描述：
//输入一个字符串
//
//输出描述：
//字符中所有出现的数字前后加上符号“*”，其他字符保持不变
void HJ96() {
    char str[100];
    scanf("%s", str);
    NSString *ocss = [NSString stringWithFormat:@"%s", str];
    NSMutableString *ocs = [NSMutableString string];
    BOOL isNum = NO;    // 记录前一位数是否是数字
    for (int i = 0; i < ocss.length; i++) {
        char c = [ocss characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            if (isNum) {
                [ocs appendFormat:@"%c", c];
                if (i == ocss.length - 1) {
                    [ocs appendString:@"*"];
                }
                continue;
            }
            [ocs appendFormat:@"*%c", c];
            if (i == ocss.length - 1) {
                [ocs appendString:@"*"];
            }
            isNum = YES;
        } else {
            if (isNum) {
                [ocs appendFormat:@"*%c", c];
            } else {
                [ocs appendFormat:@"%c", c];
            }
            isNum = NO;
        }
    }
    printf("%s\n", ocs.UTF8String);
}

//描述
//首先输入要输入的整数个数n，然后输入n个整数。输出为n个整数中负数的个数，和所有正整数的平均值，结果保留一位小数。
//0即不是正整数，也不是负数，不计入计算。如果没有正数，则平均值为0。
//
//数据范围： 1≤ n ≤2000  ，输入的整数都满足 ∣val∣≤1000
//输入描述：
//首先输入一个正整数n，
//然后输入n个整数。
//
//输出描述：
//输出负数的个数，和所有正整数的平均值。
void HJ97() {
    int n;
    while (scanf("%d\n", &n) != EOF) {
        char str[10000];
        gets(str);
        NSString *ocs = [NSString stringWithFormat:@"%s", str];
        NSArray *arr = [ocs componentsSeparatedByString:@" "];
        int k = 0, l = 0;
        float j = 0.0;
        for (int i = 0; i < arr.count; i++) {
            int c = [[arr objectAtIndex:i] intValue];
            if (c < 0) {
                k++;
            }
            if (c > 0) {
                j += c;
                l++;
            }
        }
        float f = j == 0.0 ? 0.0 : (j / l);
        printf("%d %.1f\n", k, f);
    }
}

//描述
//自守数是指一个数的平方的尾数等于该数自身的自然数。例如：25^2 = 625，76^2 = 5776，9376^2 = 87909376。请求出n(包括n)以内的自守数的个数
//
//
//数据范围：1≤n≤10000
//
//
//输入描述：
//int型整数
//
//输出描述：
//n以内自守数的数量。
void HJ99() {
    int n;
    while (scanf("%d", &n) != EOF) {
        int cnt = 0;
        for (int i = 0; i <= n; i++) {
            NSString *ss = [NSString stringWithFormat:@"%d", i * i];
            if ([ss hasSuffix:[@(i) stringValue]]) {
                cnt++;
            }
        }
        printf("%d\n", cnt);
    }
}

//描述
//等差数列 2，5，8，11，14。。。。
//（从 2 开始的 3 为公差的等差数列）
//输出求等差数列前n项和
//
//
//数据范围：1≤n≤1000
//输入描述：
//输入一个正整数n。
//
//输出描述：
//输出一个相加后的整数。
void HJ100() {
    int n;
    while (scanf("%d", &n) != EOF) {
        int k = 0;
        for (int i = 0; i < n; i++) {
            k = k + (3 * i + 2);
        }
        printf("%d\n", k);
    }
}

//描述
//输入一个只包含小写英文字母和数字的字符串，按照不同字符统计个数由多到少输出统计结果，如果统计的个数相同，则按照ASCII码由小到大排序输出。
//数据范围：字符串长度满足 1≤len(str)≤1000
//
//输入描述：
//一个只包含小写英文字母和数字的字符串。
//
//输出描述：
//一个字符串，为不同字母出现次数的降序表示。若出现次数相同，则按ASCII码的升序输出。
void HJ102() {
    char str[1000];
    scanf("%s", str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    NSMutableArray *kArr = [NSMutableArray array];
    NSMutableArray *vArr = [NSMutableArray array];
    for (int i = 0; i < ocs.length; i++) {
        NSString *c = [ocs substringWithRange:NSMakeRange(i, 1)];
        if ([kArr containsObject:c]) {
            NSUInteger idx = [kArr indexOfObject:c];
            int cnt = [[vArr objectAtIndex:idx] intValue];
            [vArr replaceObjectAtIndex:idx withObject:@(cnt + 1)];
        } else {
            [kArr addObject:c];
            [vArr addObject:@1];
        }
    }
    for (int i = 0; i < vArr.count - 1; i ++) {
        for (int j = 0; j < vArr.count - 1 - i; j++) {
            int a = [[vArr objectAtIndex:j] intValue];
            int b = [[vArr objectAtIndex:j + 1] intValue];
            if (a < b) {
                [vArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                [kArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                continue;
            }
            if (a == b) {
                char m = [[kArr objectAtIndex:j] characterAtIndex:0];
                char n = [[kArr objectAtIndex:j + 1] characterAtIndex:0];
                if (m > n) {
                    [vArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                    [kArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                }
            }
        }
    }
    NSString *ss = [kArr componentsJoinedByString:@""];
    printf("%s", ss.UTF8String);
    
}

//描述
//将一个字符串str的内容颠倒过来，并输出。
//
//数据范围：1≤len(str)≤10000
//输入描述：
//输入一个字符串，可以有空格
//
//输出描述：
//输出逆序的字符串
void HJ106() {
    char str[10000];
    gets(str);
    NSString *ocs = [NSString stringWithFormat:@"%s", str];
    for (int i = ocs.length - 1; i >= 0; i--) {
        NSString *s = [ocs substringWithRange:NSMakeRange(i, 1)];
        printf("%s", s.UTF8String);
    }
}

//描述
//正整数A和正整数B 的最小公倍数是指 能被A和B整除的最小的正整数值，设计一个算法，求输入A和B的最小公倍数。
//
//数据范围：1≤a,b≤100000
//输入描述：
//输入两个正整数A和B。
//
//输出描述：
//输出A和B的最小公倍数。

// 最大公约数
int gcd(int a, int b) {
    if (a < b) {
        int c = b;
        b = a;
        a = c;
    }
    if (a % b == 0) {
        return b;
    }
    return gcd(b, a % b);
}

int gcd_2(int a, int b) {
    if (a == b) {
        return b;
    }
    if (a > b) {
        return gcd_2(b, a - b);
    }
    return gcd(a, b - a);
}

void HJ108() {
    // a * b = a、b的最大公约数 * a、b的最小公倍数
    int a, b;
    scanf("%d %d", &a, &b);
    int gy = gcd_2(a, b);
    int gb = a * b / gy;
    printf("%d", gb);
}

// 简单题
void EasyTest () {
    // 1、HJ1 字符串最后一个单词的长度
//    HJ1();
    
    // 2、HJ2 计算某字符出现次数
//    HJ2();
    
    // 3、HJ4 字符串分隔
//    HJ4();
    
    // 4、HJ5 进制转换
//    HJ5();
    
    // 5、HJ6 质数因子
//    HJ6();
    
    // 6、HJ8 合并表记录
//    HJ8();
    
    // 7、HJ10 字符个数统计
//    HJ10();
    
    // 8、HJ11 数字颠倒
//    HJ11();
    
    // 9、HJ12 字符串反转
//    HJ12();
    
    // 10、HJ13 句子逆序
//    HJ13();
    
    // 11、HJ14 字符串排序
//    HJ14();
    
    // 12、HJ15 求int型正整数在内存中存储时1的个数
//    HJ15();
    
    // 13、HJ21 简单密码
//    HJ21();
    
    // 14、HJ22 汽水瓶
//    HJ22();
    
    // 15、HJ23 删除字符串中出现次数最少的字符
//    HJ23();
    
    // 16、HJ31 单词倒排
//    HJ31();
    
    // 17、HJ34 图片整理
//    HJ34();
    
    // 18、HJ35 蛇形矩阵
//    HJ35();
    
    // 19、HJ36 统计每个月兔子的总数
//    HJ36();
    
    // 20、HJ40 统计字符
//    HJ40();
    
    // 21、HJ51 输出单向链表中倒数第k个结点
    HJ51();
    
    // 22、HJ53 杨辉三角的变形
    HJ53();
    
    // 23、HJ54 表达式求值
    HJ54();
    
    // 24、HJ56 完全数计算
//    HJ56();
    
    // 25、HJ60 查找组成一个偶数最接近的两个素数
//    HJ60();
    
    // 26、HJ61 放苹果
    HJ61();
    
    // 27、HJ62 查找输入整数二进制中1的个数
//    HJ62();
    
    // 28、HJ72 百钱买百鸡问题
//    HJ72();
    
    // 29、HJ73 计算日期到天数转换
//    HJ73();
    
    // 30、HJ76 尼科彻斯定理
//    HJ76();
    
    // 31、HJ80 整型数组合并
//    HJ80();
    
    // 32、HJ81 字符串字符匹配
//    HJ81();
    
    // 33、HJ83 二维数组操作
//    HJ83();
    
    // 34、HJ84 统计大写字母个数
//    HJ84();
    
    // 35、HJ85 最长回文子串
//    HJ85();
    
    // 36、HJ86 求最大连续bit数
//    HJ86();
    
    // 37、HJ87 密码强度等级
//    HJ87();
    
    // 38、HJ91 走方格的方案数
    HJ91();
    
    // 39、HJ94 记票统计
//    HJ94();
    
    // 40、HJ96 表示数字
//    HJ96();
    
    // 41、HJ97 记负均正
//    HJ97();
    
    // 42、HJ99 自守数
//    HJ99();
    
    // 43、HJ100 等差数列
//    HJ100();
    
    // 44、HJ102 字符统计
//    HJ102();
    
    // 45、HJ106 字符逆序
//    HJ106();
    
    // 46、HJ108 求最小公倍数
//    HJ108();
}

// 中等题
void MediumDifficultyTest() {
    // 1、HJ16 购物单
//    HJ16();
    
    // 5、HJ26 字符串排序
//    HJ26();
    
    // 7、HJ29 字符串加解密
//    HJ29();
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        EasyTest();
        
        MediumDifficultyTest();
    }
    return 0;
}
