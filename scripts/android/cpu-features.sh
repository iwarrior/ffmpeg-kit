#!/bin/bash

#$(android_ndk_cmake) -DBUILD_PIC=ON || return 1
 cmd="$(android_ndk_cmake)"
 if [[ "$cmd" == *"cmake "* ]]; then
   # 'cmake' 실행 파일 이후의 인자만 떼서, PATH의 cmake로 실행
   args="${cmd#*cmake }"
   cmake $args -DBUILD_PIC=ON || return 1
 else
   # 함수가 순수 경로만 돌려주는 경우(공백 경로 보호)
   "$cmd" -DBUILD_PIC=ON || return 1
 fi
#make -C "$(get_cmake_build_directory)" || return 1

#make -C "$(get_cmake_build_directory)" install || return 1

cmake --build "$(get_cmake_build_directory)" --config Release || return 1
cmake --build "$(get_cmake_build_directory)" --config Release --target install || return 1

# CREATE PACKAGE CONFIG MANUALLY
create_cpufeatures_package_config "0.7.0" || return 1
