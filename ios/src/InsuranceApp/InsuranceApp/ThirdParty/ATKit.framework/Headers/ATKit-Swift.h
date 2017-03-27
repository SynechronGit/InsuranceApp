// Generated by Apple Swift version 3.0.2 (swiftlang-800.0.63 clang-800.0.42.1)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
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
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
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
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import ObjectiveC;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSCoder;

SWIFT_CLASS("_TtC5ATKit8ATButton")
@interface ATButton : UIButton
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIImage;
@class UITouch;
@class UIEvent;

SWIFT_CLASS("_TtC5ATKit10ATCheckbox")
@interface ATCheckbox : UIControl
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)pDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
- (void)awakeFromNib;
- (void)layoutSubviews;
- (void)drawRect:(CGRect)rect;
@property (nonatomic) UITextBorderStyle borderStyle;
@property (nonatomic) BOOL checked;
@property (nonatomic, strong) UIImage * _Null_unspecified checkedControlStateImage;
@property (nonatomic, strong) UIImage * _Null_unspecified uncheckedControlStateImage;
- (void)touchesEnded:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
@end

@class UITableView;
@class UITableViewCell;
@protocol ATDrawerDelegate;

SWIFT_CLASS("_TtC5ATKit8ATDrawer")
@interface ATDrawer : NSObject <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray<NSString *> * _Null_unspecified drawerOptions;
@property (nonatomic, weak) id <ATDrawerDelegate> _Null_unspecified delegate;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) ATDrawer * _Nonnull sharedInstance;)
+ (ATDrawer * _Nonnull)sharedInstance;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (void)show;
- (void)hide;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end


SWIFT_PROTOCOL("_TtP5ATKit16ATDrawerDelegate_")
@protocol ATDrawerDelegate <NSObject>
@optional
- (void)atDrawer:(ATDrawer * _Nonnull)pSender didSelectOptionAtIndex:(NSInteger)pIndex;
@end

@class ATDropdownMenu;
@class ATDropdownOption;

SWIFT_PROTOCOL("_TtP5ATKit22ATDropdownMenuDelegate_")
@protocol ATDropdownMenuDelegate
@optional
- (void)dropdownMenu:(ATDropdownMenu * _Nonnull)pDropdownMenu didSelectOption:(ATDropdownOption * _Nonnull)pOption;
- (void)dropdownMenuDidDone:(ATDropdownMenu * _Nonnull)pDropdownMenu;
@end

@class UIFont;
@class UIColor;
@class UIView;

SWIFT_CLASS("_TtC5ATKit10ATDropdown")
@interface ATDropdown : UIControl <ATDropdownMenuDelegate>
@property (nonatomic, copy) NSArray<ATDropdownOption *> * _Null_unspecified options;
@property (nonatomic, copy) NSArray<ATDropdownOption *> * _Null_unspecified selectedOptions;
@property (nonatomic) BOOL allowMultipleSelection;
@property (nonatomic) UITextBorderStyle borderStyle;
@property (nonatomic, copy) NSString * _Null_unspecified placeholder;
@property (nonatomic, copy) NSString * _Null_unspecified text;
@property (nonatomic, strong) UIFont * _Null_unspecified font;
@property (nonatomic, strong) UIColor * _Null_unspecified textColor;
@property (nonatomic, strong) UIColor * _Null_unspecified placeholderColor;
@property (nonatomic, strong) UIView * _Null_unspecified rightView;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)pDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
- (void)awakeFromNib;
- (void)layoutSubviews;
- (void)drawRect:(CGRect)rect;
- (void)touchesEnded:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)dropdownMenu:(ATDropdownMenu * _Nonnull)pDropdownMenu didSelectOption:(ATDropdownOption * _Nonnull)pOption;
- (void)dropdownMenuDidDone:(ATDropdownMenu * _Nonnull)pDropdownMenu;
@end


SWIFT_CLASS("_TtC5ATKit14ATDropdownMenu")
@interface ATDropdownMenu : NSObject <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray<ATDropdownOption *> * _Null_unspecified options;
@property (nonatomic, copy) NSArray<ATDropdownOption *> * _Null_unspecified selectedOptions;
@property (nonatomic) BOOL allowMultipleSelection;
@property (nonatomic, weak) id <ATDropdownMenuDelegate> _Null_unspecified delegate;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) ATDropdownMenu * _Nonnull sharedInstance;)
+ (ATDropdownMenu * _Nonnull)sharedInstance;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (void)show;
- (void)hide;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end



