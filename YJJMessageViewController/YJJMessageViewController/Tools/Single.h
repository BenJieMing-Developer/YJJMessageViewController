#define SingleH(name) +(instancetype)share##name;
#if __has_feature(objc_arc)
#define SingleM(name) static id _tool;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
       _tool=[super allocWithZone:zone];\
\
    });\
    return _tool;\
   \
}\
\
+(instancetype)share##name\
{\
    return [[self alloc]init];\
}\
\
-(id)copyWithZone:(NSZone *)zone\
{\
    return _tool;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
    return _tool;\
}


#else

#define SingleM(name) static  id _tool;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_tool=[super allocWithZone:zone];\
\
});\
return _tool;\
\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
\
-(id)copyWithZone:(NSZone *)zone\
{\
return _tool;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _tool;\
}\
-(oneway void)release\
{\
 \
}\
\
-(instancetype)retain\
{\
    return _tool;\
}\
\
-(NSUInteger)retainCount\
{\
    return MAXFLOAT;\
}


#endif


