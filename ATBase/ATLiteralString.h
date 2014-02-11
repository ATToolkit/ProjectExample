//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.
//

#if __has_feature(objc_arc)
typedef __unsafe_unretained NSString *const ATLiteralString;
#else
typedef NSString *const ATLiteralString;
#endif