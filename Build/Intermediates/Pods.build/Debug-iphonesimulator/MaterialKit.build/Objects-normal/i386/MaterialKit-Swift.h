// Generated by Apple Swift version 2.1 (swiftlang-700.1.101.6 clang-700.1.76)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIColor;
@class NSCoder;
@class UITouch;
@class UIEvent;

SWIFT_CLASS("_TtC11MaterialKit8MKButton")
@interface MKButton : UIButton
@property (nonatomic) BOOL maskEnabled;
@property (nonatomic) float ripplePercent;
@property (nonatomic) CGFloat backgroundLayerCornerRadius;
@property (nonatomic) BOOL shadowAniEnabled;
@property (nonatomic) BOOL backgroundAniEnabled;
@property (nonatomic) float rippleAniDuration;
@property (nonatomic) float backgroundAniDuration;
@property (nonatomic) float shadowAniDuration;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor * __nonnull rippleLayerColor;
@property (nonatomic, strong) UIColor * __nonnull backgroundLayerColor;
@property (nonatomic) CGRect bounds;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (BOOL)beginTrackingWithTouch:(UITouch * __nonnull)touch withEvent:(UIEvent * __nullable)event;
@end

@class UIImage;

SWIFT_CLASS("_TtC11MaterialKit11MKImageView")
@interface MKImageView : UIImageView
@property (nonatomic) BOOL maskEnabled;
@property (nonatomic) float rippleAniDuration;
@property (nonatomic) float backgroundAniDuration;
@property (nonatomic) BOOL backgroundAniEnabled;
@property (nonatomic) float ripplePercent;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor * __nonnull rippleLayerColor;
@property (nonatomic, strong) UIColor * __nonnull backgroundLayerColor;
@property (nonatomic) CGRect bounds;
- (nonnull instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithImage:(UIImage * __null_unspecified)image OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithImage:(UIImage * __null_unspecified)image highlightedImage:(UIImage * __nullable)highlightedImage OBJC_DESIGNATED_INITIALIZER;
- (void)touchesBegan:(NSSet<UITouch *> * __nonnull)touches withEvent:(UIEvent * __nullable)event;
@end


SWIFT_CLASS("_TtC11MaterialKit7MKLabel")
@interface MKLabel : UILabel
@property (nonatomic) BOOL maskEnabled;
@property (nonatomic) float rippleAniDuration;
@property (nonatomic) float backgroundAniDuration;
@property (nonatomic) BOOL backgroundAniEnabled;
@property (nonatomic) float ripplePercent;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor * __nonnull rippleLayerColor;
@property (nonatomic, strong) UIColor * __nonnull backgroundLayerColor;
@property (nonatomic) CGRect bounds;
- (nonnull instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)touchesBegan:(NSSet<UITouch *> * __nonnull)touches withEvent:(UIEvent * __nullable)event;
@end


SWIFT_CLASS("_TtC11MaterialKit15MKTableViewCell")
@interface MKTableViewCell : UITableViewCell
@property (nonatomic) float rippleAniDuration;
@property (nonatomic) float backgroundAniDuration;
@property (nonatomic) BOOL shadowAniEnabled;
@property (nonatomic, strong) UIColor * __nonnull rippleLayerColor;
@property (nonatomic, strong) UIColor * __nonnull backgroundLayerColor;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * __nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)touchesBegan:(NSSet<UITouch *> * __nonnull)touches withEvent:(UIEvent * __nullable)event;
@end

@class UIFont;

SWIFT_CLASS("_TtC11MaterialKit11MKTextField")
@interface MKTextField : UITextField
@property (nonatomic) CGSize padding;
@property (nonatomic) CGFloat floatingLabelBottomMargin;
@property (nonatomic) BOOL floatingPlaceholderEnabled;
@property (nonatomic) float rippleAniDuration;
@property (nonatomic) float backgroundAniDuration;
@property (nonatomic) BOOL shadowAniEnabled;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor * __nonnull rippleLayerColor;
@property (nonatomic, strong) UIColor * __nonnull backgroundLayerColor;
@property (nonatomic, strong) UIFont * __nonnull floatingLabelFont;
@property (nonatomic, strong) UIColor * __nonnull floatingLabelTextColor;
@property (nonatomic) BOOL bottomBorderEnabled;
@property (nonatomic) CGFloat bottomBorderWidth;
@property (nonatomic, strong) UIColor * __nonnull bottomBorderColor;
@property (nonatomic) CGFloat bottomBorderHighlightWidth;
@property (nonatomic, copy) NSString * __nullable placeholder;
@property (nonatomic) CGRect bounds;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (BOOL)beginTrackingWithTouch:(UITouch * __nonnull)touch withEvent:(UIEvent * __nullable)event;
- (void)layoutSubviews;
- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
@end


@interface MKTextField (SWIFT_EXTENSION(MaterialKit))
@end


@interface UIColor (SWIFT_EXTENSION(MaterialKit))
- (nonnull instancetype)initWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
@end

#pragma clang diagnostic pop
