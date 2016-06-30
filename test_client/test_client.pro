QT += core
QT -= gui

CONFIG += c++11

TARGET = test_client
CONFIG += console
CONFIG -= app_bundle

INCLUDEPATH += $$PWD/..
DEPENDPATH += $$PWD/..

TEMPLATE = app

SOURCES += main.cpp