SWIFT_CLASS("_TtC5ATKit16ATDropdownOption")
@interface ATDropdownOption : NSObject
@property (nonatomic, copy) NSString * _Null_unspecified title;
@property (nonatomic, copy) NSString * _Null_unspecified value;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithTitle:(NSString * _Null_unspecified)pTitle value:(NSString * _Null_unspecified)pValue OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit6ATFile")
@interface ATFile : NSObject
@property (nonatomic, copy) NSString * _Null_unspecified title;
@property (nonatomic, copy) NSString * _Null_unspecified extension;
@property (nonatomic, copy) NSData * _Null_unspecified data;
@property (nonatomic, copy) NSURL * _Null_unspecified url;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIViewController;
@class UIActionSheet;
@class UIImagePickerController;
@class UIDocumentPickerViewController;
@protocol ATFilePickerDelegate;

SWIFT_CLASS("_TtC5ATKit12ATFilePicker")
@interface ATFilePicker : NSObject <UIActionSheetDelegate, UIDocumentPickerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) id <ATFilePickerDelegate> _Null_unspecified delegate;
@property (nonatomic) BOOL allowsImageEditing;
- (void)showFromController:(UIViewController * _Nonnull)pController;
- (void)dismiss;
- (void)actionSheet:(UIActionSheet * _Nonnull)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)imagePickerController:(UIImagePickerController * _Nonnull)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> * _Nonnull)info;
- (void)imagePickerControllerDidCancel:(UIImagePickerController * _Nonnull)picker;
- (void)documentPicker:(UIDocumentPickerViewController * _Nonnull)pController didPickDocumentAtURL:(NSURL * _Nonnull)pUrl;
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController * _Nonnull)controller;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_PROTOCOL("_TtP5ATKit20ATFilePickerDelegate_")
@protocol ATFilePickerDelegate <NSObject>
@optional
- (void)atFilePickerDidCancelAtFilePicker:(ATFilePicker * _Nonnull)pSender;
- (void)atFilePickerAtFilePicker:(ATFilePicker * _Nonnull)pSender didSelectFile:(ATFile * _Nonnull)pFile;
@end

@protocol ATImagePickerDelegate;

SWIFT_CLASS("_TtC5ATKit13ATImagePicker")
@interface ATImagePicker : NSObject <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) id <ATImagePickerDelegate> _Null_unspecified delegate;
- (void)showFromController:(UIViewController * _Nonnull)pController;
- (void)dismiss;
- (void)actionSheet:(UIActionSheet * _Nonnull)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)imagePickerController:(UIImagePickerController * _Nonnull)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> * _Nonnull)info;
- (void)imagePickerControllerDidCancel:(UIImagePickerController * _Nonnull)picker;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_PROTOCOL("_TtP5ATKit21ATImagePickerDelegate_")
@protocol ATImagePickerDelegate <NSObject>
@optional
- (void)atImagePickerDidCancelAtImagePicker:(ATImagePicker * _Nonnull)pSender;
- (void)atImagePickerAtImagePicker:(ATImagePicker * _Nonnull)pSender didSelectImage:(UIImage * _Nonnull)pImage;
@end


SWIFT_CLASS("_TtC5ATKit11ATImageView")
@interface ATImageView : UIImageView
@property (nonatomic, copy) NSURL * _Null_unspecified imageUrl;
- (nonnull instancetype)initWithImage:(UIImage * _Nullable)image OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithImage:(UIImage * _Nullable)image highlightedImage:(UIImage * _Nullable)highlightedImage OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit17ATInteractiveView")
@interface ATInteractiveView : UIControl
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor * _Null_unspecified borderColor;
@property (nonatomic) CGFloat cornerRadius;
- (void)layoutSubviews;
- (void)touchesEnded:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit5ATKit")
@interface ATKit : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull frameworkVersion;)
+ (NSString * _Nonnull)frameworkVersion;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

enum LTMorphingEffect : NSInteger;
@protocol LTMorphingLabelDelegate;

SWIFT_CLASS("_TtC5ATKit15LTMorphingLabel")
@interface LTMorphingLabel : UILabel
@property (nonatomic) float morphingProgress;
@property (nonatomic) float morphingDuration;
@property (nonatomic) float morphingCharacterDelay;
@property (nonatomic) BOOL morphingEnabled;
@property (nonatomic, weak) IBOutlet id <LTMorphingLabelDelegate> _Nullable delegate;
@property (nonatomic) enum LTMorphingEffect morphingEffect;
@property (nonatomic, strong) UIFont * _Null_unspecified font;
@property (nonatomic, copy) NSString * _Null_unspecified text;
- (void)setNeedsLayout;
@property (nonatomic) CGRect bounds;
@property (nonatomic) CGRect frame;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit7ATLabel")
@interface ATLabel : LTMorphingLabel
@property (nonatomic) BOOL shouldDisplayUnderline;
@property (nonatomic) float animationDuration;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)pDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
- (void)awakeFromNib;
- (void)drawRect:(CGRect)rect;
- (void)drawTextInRect:(CGRect)rect;
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)limitedToNumberOfLines;
@property (nonatomic, copy) NSString * _Null_unspecified animatedText;
@end


