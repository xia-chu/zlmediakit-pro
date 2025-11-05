#!/bin/bash
set -x

# Backup original CentOS-Base.repo file
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

# Define new repository configuration
cat <<EOF > /etc/yum.repos.d/CentOS-Base.repo
[base]
name=CentOS-7 - Base - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/7/os/x86_64/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-7 - Updates - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/7/updates/x86_64/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
EOF
cat > /etc/yum.repos.d/epel-aliyun.repo <<EOF
[epel]
name=Extra Packages for Enterprise Linux 7 - x86_64
baseurl=http://mirrors.aliyun.com/epel/7/x86_64/
enabled=1
gpgcheck=0
EOF
cat > /etc/yum.repos.d/CentOS-SCLo-aliyun.repo <<EOF
[C7-SCLo-rh]
name=CentOS-7 SCLo RH - x86_64
baseurl=http://mirrors.aliyun.com/centos/7/sclo/x86_64/rh/
enabled=1
gpgcheck=0
EOF

# Clean yum cache and recreate it
yum clean all
yum makecache

echo \"CentOS 7 软件源已成功切换\"

mkdir -p /root/install

yum install -y -q wget git gcc gcc-c++ m4 perl-App-cpanminus make libtool-ltdl-devel help2man which curl zip unzip tar zlib-devel perl-Time-HiRes perl-Time-Piece perl-IPC-Cmd perl-CPAN openssl-devel libcurl-devel gettext-devel expat-devel pcre2-devel perl-ExtUtils-MakeMaker devtoolset-11 rh-python38 kernel-devel kernel-headers
source /opt/rh/devtoolset-11/enable
gcc --version
source /opt/rh/rh-python38/enable
python --version

wget https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.gz > /dev/null 2>&1
tar xf autoconf-2.72.tar.gz > /dev/null 2>&1
cd autoconf-2.72
./configure --prefix=/usr > /dev/null 2>&1
make -j$(nproc) > /dev/null 2>&1
make install
cd ..

wget https://gnuftp.uib.no/help2man/help2man-1.48.3.tar.xz > /dev/null 2>&1
tar xfv help2man-1.48.3.tar.xz > /dev/null 2>&1
cd help2man-1.48.3
./configure --prefix=/usr > /dev/null 2>&1
make -j$(nproc) > /dev/null 2>&1
make install > /dev/null 2>&1
cd ..
cpanm --notest Thread::Queue > /dev/null 2>&1

wget https://ftp.gnu.org/gnu/automake/automake-1.17.tar.gz > /dev/null 2>&1
tar xf automake-1.17.tar.gz > /dev/null 2>&1
cd automake-1.17
./configure --prefix=/usr > /dev/null 2>&1
make -j$(nproc) install-exec > /dev/null 2>&1
make install > /dev/null 2>&1
cd ..

wget https://ftp.gnu.org/gnu/libtool/libtool-2.4.7.tar.gz > /dev/null 2>&1
tar xf libtool-2.4.7.tar.gz > /dev/null 2>&1
cd libtool-2.4.7
./configure --prefix=/usr > /dev/null 2>&1
make -j$(nproc) > /dev/null 2>&1
make install > /dev/null 2>&1
cd ..

wget https://ftp.gnu.org/gnu/autoconf-archive/autoconf-archive-2024.10.16.tar.xz > /dev/null 2>&1
tar xf autoconf-archive-2024.10.16.tar.xz > /dev/null 2>&1
cd autoconf-archive-2024.10.16
./configure --prefix=/usr/ > /dev/null 2>&1
make -j$(nproc) > /dev/null 2>&1
make install
cd ..

aclocal --version
autoconf --version
automake --version
libtoolize --version

cd 3rdpart/git
make configure > /dev/null 2>&1
./configure --prefix=/usr > /dev/null 2>&1
make all -j $(nproc)  > /dev/null 2>&1
make install > /dev/null 2>&1
cd ../../

cd 3rdpart/nasm
./autogen.sh > /dev/null 2>&1
./configure --prefix=/usr > /dev/null 2>&1
make -j $(nproc) > /dev/null 2>&1
make install > /dev/null 2>&1
cd ../../

