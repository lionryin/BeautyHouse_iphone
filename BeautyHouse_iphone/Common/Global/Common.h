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