SWIFT_CLASS("_TtC5ATKit10ATLineView")
@interface ATLineView : UIView
@property (nonatomic) float width;
@property (nonatomic, strong) UIColor * _Nonnull color;
@property (nonatomic) float rotationAngleInDegrees;
- (void)layoutSubviews;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class ATNetworkManagerAttachment;
@class ATNetworkManagerResult;
@protocol ATNetworkManagerDelegate;

SWIFT_CLASS("_TtC5ATKit16ATNetworkManager")
@interface ATNetworkManager : NSObject
@property (nonatomic) BOOL enableLogging;
@property (nonatomic, copy) NSString * _Null_unspecified requestId;
@property (nonatomic, copy) NSString * _Nonnull urlString;
@property (nonatomic, copy) NSString * _Nonnull httpMethod;
@property (nonatomic, copy) NSArray<NSDictionary<NSString *, NSString *> *> * _Null_unspecified httpRequestHeaders;
@property (nonatomic, copy) NSData * _Null_unspecified httpRequestBody;
@property (nonatomic, copy) NSDictionary<NSString *, NSData *> * _Null_unspecified httpRequestParameters;
@property (nonatomic, copy) NSArray<ATNetworkManagerAttachment *> * _Null_unspecified httpRequestAttachments;
@property (nonatomic) BOOL encodeAttachmentsInBase64;
@property (nonatomic, copy) NSString * _Null_unspecified authenticationUsername;
@property (nonatomic, copy) NSString * _Null_unspecified authenticationPassword;
@property (nonatomic, copy) NSString * _Null_unspecified authenticationDomain;
@property (nonatomic, weak) id <ATNetworkManagerDelegate> _Null_unspecified delegate;
- (void)sendRequestWithAsynchronously:(BOOL)pAsynchronously;
- (void)sendRequestWithCompletion:(void (^ _Nonnull)(ATNetworkManagerResult * _Nonnull))pCompletion;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit26ATNetworkManagerAttachment")
@interface ATNetworkManagerAttachment : NSObject
@property (nonatomic, copy) NSString * _Null_unspecified requestParameterName;
@property (nonatomic, copy) NSString * _Null_unspecified fileTitle;
@property (nonatomic, copy) NSString * _Null_unspecified fileExtension;
@property (nonatomic, copy) NSData * _Null_unspecified fileData;
- (nonnull instancetype)initWithRequestParameterName:(NSString * _Null_unspecified)pRequestParameterName fileTitle:(NSString * _Null_unspecified)pFileTitle fileExtenstion:(NSString * _Null_unspecified)pFileExtenstion fileData:(NSData * _Null_unspecified)pFileData OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_PROTOCOL("_TtP5ATKit24ATNetworkManagerDelegate_")
@protocol ATNetworkManagerDelegate
@optional
- (void)atNetworkManagerDidExecuteRequestWithSender:(ATNetworkManager * _Nonnull)pSender requestId:(NSString * _Nonnull)pRequestId result:(ATNetworkManagerResult * _Nonnull)pResult;
- (void)atNetworkManagerDidProgressWithSender:(ATNetworkManager * _Nonnull)pSender requestId:(NSString * _Nonnull)pRequestId progress:(NSInteger)pProgress;
@end

@class NSError;

