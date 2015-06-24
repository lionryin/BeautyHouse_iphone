// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#define UserGlobalKey        @"UserGlobalKey"
#define UserPhoneNumberKey   @"UserPhoneNumberKey"
#define UserIsLoginKey       @"UserIsLoginKey"
#define UserLoginId          @"UserLoginId"

#define AddressGlobalKey     @"AddressGlobalKey"

#define MZB_NOTE_LOGIN_OK    @"MZB_NOTE_LOGIN_OK"//登陆成功

#define MZB_NOTE_EXIT_OK     @"MZB_NOTE_EXIT_OK"//退出登录成功




// 商户PID
#define PARTNER  @"2088711657481475"
// 商户收款账号
#define SELLER  @"meizhaikeji@sina.com"

// 商户私钥，pkcs8格式
#define  RSA_PRIVATE @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKRAL5n0/7dqKS8hA8CZFNiabdjmQYVO09+KXlNLwtYH/iyTsfZxG7RdvIWlZ1joltIAYRvn7kxosewZH8+wGSdXyHq+9i3sRm6/DhlWXQVd0wjcTZnmFiAITPiQQlOmdsZOGNavkJBu5Tgplo4KV+eoVhd/Vbun77SqiHra463LAgMBAAECgYB0PnDx9vDbsCiBkE4FitG0EmdXsG4CmK1ecaEcNmwn6fQ7PDQhBB/lYMnBlDQ2OjYzXc1cYKLINPhm7ckTxb+mdCxOZImDNLF+H7a9/hkfdFfsKcVsgASgIES4+/qTZG4lHIM+WIVrdGADUzEF9U404ZtrIvoUw1A9gPgaGZSYUQJBANFNKWgrG+Cyv3CjrSlOPTEM7LJxmxoSZMfQlSYo+/tNKKhQpLn6X2dN2kY3xGlj3buzxQZdMVasInzpAcJ8yj8CQQDI5dPg+h5+7Zoglsn6kkGPYvfTWdBLL5wYdzccrO8ouFPWudcLnD2rkGRUAgXEHzMFz9S0qWp2gNITL/FGrwF1AkBZCeJbljs908ztNjQsJkSR4VWwc/Pvm3OULX/FxBmuRpzNPcFV/NUpNU1uIbtEul9RwqBGnM6oeIITcWx2OHAxAkBaiwK4VeIisLGTWIKFlR9JIYCyV7tB954xhKFpIiPTxWe70hwylmNRDI27MwIoRyt2xhmGpwhdimej0Cq9Aaj1AkAuK5FhjdZB3Qb8xysJ0LW9MLntiCFvg9b61za5Rc2YOq4/uQPzaINyDsofOj+UqLZbtXLBXEG4HE/6wxnbVkfz"

// 支付宝公钥
#define RSA_PUBLIC  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

//生产
#define BAIDU_MAP_KEY  @"aCA0E8FmPR7gjaqxGscycGCl"

//#define BAIDU_MAP_KEY  @"NjqpyRfXRTSwciiWoqSkkDMf"




