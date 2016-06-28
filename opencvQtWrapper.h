#ifdef USE_OPENCV
#ifndef ALIREZA_OPENCV_WRAPPER_H
#define ALIREZA_OPENCV_WRAPPER_H

#include <opencv2/core/core.hpp>
#include <opencv2/flann/miniflann.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/photo/photo.hpp>
#include <opencv2/video/video.hpp>
#include <opencv2/features2d/features2d.hpp>
#include <opencv2/objdetect/objdetect.hpp>
#include <opencv2/calib3d/calib3d.hpp>
#include <opencv2/ml/ml.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/core_c.h>
#include <opencv2/highgui/highgui_c.h>
#include <opencv2/imgproc/imgproc_c.h>

using namespace cv;

inline QImage  cvMatToQImage( const cv::Mat &inMat ) {
      switch (inMat.type()) {
         // 8-bit, 4 channel
         case CV_8UC4: {
            QImage image( inMat.data, inMat.cols, inMat.rows, inMat.step, QImage::Format_RGB32 );
            return image;
         }
         // 8-bit, 3 channel
         case CV_8UC3: {
            QImage image( inMat.data, inMat.cols, inMat.rows, inMat.step, QImage::Format_RGB888 );
            return image.rgbSwapped();
         }
         // 8-bit, 1 channel
         case CV_8UC1: {
            static QVector<QRgb>  sColorTable;
            // only create our color table once
            if (sColorTable.isEmpty()) {
               for ( int i = 0; i < 256; ++i )
                  sColorTable.push_back( qRgb( i, i, i ) );
            }
            QImage image(inMat.data, inMat.cols, inMat.rows, inMat.step, QImage::Format_Indexed8 );
            image.setColorTable(sColorTable);
            return image;
         }
         default:
            qWarning() << "ASM::cvMatToQImage() - cv::Mat image type not handled in switch:" << inMat.type();
            break;
      }
      return QImage();
   }
   inline QPixmap cvMatToQPixmap(const cv::Mat &inMat) {
      return QPixmap::fromImage(cvMatToQImage(inMat) );
   }

   #endif
   #endif