#if !defined(__i386__)
#error "No machine target, or not i386."
#endif

#if defined(__linux__)
#error "Linux is being targeted."
#endif

#if defined(__win32__)
#error "Windows32 is being targeted."
#endif

#if defined(__win64__)
#error "Windows64 is being targeted."
#endif

