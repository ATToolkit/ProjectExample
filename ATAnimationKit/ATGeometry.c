//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#include "ATGeometry.h"

#include <math.h>

#pragma mark - Translation(Affine)

CGFloat ATGetAffineTranslationX(CGAffineTransform transform)
{
  return transform.tx;
}

CGFloat ATGetAffineTranslationY(CGAffineTransform transform)
{
  return transform.ty;
}

#pragma mark - Scale(Affine)

CGFloat ATGetAffineScaleX(CGAffineTransform transform)
{
  return transform.a;
}
CGFloat ATGetAffineScaleY(CGAffineTransform transform)
{
  return transform.d;
}

#pragma mark - Rotation(Affine)

CGFloat ATGetAffineRotation(CGAffineTransform transform)
{
  return FLT_MAX;
}

#pragma mark - Translation(3D)

CGFloat ATGet3DTranslationX(CATransform3D transform)
{
  return transform.m41;
}
CGFloat ATGet3DTranslationY(CATransform3D transform)
{
  return transform.m42;
}
CGFloat ATGet3DTranslationZ(CATransform3D transform)
{
  return transform.m43;
}

#pragma mark - Scale(3D)

CGFloat ATGet3DScaleX(CATransform3D transform)
{
  return transform.m11;
}
CGFloat ATGet3DScaleY(CATransform3D transform)
{
  return transform.m22;
}
CGFloat ATGet3DScaleZ(CATransform3D transform)
{
  return transform.m33;
}

#pragma mark - Rotation(3D)

CGFloat ATGet3DRotationX(CATransform3D transform)
{
  return FLT_MAX;
}
CGFloat ATGet3DRotationY(CATransform3D transform)
{
  return FLT_MAX;
}
CGFloat ATGet3DRotationZ(CATransform3D transform)
{
  return FLT_MAX;
}