SWIFT_CLASS("_TtC5ATKit22ATNetworkManagerResult")
@interface ATNetworkManagerResult : NSObject
@property (nonatomic, strong) id _Null_unspecified result;
@property (nonatomic, strong) NSError * _Null_unspecified error;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit9ATOverlay")
@interface ATOverlay : NSObject
@property (nonatomic, copy) NSString * _Null_unspecified message;
@property (nonatomic) BOOL shouldBlurBackground;
@property (nonatomic, strong) UIView * _Null_unspecified customActivityIndicatorView;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) ATOverlay * _Nonnull sharedInstance;)
+ (ATOverlay * _Nonnull)sharedInstance;
- (void)show;
- (void)showWithMessage:(NSString * _Null_unspecified)pMessage;
- (void)hide;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit11ATTableView")
@interface ATTableView : UITableView
- (nonnull instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit11ATTextField")
@interface ATTextField : UITextField <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, copy) NSCharacterSet * _Null_unspecified allowedCharacterSet;
@property (nonatomic, weak) id <UITextFieldDelegate> _Null_unspecified forwardDelegate;
@property (nonatomic) BOOL shouldAdjustPanForKeyboard;
@property (nonatomic) BOOL shouldDismissKeyboardOnReturn;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)pDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
- (void)awakeFromNib;
- (void)removeFromSuperview;
- (void)layoutSubviews;
@property (nonatomic, strong) id <UITextFieldDelegate> _Nullable delegate;
@property (nonatomic, copy) NSArray<NSString *> * _Null_unspecified suggestions;
- (BOOL)atTextField:(UITextField * _Nonnull)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString * _Nonnull)string;
- (BOOL)textFieldShouldBeginEditing:(UITextField * _Nonnull)textField;
- (void)textFieldDidBeginEditing:(UITextField * _Nonnull)textField;
- (BOOL)textFieldShouldEndEditing:(UITextField * _Nonnull)textField;
- (void)textFieldDidEndEditing:(UITextField * _Nonnull)textField;
- (BOOL)textField:(UITextField * _Nonnull)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString * _Nonnull)string;
- (BOOL)textFieldShouldClear:(UITextField * _Nonnull)textField;
- (BOOL)textFieldShouldReturn:(UITextField * _Nonnull)textField;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end

@class NSTextAttachment;
@class NSTextContainer;

SWIFT_CLASS("_TtC5ATKit10ATTextView")
@interface ATTextView : UITextView <UIScrollViewDelegate, UITextViewDelegate>
@property (nonatomic, copy) NSCharacterSet * _Null_unspecified allowedCharacterSet;
@property (nonatomic, weak) id <UITextViewDelegate> _Null_unspecified forwardDelegate;
@property (nonatomic, copy) NSString * _Null_unspecified placeholder;
@property (nonatomic) UITextBorderStyle borderStyle;
@property (nonatomic) BOOL shouldAdjustPanForKeyboard;
@property (nonatomic) BOOL shouldDismissKeyboardOnReturn;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)pDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)awakeFromNib;
- (void)layoutSubviews;
@property (nonatomic, strong) id <UITextViewDelegate> _Nullable delegate;
- (BOOL)atTextView:(UITextView * _Nonnull)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString * _Nonnull)string;
- (BOOL)textViewShouldBeginEditing:(UITextView * _Nonnull)textView;
- (void)textViewDidBeginEditing:(UITextView * _Nonnull)textView;
- (void)textViewDidChange:(UITextView * _Nonnull)textView;
- (void)textViewDidChangeSelection:(UITextView * _Nonnull)textView;
- (BOOL)textViewShouldEndEditing:(UITextView * _Nonnull)textView;
- (void)textViewDidEndEditing:(UITextView * _Nonnull)textView;
- (BOOL)textView:(UITextView * _Nonnull)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString * _Nonnull)text;
- (BOOL)textView:(UITextView * _Nonnull)textView shouldInteractWithURL:(NSURL * _Nonnull)URL inRange:(NSRange)characterRange;
- (BOOL)textView:(UITextView * _Nonnull)textView shouldInteractWithTextAttachment:(NSTextAttachment * _Nonnull)textAttachment inRange:(NSRange)characterRange;
- (nonnull instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer * _Nullable)textContainer SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC5ATKit7ATToast")
@interface ATToast : NSObject
@property (nonatomic, copy) NSString * _Null_unspecified message;
@property (nonatomic, strong) UIColor * _Nonnull darkToastMessageColor;
@property (nonatomic, strong) UIColor * _Nonnull darkToastBackgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull darkToastBorderColor;
@property (nonatomic, strong) UIColor * _Nonnull informationToastMessageColor;
@property (nonatomic, strong) UIColor * _Nonnull informationToastBackgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull informationToastBorderColor;
@property (nonatomic, strong) UIColor * _Nonnull successToastMessageColor;
@property (nonatomic, strong) UIColor * _Nonnull successToastBackgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull successToastBorderColor;
@property (nonatomic, strong) UIColor * _Nonnull errorToastMessageColor;
@property (nonatomic, strong) UIColor * _Nonnull errorToastBackgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull errorToastBorderColor;
@property (nonatomic, strong) UIColor * _Nonnull warningToastMessageColor;
@property (nonatomic, strong) UIColor * _Nonnull warningToastBackgroundColor;
@property (nonatomic, strong) UIColor * _Nonnull warningToastBorderColor;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) ATToast * _Nonnull sharedInstance;)
+ (ATToast * _Nonnull)sharedInstance;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (void)showWithMessage:(NSString * _Null_unspecified)pMessage;
- (void)hide;
@end


