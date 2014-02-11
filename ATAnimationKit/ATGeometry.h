//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#ifndef ATGEOMETRY_H_
#define ATGEOMETRY_H_

#include <ATBase/ATBaseDefines.h>

#include <CoreGraphics/CGAffineTransform.h>

#include <QuartzCore/CATransform3D.h>

#pragma mark - Translation(Affine)

AT_EXTERN CGFloat ATGetAffineTranslationX(CGAffineTransform transform);
AT_EXTERN CGFloat ATGetAffineTranslationY(CGAffineTransform transform);

#pragma mark - Scale(Affine)

AT_EXTERN CGFloat ATGetAffineScaleX(CGAffineTransform transform);
AT_EXTERN CGFloat ATGetAffineScaleY(CGAffineTransform transform);

#pragma mark - Rotation(Affine)

AT_EXTERN CGFloat ATGetAffineRotation(CGAffineTransform transform);

#pragma mark - Translation(3D)

AT_EXTERN CGFloat ATGet3DTranslationX(CATransform3D transform);
AT_EXTERN CGFloat ATGet3DTranslationY(CATransform3D transform);
AT_EXTERN CGFloat ATGet3DTranslationZ(CATransform3D transform);

#pragma mark - Scale(3D)

AT_EXTERN CGFloat ATGet3DScaleX(CATransform3D transform);
AT_EXTERN CGFloat ATGet3DScaleY(CATransform3D transform);
AT_EXTERN CGFloat ATGet3DScaleZ(CATransform3D transform);

#pragma mark - Rotation(3D)

AT_EXTERN CGFloat ATGet3DRotationX(CATransform3D transform);
AT_EXTERN CGFloat ATGet3DRotationY(CATransform3D transform);
AT_EXTERN CGFloat ATGet3DRotationZ(CATransform3D transform);

#endif /* ATGEOMETRY_H_ */
