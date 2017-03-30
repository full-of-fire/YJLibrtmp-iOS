#!/bin/sh

#1.输入targetname
echo "请输入targetName:"
read TargetName;
echo "targetName is $TargetName"

#2.输入编译路径
#echo "请输入编译路径"
#read BuildPath;
#echo "build path is $BuildPath"
BuildPath=`pwd`

#3.模拟器和设备路径
DEVICE_DIR="$BuildPath/build/Release-iphoneos/$TargetName.framework"
echo $DEVICE_DIR

SIMULATOR_DIR="$BuildPath/build/Release-iphonesimulator/$TargetName.framework"
echo $SIMULATOR_DIR

#4.cd到需要编译的路径
cd $BuildPath


#5.编译
xcodebuild -configuration "Release" -target $TargetName -sdk iphoneos clean build
xcodebuild -configuration "Release" -target $TargetName -sdk iphonesimulator clean build

#6.创建一个通用文件夹
UniversalPath="$BuildPath/Universal"
rm -rf $UniversalPath
mkdir -p $UniversalPath
cp -R $DEVICE_DIR $UniversalPath/



#8.合并
lipo -create "$DEVICE_DIR/$TargetName" "$SIMULATOR_DIR/$TargetName" -output "$UniversalPath/$TargetName.framework/$TargetName"

#9.删除build文件
if [ -d "$BuildPath/build" ]
then
rm -rf "$BuildPath/build"
fi

#9.打开当前文件夹
open .