SWIFT_CLASS("_TtC5ATKit16ATTransitionView")
@interface ATTransitionView : UIView
@property (nonatomic, copy) NSArray<UIImage *> * _Null_unspecified images;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)pDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
- (void)awakeFromNib;
@end


SWIFT_CLASS("_TtC5ATKit7ATUtils")
@interface ATUtils : NSObject
+ (float)degreesToRadians:(float)pDegrees;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit6ATView")
@interface ATView : UIView
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC5ATKit8ATWindow")
@interface ATWindow : UIWindow
@property (nonatomic, copy) NSArray<NSString *> * _Null_unspecified nonKeyboardDismissingRestorationIds;
@property (nonatomic) BOOL shouldAdjustPanForKeyboard;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)pDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)awakeFromNib;
@end


SWIFT_CLASS("_TtC5ATKit13LTEmitterView")
@interface LTEmitterView : UIView
- (void)removeAllEmitters;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

typedef SWIFT_ENUM(NSInteger, LTMorphingEffect) {
  LTMorphingEffectNone = 0,
  LTMorphingEffectScale = 1,
  LTMorphingEffectEvaporate = 2,
  LTMorphingEffectFall = 3,
  LTMorphingEffectPixelate = 4,
  LTMorphingEffectSparkle = 5,
  LTMorphingEffectBurn = 6,
  LTMorphingEffectAnvil = 7,
};



@interface LTMorphingLabel (SWIFT_EXTENSION(ATKit))
@end


@interface LTMorphingLabel (SWIFT_EXTENSION(ATKit))
@end


@interface LTMorphingLabel (SWIFT_EXTENSION(ATKit))
@end


@interface LTMorphingLabel (SWIFT_EXTENSION(ATKit))
- (void)didMoveToSuperview;
- (void)drawTextInRect:(CGRect)rect;
@end


@interface LTMorphingLabel (SWIFT_EXTENSION(ATKit))
@end


@interface LTMorphingLabel (SWIFT_EXTENSION(ATKit))
@end


@interface LTMorphingLabel (SWIFT_EXTENSION(ATKit))
@end


@interface LTMorphingLabel (SWIFT_EXTENSION(ATKit))
@end


SWIFT_PROTOCOL("_TtP5ATKit23LTMorphingLabelDelegate_")
@protocol LTMorphingLabelDelegate
@optional
- (void)morphingDidStart:(LTMorphingLabel * _Nonnull)label;
- (void)morphingDidComplete:(LTMorphingLabel * _Nonnull)label;
- (void)morphingOnProgress:(LTMorphingLabel * _Nonnull)label progress:(float)progress;
@end


@interface NSObject (SWIFT_EXTENSION(ATKit))
@property (nonatomic, readonly, copy) NSString * _Nonnull className;
@end


@interface UIColor (SWIFT_EXTENSION(ATKit))
- (nonnull instancetype)initWithHexString:(NSString * _Nonnull)pHexString;
@property (nonatomic, readonly) CGFloat redComponent;
@property (nonatomic, readonly) CGFloat greenComponent;
@property (nonatomic, readonly) CGFloat blueComponent;
@property (nonatomic, readonly) CGFloat alphaComponent;
@end


@interface UIDevice (SWIFT_EXTENSION(ATKit))
@property (nonatomic, readonly) BOOL isDevice;
@property (nonatomic, readonly) BOOL isSimulator;
@property (nonatomic, readonly) BOOL isIphone;
@property (nonatomic, readonly) BOOL isIphone4;
@property (nonatomic, readonly) BOOL isIphone5;
@property (nonatomic, readonly) BOOL isIphone6;
@property (nonatomic, readonly) BOOL isIphone6Plus;
@property (nonatomic, readonly) BOOL isIpad;
@property (nonatomic, readonly) BOOL isIpadPro;
@end


@interface UIImage (SWIFT_EXTENSION(ATKit))
+ (UIImage * _Null_unspecified)animatedImageWithGifDataWithData:(NSData * _Nonnull)pData;
@property (nonatomic, readonly, strong) UIImage * _Nonnull imageByFixingOrientation;
@end


@interface UIView (SWIFT_EXTENSION(ATKit))
@property (nonatomic, readonly, strong) UIImage * _Null_unspecified toImage;
- (UIView * _Nullable)firstResponder;
- (UIView * _Nullable)viewWithRestorationIdentifier:(NSString * _Nonnull)pRestorationIdentifier;
@end

#pragma clang diagnostic pop