wget -q https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.tar.gz  > /dev/null 2>&1
tar -xzf cmake-3.26.4-linux-x86_64.tar.gz  > /dev/null 2>&1
mv cmake-3.26.4-linux-x86_64 /usr/local/cmake-3.26.4
ln -s /usr/local/cmake-3.26.4/bin/* /usr/local/bin/

export CFLAGS="-fPIC"

export LD_LIBRARY_PATH=/root/3rdpart/stdcpp/data/x86_64:$LD_LIBRARY_PATH

cd 3rdpart/vcpkg
./bootstrap-vcpkg.sh
./vcpkg install x264 --triplet x64-linux-dynamic
cat /root/3rdpart/vcpkg/buildtrees/x264/make-all-x64-linux-dynamic-dbg-err.log

./vcpkg install jemalloc openssl libsrtp\[openssl\] harfbuzz freetype fribidi fontconfig x264 x265 openh264 opus aws-crt-cpp aws-sdk-cpp\[core,s3,transfer\] --triplet x64-linux-dynamic
cd ../../

cd 3rdpart/g7221c
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/root/install -DCMAKE_POSITION_INDEPENDENT_CODE=ON > /dev/null 2>&1
make -j $(nproc) > /dev/null 2>&1
make install > /dev/null 2>&1
cd ../../../

cd 3rdpart/fuck_svac
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug
make -j $(nproc)
make install > /dev/null 2>&1
cd ../../../

export PKG_CONFIG_PATH=/root/3rdpart/vcpkg/installed/x64-linux-dynamic/lib/pkgconfig:/root/install/lib/pkgconfig
export PKG_CONFIG_LIBDIR=/root/3rdpart/vcpkg/installed/x64-linux-dynamic/lib/pkgconfig
export LD_LIBRARY_PATH=/root/3rdpart/vcpkg/installed/x64-linux-dynamic/lib:$LD_LIBRARY_PATH
export CFLAGS="-I/root/3rdpart/vcpkg/installed/x64-linux-dynamic/include -fPIC"
export LDFLAGS="-L/root/3rdpart/vcpkg/installed/x64-linux-dynamic/lib"

cd 3rdpart/ffmpeg
# --enable-g722_1
./configure --enable-libopus --enable-g722_1c --enable-gpl --enable-version3 --enable-nonfree --enable-libx264 --enable-libx265 --enable-openssl --enable-openh264 --enable-svac --prefix=/root/install \
--enable-libfreetype --enable-libfontconfig --enable-libfribidi --enable-libharfbuzz \
--extra-cflags='-I/root/install/include -I/root/3rdpart/fuck_svac/sdk -fPIC' \
--extra-ldflags='-L/root/3rdpart/fuck_svac/sdk -L/root/install/lib -lstdc++ -lm -ldl -pthread'

make -j $(nproc) > /dev/null 2>&1
make install > /dev/null 2>&1
cd ../../

mkdir -p build
cd build
cmake .. \
-DCMAKE_BUILD_TYPE=Release \
-DRELEASE_VERSION=${{ env.RELEASE }} \
-DENABLE_WEBRTC=ON \
-DENABLE_FFMPEG=${{ env.ENABLE_FFMPEG }} \
-DENABLE_TESTS=OFF \
-DENABLE_API=OFF \
-DENABLE_SVAC=${{ env.ENABLE_FFMPEG }} \
-DENABLE_G722_1=${{ env.ENABLE_FFMPEG }} \
-DVCPKG_TARGET_TRIPLET=x64-linux-dynamic \
-DCMAKE_TOOLCHAIN_FILE=/root/3rdpart/vcpkg/scripts/buildsystems/vcpkg.cmake \
-DCMAKE_CXX_FLAGS='-L/root/3rdpart/fuck_svac/sdk -ldl'

make -j $(nproc)

cd ..
rm -rf release/linux/Release/*.a
rm -rf /root/3rdpart/fuck_svac/sdk/*.h
rm -rf /root/3rdpart/fuck_svac/sdk/*.a
rm -rf /root/install/lib/*.a

cp -rfP /root/3rdpart/fuck_svac/sdk release/linux/Release/lib
cp -rfP /root/install/lib/* release/linux/Release/lib
mkdir -p release/linux/Release/bin
cp -rfP /root/install/bin/* release/linux/Release/bin

cp -rf /root/3rdpart/vcpkg/installed/x64-linux-dynamic/lib/* release/linux/Release/lib
cp -rf /root/3rdpart/vcpkg/installed/x64-linux-dynamic/tools/ffmpeg/* release/linux/Release