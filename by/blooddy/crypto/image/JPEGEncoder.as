package by.blooddy.crypto.image
{
   import flash.utils.ByteArray;
   import flash.display.BitmapData;
   import flash.system.ApplicationDomain;
   
   public class JPEGEncoder extends Object
   {
      
      public function JPEGEncoder() {
      }
      
      public static function encode(param1:BitmapData, param2:uint = 60) : ByteArray {
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:* = 0;
         var _loc23_:* = NaN;
         var _loc24_:* = NaN;
         var _loc25_:* = NaN;
         var _loc26_:* = NaN;
         var _loc27_:* = NaN;
         var _loc28_:* = NaN;
         var _loc29_:* = NaN;
         var _loc30_:* = NaN;
         var _loc31_:* = NaN;
         var _loc32_:* = NaN;
         var _loc33_:* = NaN;
         var _loc34_:* = NaN;
         var _loc35_:* = NaN;
         var _loc36_:* = NaN;
         var _loc37_:* = NaN;
         var _loc38_:* = NaN;
         var _loc39_:* = NaN;
         var _loc40_:* = NaN;
         var _loc41_:* = NaN;
         var _loc42_:* = NaN;
         var _loc43_:* = NaN;
         var _loc44_:* = NaN;
         var _loc45_:* = NaN;
         var _loc46_:* = NaN;
         var _loc47_:* = NaN;
         var _loc48_:* = NaN;
         var _loc49_:* = NaN;
         var _loc50_:* = NaN;
         var _loc51_:* = 0;
         var _loc52_:* = 0;
         var _loc53_:* = 0;
         var _loc54_:* = 0;
         var _loc55_:* = 0;
         var _loc56_:* = 0;
         var _loc57_:* = 0;
         if(param1 == null)
         {
            Error.throwError(TypeError,2007,"image");
         }
         if(param2 > 100)
         {
            Error.throwError(RangeError,2006,"quality");
         }
         var _loc3_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc4_:uint = param1.width;
         var _loc5_:uint = param1.height;
         var _loc6_:ByteArray = new ByteArray();
         _loc6_.position = 1792;
         _loc6_.writeBytes(JPEGTable.getTable(param2));
         _loc6_.length = _loc6_.length + (680 + _loc4_ * _loc5_ * 3);
         if(_loc6_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc6_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc6_;
         _loc7_ = 201611;
         _loc7_ = 201629;
         _loc6_.position = _loc7_ + 36;
         _loc6_.writeMultiByte("by.blooddy.crypto.image.JPEGEncoder","x-ascii");
         _loc7_ = 201701;
         _loc6_.position = _loc7_ + 4;
         _loc6_.writeBytes(_loc6_,1792,130);
         _loc7_ = 201835;
         var _loc8_:uint = param1.width;
         _loc9_ = param1.height;
         _loc7_ = 201854;
         _loc6_.position = _loc7_ + 4;
         _loc6_.writeBytes(_loc6_,3010,416);
         _loc7_ = 202274;
         var _loc10_:int = 202288;
         var _loc11_:int = 7;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         _loc8_ = 0;
         do
         {
            _loc7_ = 0;
            do
            {
               _loc9_ = 0;
               _loc16_ = _loc7_ + 8;
               _loc17_ = _loc8_ + 8;
               do
               {
                  do
                  {
                     _loc18_ = param1.getPixel(_loc7_,_loc8_);
                     _loc19_ = _loc18_ >>> 16;
                     _loc20_ = _loc18_ >> 8 & 255;
                     _loc21_ = _loc18_ & 255;
                     _loc9_ = _loc9_ + 8;
                     _loc7_++;
                  }
                  while(_loc7_ < _loc16_);
                  
                  _loc7_ = _loc7_ - 8;
                  _loc8_++;
               }
               while(_loc8_ < _loc17_);
               
               _loc8_ = _loc8_ - 8;
               _loc9_ = 256;
               _loc22_ = _loc13_;
               _loc16_ = 3426;
               _loc17_ = 3462;
               _loc18_ = 0;
               do
               {
                  _loc23_ = op_lf64(_loc9_ + _loc18_) /*Alchemy*/;
                  _loc24_ = op_lf64(_loc9_ + _loc18_ + 8) /*Alchemy*/;
                  _loc25_ = op_lf64(_loc9_ + _loc18_ + 16) /*Alchemy*/;
                  _loc26_ = op_lf64(_loc9_ + _loc18_ + 24) /*Alchemy*/;
                  _loc27_ = op_lf64(_loc9_ + _loc18_ + 32) /*Alchemy*/;
                  _loc28_ = op_lf64(_loc9_ + _loc18_ + 40) /*Alchemy*/;
                  _loc29_ = op_lf64(_loc9_ + _loc18_ + 48) /*Alchemy*/;
                  _loc30_ = op_lf64(_loc9_ + _loc18_ + 56) /*Alchemy*/;
                  _loc31_ = _loc23_ + _loc30_;
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = _loc24_ + _loc29_;
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = _loc25_ + _loc28_;
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = _loc26_ + _loc27_;
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = _loc31_ + _loc34_;
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = _loc32_ + _loc33_;
                  _loc41_ = _loc32_ - _loc33_;
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  _loc39_ = _loc35_ + _loc36_;
                  _loc40_ = _loc36_ + _loc37_;
                  _loc41_ = _loc37_ + _loc38_;
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = 0.5411961 * _loc39_ + _loc47_;
                  _loc46_ = 1.306562965 * _loc41_ + _loc47_;
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = _loc38_ + _loc45_;
                  _loc49_ = _loc38_ - _loc45_;
                  _loc18_ = _loc18_ + 64;
               }
               while(_loc18_ < 512);
               
               _loc18_ = 0;
               do
               {
                  _loc23_ = op_lf64(_loc9_ + _loc18_) /*Alchemy*/;
                  _loc24_ = op_lf64(_loc9_ + _loc18_ + 64) /*Alchemy*/;
                  _loc25_ = op_lf64(_loc9_ + _loc18_ + 128) /*Alchemy*/;
                  _loc26_ = op_lf64(_loc9_ + _loc18_ + 192) /*Alchemy*/;
                  _loc27_ = op_lf64(_loc9_ + _loc18_ + 256) /*Alchemy*/;
                  _loc28_ = op_lf64(_loc9_ + _loc18_ + 320) /*Alchemy*/;
                  _loc29_ = op_lf64(_loc9_ + _loc18_ + 384) /*Alchemy*/;
                  _loc30_ = op_lf64(_loc9_ + _loc18_ + 448) /*Alchemy*/;
                  _loc31_ = _loc23_ + _loc30_;
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = _loc24_ + _loc29_;
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = _loc25_ + _loc28_;
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = _loc26_ + _loc27_;
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = _loc31_ + _loc34_;
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = _loc32_ + _loc33_;
                  _loc41_ = _loc32_ - _loc33_;
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  _loc39_ = _loc35_ + _loc36_;
                  _loc40_ = _loc36_ + _loc37_;
                  _loc41_ = _loc37_ + _loc38_;
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = 0.5411961 * _loc39_ + _loc47_;
                  _loc46_ = 1.306562965 * _loc41_ + _loc47_;
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = _loc38_ + _loc45_;
                  _loc49_ = _loc38_ - _loc45_;
                  _loc18_ = _loc18_ + 8;
               }
               while(_loc18_ < 64);
               
               _loc19_ = 0;
               do
               {
                  _loc50_ = op_lf64(_loc9_ + (_loc19_ << 3)) /*Alchemy*/ * op_lf64(1922 + (_loc19_ << 3)) /*Alchemy*/;
                  _loc19_++;
               }
               while(_loc19_ < 64);
               
               _loc51_ = op_li32(0) /*Alchemy*/;
               _loc52_ = _loc51_ - _loc22_;
               _loc22_ = _loc51_;
               if(_loc52_ == 0)
               {
                  _loc53_ = op_li8(_loc16_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc16_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               else
               {
                  _loc18_ = (32767 + _loc52_) * 3;
                  _loc19_ = _loc16_ + op_li8(5004 + _loc18_) /*Alchemy*/ * 3;
                  _loc53_ = op_li8(_loc19_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc19_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
                  _loc19_ = 5004 + _loc18_;
                  _loc53_ = op_li8(_loc19_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc19_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               _loc19_ = 63;
               while(true)
               {
                  if(_loc19_ > 0)
                  {
                  }
                  if(!false)
                  {
                     break;
                  }
                  _loc19_--;
               }
               if(_loc19_ != 0)
               {
                  _loc20_ = 1;
                  while(_loc20_ <= _loc19_)
                  {
                     _loc54_ = _loc20_;
                     if(_loc20_ <= _loc19_)
                     {
                     }
                     _loc55_ = _loc20_ - _loc54_;
                     if(_loc55_ >= 16)
                     {
                        _loc53_ = _loc55_ >> 4;
                        _loc56_ = 1;
                        while(_loc56_ <= _loc53_)
                        {
                           _loc21_ = _loc17_ + 720;
                           _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                           while(true)
                           {
                              _loc57_--;
                              if(_loc57_ < 0)
                              {
                                 break;
                              }
                              if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                              {
                                 _loc12_ = _loc12_ | 1 << _loc11_;
                              }
                              _loc11_--;
                              if(_loc11_ < 0)
                              {
                                 if(_loc12_ == 255)
                                 {
                                    _loc10_ = _loc10_ + 2;
                                 }
                                 else
                                 {
                                    _loc10_++;
                                 }
                                 if(_loc12_ == 255)
                                 {
                                    _loc11_ = 7;
                                    _loc12_ = 0;
                                 }
                                 else
                                 {
                                    _loc11_ = 7;
                                    _loc12_ = 0;
                                 }
                              }
                           }
                           _loc56_++;
                        }
                        _loc55_ = _loc55_ & 15;
                     }
                     _loc18_ = (32767 + op_li32(_loc20_ << 2) /*Alchemy*/) * 3;
                     _loc21_ = _loc17_ + (_loc55_ << 4) * 3 + op_li8(5004 + _loc18_) /*Alchemy*/ * 3;
                     _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                        {
                           _loc12_ = _loc12_ | 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              _loc10_ = _loc10_ + 2;
                           }
                           else
                           {
                              _loc10_++;
                           }
                           if(_loc12_ == 255)
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                           else
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                        }
                     }
                     _loc21_ = 5004 + _loc18_;
                     _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                        {
                           _loc12_ = _loc12_ | 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              _loc10_ = _loc10_ + 2;
                           }
                           else
                           {
                              _loc10_++;
                           }
                           if(_loc12_ == 255)
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                           else
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                        }
                     }
                     _loc20_++;
                  }
               }
               if(_loc19_ != 63)
               {
                  _loc53_ = op_li8(_loc17_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc17_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               _loc13_ = _loc22_;
               _loc9_ = 768;
               _loc22_ = _loc14_;
               _loc16_ = 4215;
               _loc17_ = 4251;
               _loc18_ = 0;
               do
               {
                  _loc23_ = op_lf64(_loc9_ + _loc18_) /*Alchemy*/;
                  _loc24_ = op_lf64(_loc9_ + _loc18_ + 8) /*Alchemy*/;
                  _loc25_ = op_lf64(_loc9_ + _loc18_ + 16) /*Alchemy*/;
                  _loc26_ = op_lf64(_loc9_ + _loc18_ + 24) /*Alchemy*/;
                  _loc27_ = op_lf64(_loc9_ + _loc18_ + 32) /*Alchemy*/;
                  _loc28_ = op_lf64(_loc9_ + _loc18_ + 40) /*Alchemy*/;
                  _loc29_ = op_lf64(_loc9_ + _loc18_ + 48) /*Alchemy*/;
                  _loc30_ = op_lf64(_loc9_ + _loc18_ + 56) /*Alchemy*/;
                  _loc31_ = _loc23_ + _loc30_;
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = _loc24_ + _loc29_;
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = _loc25_ + _loc28_;
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = _loc26_ + _loc27_;
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = _loc31_ + _loc34_;
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = _loc32_ + _loc33_;
                  _loc41_ = _loc32_ - _loc33_;
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  _loc39_ = _loc35_ + _loc36_;
                  _loc40_ = _loc36_ + _loc37_;
                  _loc41_ = _loc37_ + _loc38_;
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = 0.5411961 * _loc39_ + _loc47_;
                  _loc46_ = 1.306562965 * _loc41_ + _loc47_;
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = _loc38_ + _loc45_;
                  _loc49_ = _loc38_ - _loc45_;
                  _loc18_ = _loc18_ + 64;
               }
               while(_loc18_ < 512);
               
               _loc18_ = 0;
               do
               {
                  _loc23_ = op_lf64(_loc9_ + _loc18_) /*Alchemy*/;
                  _loc24_ = op_lf64(_loc9_ + _loc18_ + 64) /*Alchemy*/;
                  _loc25_ = op_lf64(_loc9_ + _loc18_ + 128) /*Alchemy*/;
                  _loc26_ = op_lf64(_loc9_ + _loc18_ + 192) /*Alchemy*/;
                  _loc27_ = op_lf64(_loc9_ + _loc18_ + 256) /*Alchemy*/;
                  _loc28_ = op_lf64(_loc9_ + _loc18_ + 320) /*Alchemy*/;
                  _loc29_ = op_lf64(_loc9_ + _loc18_ + 384) /*Alchemy*/;
                  _loc30_ = op_lf64(_loc9_ + _loc18_ + 448) /*Alchemy*/;
                  _loc31_ = _loc23_ + _loc30_;
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = _loc24_ + _loc29_;
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = _loc25_ + _loc28_;
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = _loc26_ + _loc27_;
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = _loc31_ + _loc34_;
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = _loc32_ + _loc33_;
                  _loc41_ = _loc32_ - _loc33_;
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  _loc39_ = _loc35_ + _loc36_;
                  _loc40_ = _loc36_ + _loc37_;
                  _loc41_ = _loc37_ + _loc38_;
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = 0.5411961 * _loc39_ + _loc47_;
                  _loc46_ = 1.306562965 * _loc41_ + _loc47_;
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = _loc38_ + _loc45_;
                  _loc49_ = _loc38_ - _loc45_;
                  _loc18_ = _loc18_ + 8;
               }
               while(_loc18_ < 64);
               
               _loc19_ = 0;
               do
               {
                  _loc50_ = op_lf64(_loc9_ + (_loc19_ << 3)) /*Alchemy*/ * op_lf64(2434 + (_loc19_ << 3)) /*Alchemy*/;
                  _loc19_++;
               }
               while(_loc19_ < 64);
               
               _loc51_ = op_li32(0) /*Alchemy*/;
               _loc52_ = _loc51_ - _loc22_;
               _loc22_ = _loc51_;
               if(_loc52_ == 0)
               {
                  _loc53_ = op_li8(_loc16_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc16_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               else
               {
                  _loc18_ = (32767 + _loc52_) * 3;
                  _loc19_ = _loc16_ + op_li8(5004 + _loc18_) /*Alchemy*/ * 3;
                  _loc53_ = op_li8(_loc19_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc19_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
                  _loc19_ = 5004 + _loc18_;
                  _loc53_ = op_li8(_loc19_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc19_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               _loc19_ = 63;
               while(true)
               {
                  if(_loc19_ > 0)
                  {
                  }
                  if(!false)
                  {
                     break;
                  }
                  _loc19_--;
               }
               if(_loc19_ != 0)
               {
                  _loc20_ = 1;
                  while(_loc20_ <= _loc19_)
                  {
                     _loc54_ = _loc20_;
                     if(_loc20_ <= _loc19_)
                     {
                     }
                     _loc55_ = _loc20_ - _loc54_;
                     if(_loc55_ >= 16)
                     {
                        _loc53_ = _loc55_ >> 4;
                        _loc56_ = 1;
                        while(_loc56_ <= _loc53_)
                        {
                           _loc21_ = _loc17_ + 720;
                           _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                           while(true)
                           {
                              _loc57_--;
                              if(_loc57_ < 0)
                              {
                                 break;
                              }
                              if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                              {
                                 _loc12_ = _loc12_ | 1 << _loc11_;
                              }
                              _loc11_--;
                              if(_loc11_ < 0)
                              {
                                 if(_loc12_ == 255)
                                 {
                                    _loc10_ = _loc10_ + 2;
                                 }
                                 else
                                 {
                                    _loc10_++;
                                 }
                                 if(_loc12_ == 255)
                                 {
                                    _loc11_ = 7;
                                    _loc12_ = 0;
                                 }
                                 else
                                 {
                                    _loc11_ = 7;
                                    _loc12_ = 0;
                                 }
                              }
                           }
                           _loc56_++;
                        }
                        _loc55_ = _loc55_ & 15;
                     }
                     _loc18_ = (32767 + op_li32(_loc20_ << 2) /*Alchemy*/) * 3;
                     _loc21_ = _loc17_ + (_loc55_ << 4) * 3 + op_li8(5004 + _loc18_) /*Alchemy*/ * 3;
                     _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                        {
                           _loc12_ = _loc12_ | 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              _loc10_ = _loc10_ + 2;
                           }
                           else
                           {
                              _loc10_++;
                           }
                           if(_loc12_ == 255)
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                           else
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                        }
                     }
                     _loc21_ = 5004 + _loc18_;
                     _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                        {
                           _loc12_ = _loc12_ | 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              _loc10_ = _loc10_ + 2;
                           }
                           else
                           {
                              _loc10_++;
                           }
                           if(_loc12_ == 255)
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                           else
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                        }
                     }
                     _loc20_++;
                  }
               }
               if(_loc19_ != 63)
               {
                  _loc53_ = op_li8(_loc17_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc17_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               _loc14_ = _loc22_;
               _loc9_ = 1280;
               _loc22_ = _loc15_;
               _loc16_ = 4215;
               _loc17_ = 4251;
               _loc18_ = 0;
               do
               {
                  _loc23_ = op_lf64(_loc9_ + _loc18_) /*Alchemy*/;
                  _loc24_ = op_lf64(_loc9_ + _loc18_ + 8) /*Alchemy*/;
                  _loc25_ = op_lf64(_loc9_ + _loc18_ + 16) /*Alchemy*/;
                  _loc26_ = op_lf64(_loc9_ + _loc18_ + 24) /*Alchemy*/;
                  _loc27_ = op_lf64(_loc9_ + _loc18_ + 32) /*Alchemy*/;
                  _loc28_ = op_lf64(_loc9_ + _loc18_ + 40) /*Alchemy*/;
                  _loc29_ = op_lf64(_loc9_ + _loc18_ + 48) /*Alchemy*/;
                  _loc30_ = op_lf64(_loc9_ + _loc18_ + 56) /*Alchemy*/;
                  _loc31_ = _loc23_ + _loc30_;
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = _loc24_ + _loc29_;
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = _loc25_ + _loc28_;
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = _loc26_ + _loc27_;
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = _loc31_ + _loc34_;
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = _loc32_ + _loc33_;
                  _loc41_ = _loc32_ - _loc33_;
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  _loc39_ = _loc35_ + _loc36_;
                  _loc40_ = _loc36_ + _loc37_;
                  _loc41_ = _loc37_ + _loc38_;
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = 0.5411961 * _loc39_ + _loc47_;
                  _loc46_ = 1.306562965 * _loc41_ + _loc47_;
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = _loc38_ + _loc45_;
                  _loc49_ = _loc38_ - _loc45_;
                  _loc18_ = _loc18_ + 64;
               }
               while(_loc18_ < 512);
               
               _loc18_ = 0;
               do
               {
                  _loc23_ = op_lf64(_loc9_ + _loc18_) /*Alchemy*/;
                  _loc24_ = op_lf64(_loc9_ + _loc18_ + 64) /*Alchemy*/;
                  _loc25_ = op_lf64(_loc9_ + _loc18_ + 128) /*Alchemy*/;
                  _loc26_ = op_lf64(_loc9_ + _loc18_ + 192) /*Alchemy*/;
                  _loc27_ = op_lf64(_loc9_ + _loc18_ + 256) /*Alchemy*/;
                  _loc28_ = op_lf64(_loc9_ + _loc18_ + 320) /*Alchemy*/;
                  _loc29_ = op_lf64(_loc9_ + _loc18_ + 384) /*Alchemy*/;
                  _loc30_ = op_lf64(_loc9_ + _loc18_ + 448) /*Alchemy*/;
                  _loc31_ = _loc23_ + _loc30_;
                  _loc38_ = _loc23_ - _loc30_;
                  _loc32_ = _loc24_ + _loc29_;
                  _loc37_ = _loc24_ - _loc29_;
                  _loc33_ = _loc25_ + _loc28_;
                  _loc36_ = _loc25_ - _loc28_;
                  _loc34_ = _loc26_ + _loc27_;
                  _loc35_ = _loc26_ - _loc27_;
                  _loc39_ = _loc31_ + _loc34_;
                  _loc42_ = _loc31_ - _loc34_;
                  _loc40_ = _loc32_ + _loc33_;
                  _loc41_ = _loc32_ - _loc33_;
                  _loc43_ = (_loc41_ + _loc42_) * 0.707106781;
                  _loc39_ = _loc35_ + _loc36_;
                  _loc40_ = _loc36_ + _loc37_;
                  _loc41_ = _loc37_ + _loc38_;
                  _loc47_ = (_loc39_ - _loc41_) * 0.382683433;
                  _loc44_ = 0.5411961 * _loc39_ + _loc47_;
                  _loc46_ = 1.306562965 * _loc41_ + _loc47_;
                  _loc45_ = _loc40_ * 0.707106781;
                  _loc48_ = _loc38_ + _loc45_;
                  _loc49_ = _loc38_ - _loc45_;
                  _loc18_ = _loc18_ + 8;
               }
               while(_loc18_ < 64);
               
               _loc19_ = 0;
               do
               {
                  _loc50_ = op_lf64(_loc9_ + (_loc19_ << 3)) /*Alchemy*/ * op_lf64(2434 + (_loc19_ << 3)) /*Alchemy*/;
                  _loc19_++;
               }
               while(_loc19_ < 64);
               
               _loc51_ = op_li32(0) /*Alchemy*/;
               _loc52_ = _loc51_ - _loc22_;
               _loc22_ = _loc51_;
               if(_loc52_ == 0)
               {
                  _loc53_ = op_li8(_loc16_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc16_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               else
               {
                  _loc18_ = (32767 + _loc52_) * 3;
                  _loc19_ = _loc16_ + op_li8(5004 + _loc18_) /*Alchemy*/ * 3;
                  _loc53_ = op_li8(_loc19_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc19_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
                  _loc19_ = 5004 + _loc18_;
                  _loc53_ = op_li8(_loc19_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc19_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               _loc19_ = 63;
               while(true)
               {
                  if(_loc19_ > 0)
                  {
                  }
                  if(!false)
                  {
                     break;
                  }
                  _loc19_--;
               }
               if(_loc19_ != 0)
               {
                  _loc20_ = 1;
                  while(_loc20_ <= _loc19_)
                  {
                     _loc54_ = _loc20_;
                     while(true)
                     {
                        if(_loc20_ <= _loc19_)
                        {
                        }
                        if(!false)
                        {
                           break;
                        }
                        _loc20_++;
                     }
                     _loc55_ = _loc20_ - _loc54_;
                     if(_loc55_ >= 16)
                     {
                        _loc53_ = _loc55_ >> 4;
                        _loc56_ = 1;
                        while(_loc56_ <= _loc53_)
                        {
                           _loc21_ = _loc17_ + 720;
                           _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                           while(true)
                           {
                              _loc57_--;
                              if(_loc57_ < 0)
                              {
                                 break;
                              }
                              if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                              {
                                 _loc12_ = _loc12_ | 1 << _loc11_;
                              }
                              _loc11_--;
                              if(_loc11_ < 0)
                              {
                                 if(_loc12_ == 255)
                                 {
                                    _loc10_ = _loc10_ + 2;
                                 }
                                 else
                                 {
                                    _loc10_++;
                                 }
                                 if(_loc12_ == 255)
                                 {
                                    _loc11_ = 7;
                                    _loc12_ = 0;
                                 }
                                 else
                                 {
                                    _loc11_ = 7;
                                    _loc12_ = 0;
                                 }
                              }
                           }
                           _loc56_++;
                        }
                        _loc55_ = _loc55_ & 15;
                     }
                     _loc18_ = (32767 + op_li32(_loc20_ << 2) /*Alchemy*/) * 3;
                     _loc21_ = _loc17_ + (_loc55_ << 4) * 3 + op_li8(5004 + _loc18_) /*Alchemy*/ * 3;
                     _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                        {
                           _loc12_ = _loc12_ | 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              _loc10_ = _loc10_ + 2;
                           }
                           else
                           {
                              _loc10_++;
                           }
                           if(_loc12_ == 255)
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                           else
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                        }
                     }
                     _loc21_ = 5004 + _loc18_;
                     _loc57_ = op_li8(_loc21_) /*Alchemy*/;
                     while(true)
                     {
                        _loc57_--;
                        if(_loc57_ < 0)
                        {
                           break;
                        }
                        if((op_li16(_loc21_ + 1) /*Alchemy*/ & 1 << _loc57_) != 0)
                        {
                           _loc12_ = _loc12_ | 1 << _loc11_;
                        }
                        _loc11_--;
                        if(_loc11_ < 0)
                        {
                           if(_loc12_ == 255)
                           {
                              _loc10_ = _loc10_ + 2;
                           }
                           else
                           {
                              _loc10_++;
                           }
                           if(_loc12_ == 255)
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                           else
                           {
                              _loc11_ = 7;
                              _loc12_ = 0;
                           }
                        }
                     }
                     _loc20_++;
                  }
               }
               if(_loc19_ != 63)
               {
                  _loc53_ = op_li8(_loc17_) /*Alchemy*/;
                  while(true)
                  {
                     _loc53_--;
                     if(_loc53_ < 0)
                     {
                        break;
                     }
                     if((op_li16(_loc17_ + 1) /*Alchemy*/ & 1 << _loc53_) != 0)
                     {
                        _loc12_ = _loc12_ | 1 << _loc11_;
                     }
                     _loc11_--;
                     if(_loc11_ < 0)
                     {
                        if(_loc12_ == 255)
                        {
                           _loc10_ = _loc10_ + 2;
                        }
                        else
                        {
                           _loc10_++;
                        }
                        if(_loc12_ == 255)
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                        else
                        {
                           _loc11_ = 7;
                           _loc12_ = 0;
                        }
                     }
                  }
               }
               _loc15_ = _loc22_;
               _loc7_ = _loc7_ + 8;
            }
            while(_loc7_ < _loc4_);
            
            _loc8_ = _loc8_ + 8;
         }
         while(_loc8_ < _loc5_);
         
         if(_loc11_ >= 0)
         {
            _loc22_ = _loc11_ + 1;
            while(true)
            {
               _loc22_--;
               if(_loc22_ < 0)
               {
                  break;
               }
               if(((1 << _loc11_ + 1) - 1 & 1 << _loc22_) != 0)
               {
                  _loc12_ = _loc12_ | 1 << _loc11_;
               }
               _loc11_--;
               if(_loc11_ < 0)
               {
                  if(_loc12_ == 255)
                  {
                     _loc10_ = _loc10_ + 2;
                  }
                  else
                  {
                     _loc10_++;
                  }
                  if(_loc12_ == 255)
                  {
                     _loc11_ = 7;
                     _loc12_ = 0;
                  }
                  else
                  {
                     _loc11_ = 7;
                     _loc12_ = 0;
                  }
               }
            }
         }
         ApplicationDomain.currentDomain.domainMemory = _loc3_;
         var _loc58_:ByteArray = new ByteArray();
         _loc58_.writeBytes(_loc6_,201609,_loc10_ - 201609 + 2);
         _loc58_.position = 0;
         return _loc58_;
      }
   }
}
