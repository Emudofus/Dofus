package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.types.Point3D;
   import flash.geom.Point;
   
   public class Dofus1Line extends Object
   {
      
      public function Dofus1Line() {
         super();
      }
      
      public static function getLine(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : Array {
         var _loc10_:* = 0;
         var _loc11_:Point3D = null;
         var _loc21_:Point = null;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = NaN;
         var _loc25_:* = NaN;
         var _loc26_:* = NaN;
         var _loc27_:* = NaN;
         var _loc28_:* = NaN;
         var _loc29_:* = NaN;
         var _loc30_:* = NaN;
         var _loc31_:* = NaN;
         var _loc32_:uint = 0;
         var _loc33_:uint = 0;
         var _loc7_:Array = new Array();
         var _loc8_:Point3D = new Point3D(param1,param2,param3);
         var _loc9_:Point3D = new Point3D(param4,param5,param6);
         _loc11_ = new Point3D(_loc8_.x + 0.5,_loc8_.y + 0.5,_loc8_.z);
         var _loc12_:Point3D = new Point3D(_loc9_.x + 0.5,_loc9_.y + 0.5,_loc9_.z);
         var _loc13_:Number = 0;
         var _loc14_:Number = 0;
         var _loc15_:Number = 0;
         var _loc16_:Number = 0;
         var _loc17_:* = _loc11_.z > _loc12_.z;
         var _loc18_:Array = new Array();
         var _loc19_:Array = new Array();
         var _loc20_:uint = 0;
         if(Math.abs(_loc11_.x - _loc12_.x) == Math.abs(_loc11_.y - _loc12_.y))
         {
            _loc16_ = Math.abs(_loc11_.x - _loc12_.x);
            _loc13_ = _loc12_.x > _loc11_.x?1:-1;
            _loc14_ = _loc12_.y > _loc11_.y?1:-1;
            _loc15_ = _loc16_ == 0?0:_loc17_?(_loc8_.z - _loc9_.z) / _loc16_:(_loc9_.z - _loc8_.z) / _loc16_;
            _loc20_ = 1;
         }
         else
         {
            if(Math.abs(_loc11_.x - _loc12_.x) > Math.abs(_loc11_.y - _loc12_.y))
            {
               _loc16_ = Math.abs(_loc11_.x - _loc12_.x);
               _loc13_ = _loc12_.x > _loc11_.x?1:-1;
               _loc14_ = _loc12_.y > _loc11_.y?Math.abs(_loc11_.y - _loc12_.y) == 0?0:Math.abs(_loc11_.y - _loc12_.y) / _loc16_:-Math.abs(_loc11_.y - _loc12_.y) / _loc16_;
               _loc14_ = _loc14_ * 100;
               _loc14_ = Math.ceil(_loc14_) / 100;
               _loc15_ = _loc16_ == 0?0:_loc17_?(_loc8_.z - _loc9_.z) / _loc16_:(_loc9_.z - _loc8_.z) / _loc16_;
               _loc20_ = 2;
            }
            else
            {
               _loc16_ = Math.abs(_loc11_.y - _loc12_.y);
               _loc13_ = _loc12_.x > _loc11_.x?Math.abs(_loc11_.x - _loc12_.x) == 0?0:Math.abs(_loc11_.x - _loc12_.x) / _loc16_:-Math.abs(_loc11_.x - _loc12_.x) / _loc16_;
               _loc13_ = _loc13_ * 100;
               _loc13_ = Math.ceil(_loc13_) / 100;
               _loc14_ = _loc12_.y > _loc11_.y?1:-1;
               _loc15_ = _loc16_ == 0?0:_loc17_?(_loc8_.z - _loc9_.z) / _loc16_:(_loc9_.z - _loc8_.z) / _loc16_;
               _loc20_ = 3;
            }
         }
         _loc10_ = 0;
         while(_loc10_ < _loc16_)
         {
            _loc22_ = int(3 + _loc16_ / 2);
            _loc23_ = int(97 - _loc16_ / 2);
            if(_loc20_ == 2)
            {
               _loc24_ = Math.ceil(_loc11_.y * 100 + _loc14_ * 50) / 100;
               _loc25_ = Math.floor(_loc11_.y * 100 + _loc14_ * 150) / 100;
               _loc26_ = Math.floor(Math.abs(Math.floor(_loc24_) * 100 - _loc24_ * 100)) / 100;
               _loc27_ = Math.ceil(Math.abs(Math.ceil(_loc25_) * 100 - _loc25_ * 100)) / 100;
               if(Math.floor(_loc24_) == Math.floor(_loc25_))
               {
                  _loc19_ = [Math.floor(_loc11_.y + _loc14_)];
                  if(_loc24_ == _loc19_[0] && _loc25_ < _loc19_[0])
                  {
                     _loc19_ = [Math.ceil(_loc11_.y + _loc14_)];
                  }
                  else
                  {
                     if(_loc24_ == _loc19_[0] && _loc25_ > _loc19_[0])
                     {
                        _loc19_ = [Math.floor(_loc11_.y + _loc14_)];
                     }
                     else
                     {
                        if(_loc25_ == _loc19_[0] && _loc24_ < _loc19_[0])
                        {
                           _loc19_ = [Math.ceil(_loc11_.y + _loc14_)];
                        }
                        else
                        {
                           if(_loc25_ == _loc19_[0] && _loc24_ > _loc19_[0])
                           {
                              _loc19_ = [Math.floor(_loc11_.y + _loc14_)];
                           }
                        }
                     }
                  }
               }
               else
               {
                  if(Math.ceil(_loc24_) == Math.ceil(_loc25_))
                  {
                     _loc19_ = [Math.ceil(_loc11_.y + _loc14_)];
                     if(_loc24_ == _loc19_[0] && _loc25_ < _loc19_[0])
                     {
                        _loc19_ = [Math.floor(_loc11_.y + _loc14_)];
                     }
                     else
                     {
                        if(_loc24_ == _loc19_[0] && _loc25_ > _loc19_[0])
                        {
                           _loc19_ = [Math.ceil(_loc11_.y + _loc14_)];
                        }
                        else
                        {
                           if(_loc25_ == _loc19_[0] && _loc24_ < _loc19_[0])
                           {
                              _loc19_ = [Math.floor(_loc11_.y + _loc14_)];
                           }
                           else
                           {
                              if(_loc25_ == _loc19_[0] && _loc24_ > _loc19_[0])
                              {
                                 _loc19_ = [Math.ceil(_loc11_.y + _loc14_)];
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     if(int(_loc26_ * 100) <= _loc22_)
                     {
                        _loc19_ = [Math.floor(_loc25_)];
                     }
                     else
                     {
                        if(int(_loc27_ * 100) >= _loc23_)
                        {
                           _loc19_ = [Math.floor(_loc24_)];
                        }
                        else
                        {
                           _loc19_ = [Math.floor(_loc24_),Math.floor(_loc25_)];
                        }
                     }
                  }
               }
            }
            else
            {
               if(_loc20_ == 3)
               {
                  _loc28_ = Math.ceil(_loc11_.x * 100 + _loc13_ * 50) / 100;
                  _loc29_ = Math.floor(_loc11_.x * 100 + _loc13_ * 150) / 100;
                  _loc30_ = Math.floor(Math.abs(Math.floor(_loc28_) * 100 - _loc28_ * 100)) / 100;
                  _loc31_ = Math.ceil(Math.abs(Math.ceil(_loc29_) * 100 - _loc29_ * 100)) / 100;
                  if(Math.floor(_loc28_) == Math.floor(_loc29_))
                  {
                     _loc18_ = [Math.floor(_loc11_.x + _loc13_)];
                     if(_loc28_ == _loc18_[0] && _loc29_ < _loc18_[0])
                     {
                        _loc18_ = [Math.ceil(_loc11_.x + _loc13_)];
                     }
                     else
                     {
                        if(_loc28_ == _loc18_[0] && _loc29_ > _loc18_[0])
                        {
                           _loc18_ = [Math.floor(_loc11_.x + _loc13_)];
                        }
                        else
                        {
                           if(_loc29_ == _loc18_[0] && _loc28_ < _loc18_[0])
                           {
                              _loc18_ = [Math.ceil(_loc11_.x + _loc13_)];
                           }
                           else
                           {
                              if(_loc29_ == _loc18_[0] && _loc28_ > _loc18_[0])
                              {
                                 _loc18_ = [Math.floor(_loc11_.x + _loc13_)];
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     if(Math.ceil(_loc28_) == Math.ceil(_loc29_))
                     {
                        _loc18_ = [Math.ceil(_loc11_.x + _loc13_)];
                        if(_loc28_ == _loc18_[0] && _loc29_ < _loc18_[0])
                        {
                           _loc18_ = [Math.floor(_loc11_.x + _loc13_)];
                        }
                        else
                        {
                           if(_loc28_ == _loc18_[0] && _loc29_ > _loc18_[0])
                           {
                              _loc18_ = [Math.ceil(_loc11_.x + _loc13_)];
                           }
                           else
                           {
                              if(_loc29_ == _loc18_[0] && _loc28_ < _loc18_[0])
                              {
                                 _loc18_ = [Math.floor(_loc11_.x + _loc13_)];
                              }
                              else
                              {
                                 if(_loc29_ == _loc18_[0] && _loc28_ > _loc18_[0])
                                 {
                                    _loc18_ = [Math.ceil(_loc11_.x + _loc13_)];
                                 }
                              }
                           }
                        }
                     }
                     else
                     {
                        if(int(_loc30_ * 100) <= _loc22_)
                        {
                           _loc18_ = [Math.floor(_loc29_)];
                        }
                        else
                        {
                           if(int(_loc31_ * 100) >= _loc23_)
                           {
                              _loc18_ = [Math.floor(_loc28_)];
                           }
                           else
                           {
                              _loc18_ = [Math.floor(_loc28_),Math.floor(_loc29_)];
                           }
                        }
                     }
                  }
               }
            }
            if(_loc19_.length > 0)
            {
               _loc32_ = 0;
               while(_loc32_ < _loc19_.length)
               {
                  _loc21_ = new Point(Math.floor(_loc11_.x + _loc13_),_loc19_[_loc32_]);
                  _loc7_.push(_loc21_);
                  _loc32_++;
               }
            }
            else
            {
               if(_loc18_.length > 0)
               {
                  _loc33_ = 0;
                  while(_loc33_ < _loc18_.length)
                  {
                     _loc21_ = new Point(_loc18_[_loc33_],Math.floor(_loc11_.y + _loc14_));
                     _loc7_.push(_loc21_);
                     _loc33_++;
                  }
               }
               else
               {
                  if(_loc20_ == 1)
                  {
                     _loc21_ = new Point(Math.floor(_loc11_.x + _loc13_),Math.floor(_loc11_.y + _loc14_));
                     _loc7_.push(_loc21_);
                  }
               }
            }
            _loc11_.x = (_loc11_.x * 100 + _loc13_ * 100) / 100;
            _loc11_.y = (_loc11_.y * 100 + _loc14_ * 100) / 100;
            _loc10_++;
         }
         return _loc7_;
      }
   }
}
