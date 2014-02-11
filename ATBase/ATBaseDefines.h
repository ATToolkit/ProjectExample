//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#ifndef ATBASEDEFINES_H_
#define ATBASEDEFINES_H_

#if defined(__cplusplus)
#define AT_EXTERN extern "C"
#else
#define AT_EXTERN extern
#endif

#if defined(__cplusplus)
#if __has_attribute(always_inline)
#define AT_INLINE inline __attribute__((always_inline))
#else
#define AT_INLINE inline
#endif
#else
#if __has_attribute(always_inline)
#define AT_INLINE static inline __attribute__((always_inline))
#else
#define AT_INLINE static inline
#endif
#endif

#endif /* ATBASEDEFINES_H_ */
