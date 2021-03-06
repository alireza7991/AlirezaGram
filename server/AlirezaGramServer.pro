QT += core network
QT -= gui

CONFIG += c++11

TARGET = AlirezaGramServer
CONFIG += console
CONFIG -= app_bundle


win32 {
    DEFINES += USE_OPENCV
    # Opencv installation path
    LIBS += -LD:\dev\Programs\opencv\build\x64\vc12\staticlib -LD:\dev\Programs\opencv\build\x64\vc12\lib -lopencv_ts300d -lopencv_world300d -lopencv_calib3d300d -lopencv_core300d -lopencv_features2d300d -lopencv_flann300d -lopencv_highgui300d -lopencv_imgproc300d -lopencv_ml300d -lopencv_objdetect300d -lopencv_photo300d -lopencv_stitching300d -lopencv_superres300d -lopencv_video300d -lopencv_videostab300d -lippicvmt -lIlmImfd -llibtiffd -llibpngd -llibjasperd -llibjpegd -llibwebpd -lzlibd -lcomctl32
    INCLUDEPATH += D:\\dev\\Programs\\opencv\\build\\include  $$PWD
    DEPENDPATH += D:\\dev\\Programs\\opencv\\build\\include $$PWD

}

INCLUDEPATH += $$PWD/..
DEPENDPATH += $$PWD/..

TEMPLATE = app

SOURCES += main.cpp
