package cmodule.lua_wrapper
{
   public final class FSM_getobjname extends Machine
   {
      
      public function FSM_getobjname() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         FSM_getobjname.esp = FSM_getobjname.esp - 4;
         FSM_getobjname.ebp = FSM_getobjname.esp;
         FSM_getobjname.esp = FSM_getobjname.esp - 0;
         _loc1_ = op_li32(FSM_getobjname.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM_getobjname.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM_getobjname.ebp + 16) /*Alchemy*/;
         _loc4_ = op_li32(FSM_getobjname.ebp + 20) /*Alchemy*/;
         _loc5_ = _loc1_ + 12;
         _loc6_ = _loc2_ + 24;
         _loc2_ = _loc2_ + 20;
         _loc7_ = _loc1_ + 4;
         while(true)
         {
            _loc8_ = op_li32(_loc7_) /*Alchemy*/;
            _loc9_ = op_li32(_loc8_ + 8) /*Alchemy*/;
            if(_loc9_ == 6)
            {
               _loc10_ = op_li32(_loc8_) /*Alchemy*/;
               _loc11_ = op_li8(_loc10_ + 6) /*Alchemy*/;
               if(_loc11_ == 0)
               {
                  _loc10_ = op_li32(_loc10_ + 16) /*Alchemy*/;
                  if(_loc9_ == 6)
                  {
                     _loc9_ = _loc11_ & 255;
                     if(_loc9_ == 0)
                     {
                        _loc9_ = op_li32(_loc2_) /*Alchemy*/;
                        if(_loc9_ == _loc1_)
                        {
                           _loc9_ = op_li32(_loc6_) /*Alchemy*/;
                        }
                        if(_loc9_ == _loc1_)
                        {
                           _loc8_ = op_li32(_loc8_) /*Alchemy*/;
                           _loc8_ = op_li32(_loc8_ + 16) /*Alchemy*/;
                           _loc9_ = op_li32(_loc5_) /*Alchemy*/;
                           _loc8_ = op_li32(_loc8_ + 12) /*Alchemy*/;
                           _loc8_ = _loc9_ - _loc8_;
                           _loc8_ = _loc8_ >> 2;
                           _loc8_ = _loc8_ + -1;
                        }
                        else
                        {
                           _loc8_ = op_li32(_loc8_) /*Alchemy*/;
                           _loc8_ = op_li32(_loc8_ + 16) /*Alchemy*/;
                           _loc9_ = op_li32(_loc5_) /*Alchemy*/;
                           _loc8_ = op_li32(_loc8_ + 12) /*Alchemy*/;
                           _loc8_ = _loc9_ - _loc8_;
                           _loc8_ = _loc8_ >> 2;
                           _loc8_ = _loc8_ + -1;
                        }
                     }
                     _loc9_ = op_li32(_loc10_ + 24) /*Alchemy*/;
                     _loc11_ = op_li32(_loc10_ + 56) /*Alchemy*/;
                     FSM_getobjname.esp = FSM_getobjname.esp - 16;
                     _loc12_ = _loc3_ + 1;
                     FSM_getobjname.esp = FSM_getobjname.esp - 4;
                     FSM_getobjname.start();
                     _loc9_ = FSM_getobjname.eax;
                     FSM_getobjname.esp = FSM_getobjname.esp + 16;
                     if(_loc9_ != 0)
                     {
                        _loc3_ = FSM_getobjname;
                        _loc1_ = _loc3_;
                        FSM_getobjname.eax = _loc1_;
                     }
                     else
                     {
                        FSM_getobjname.esp = FSM_getobjname.esp - 12;
                        FSM_getobjname.esp = FSM_getobjname.esp - 4;
                        FSM_getobjname.start();
                        _loc3_ = FSM_getobjname.eax;
                        FSM_getobjname.esp = FSM_getobjname.esp + 12;
                        _loc8_ = _loc3_ & 63;
                        if(_loc8_ <= 4)
                        {
                           if(_loc8_ != 0)
                           {
                              if(_loc8_ == 4)
                              {
                                 _loc10_ = op_li32(_loc10_ + 28) /*Alchemy*/;
                                 if(_loc10_ != 0)
                                 {
                                    _loc1_ = FSM_getobjname;
                                    _loc3_ = _loc3_ & -8388608;
                                    _loc3_ = _loc3_ >>> 21;
                                    _loc3_ = _loc10_ + _loc3_;
                                    _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                    _loc3_ = _loc3_ + 16;
                                    break;
                                 }
                                 _loc3_ = FSM_getobjname;
                                 _loc3_ = FSM_getobjname;
                                 FSM_getobjname.eax = _loc3_;
                              }
                           }
                           else
                           {
                              _loc10_ = _loc3_ >>> 6;
                              _loc3_ = _loc3_ >>> 23;
                              _loc10_ = _loc10_ & 255;
                              if(_loc3_ < _loc10_)
                              {
                                 continue;
                              }
                           }
                        }
                        else
                        {
                           if(_loc8_ != 11)
                           {
                              if(_loc8_ != 6)
                              {
                                 if(_loc8_ == 5)
                                 {
                                    _loc1_ = FSM_getobjname;
                                    _loc3_ = _loc3_ >>> 14;
                                    _loc2_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                                    _loc3_ = _loc3_ * 12;
                                    _loc3_ = _loc2_ + _loc3_;
                                    _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                    _loc3_ = _loc3_ + 16;
                                    break;
                                 }
                              }
                              else
                              {
                                 _loc3_ = _loc3_ >>> 14;
                                 _loc1_ = _loc3_ & 256;
                                 if(_loc1_ != 0)
                                 {
                                    _loc3_ = _loc3_ & 255;
                                    _loc10_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                                    _loc1_ = _loc3_ * 12;
                                    _loc1_ = _loc10_ + _loc1_;
                                    _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                                    if(_loc1_ == 4)
                                    {
                                       _loc3_ = _loc3_ * 12;
                                       _loc3_ = _loc10_ + _loc3_;
                                       _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                       _loc3_ = _loc3_ + 16;
                                    }
                                    _loc10_ = FSM_getobjname;
                                    FSM_getobjname.eax = _loc10_;
                                 }
                                 if(_loc1_ == 0)
                                 {
                                    _loc3_ = FSM_getobjname;
                                    _loc10_ = FSM_getobjname;
                                    FSM_getobjname.eax = _loc10_;
                                 }
                                 else
                                 {
                                    _loc3_ = FSM_getobjname;
                                    _loc10_ = FSM_getobjname;
                                    FSM_getobjname.eax = _loc10_;
                                 }
                              }
                           }
                           else
                           {
                              _loc3_ = _loc3_ >>> 14;
                              _loc1_ = _loc3_ & 256;
                              if(_loc1_ != 0)
                              {
                                 _loc3_ = _loc3_ & 255;
                                 _loc1_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                                 _loc2_ = _loc3_ * 12;
                                 _loc2_ = _loc1_ + _loc2_;
                                 _loc2_ = op_li32(_loc2_ + 8) /*Alchemy*/;
                                 if(_loc2_ == 4)
                                 {
                                    _loc3_ = _loc3_ * 12;
                                    _loc3_ = _loc1_ + _loc3_;
                                    _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                    _loc3_ = _loc3_ + 16;
                                 }
                                 _loc1_ = FSM_getobjname;
                                 break;
                              }
                              _loc3_ = FSM_getobjname;
                              _loc1_ = FSM_getobjname;
                              break;
                           }
                        }
                     }
                     if(_loc9_ != 0)
                     {
                        FSM_getobjname.esp = FSM_getobjname.ebp;
                        FSM_getobjname.ebp = op_li32(FSM_getobjname.esp) /*Alchemy*/;
                        FSM_getobjname.esp = FSM_getobjname.esp + 4;
                        FSM_getobjname.esp = FSM_getobjname.esp + 4;
                        return;
                     }
                     FSM_getobjname.esp = FSM_getobjname.ebp;
                     FSM_getobjname.ebp = op_li32(FSM_getobjname.esp) /*Alchemy*/;
                     FSM_getobjname.esp = FSM_getobjname.esp + 4;
                     FSM_getobjname.esp = FSM_getobjname.esp + 4;
                     return;
                  }
                  if(_loc9_ == 6)
                  {
                     _loc8_ = -1;
                     _loc9_ = op_li32(_loc10_ + 24) /*Alchemy*/;
                     _loc11_ = op_li32(_loc10_ + 56) /*Alchemy*/;
                     FSM_getobjname.esp = FSM_getobjname.esp - 16;
                     _loc12_ = _loc3_ + 1;
                     FSM_getobjname.esp = FSM_getobjname.esp - 4;
                     FSM_getobjname.start();
                     _loc9_ = FSM_getobjname.eax;
                     FSM_getobjname.esp = FSM_getobjname.esp + 16;
                     if(_loc9_ != 0)
                     {
                        _loc3_ = FSM_getobjname;
                        _loc1_ = _loc3_;
                        FSM_getobjname.eax = _loc1_;
                     }
                     else
                     {
                        FSM_getobjname.esp = FSM_getobjname.esp - 12;
                        FSM_getobjname.esp = FSM_getobjname.esp - 4;
                        FSM_getobjname.start();
                        _loc3_ = FSM_getobjname.eax;
                        FSM_getobjname.esp = FSM_getobjname.esp + 12;
                        _loc8_ = _loc3_ & 63;
                        if(_loc8_ <= 4)
                        {
                           if(_loc8_ != 0)
                           {
                              if(_loc8_ == 4)
                              {
                                 _loc10_ = op_li32(_loc10_ + 28) /*Alchemy*/;
                                 if(_loc10_ != 0)
                                 {
                                    _loc1_ = FSM_getobjname;
                                    _loc3_ = _loc3_ & -8388608;
                                    _loc3_ = _loc3_ >>> 21;
                                    _loc3_ = _loc10_ + _loc3_;
                                    _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                    _loc3_ = _loc3_ + 16;
                                    break;
                                 }
                                 _loc3_ = FSM_getobjname;
                                 _loc3_ = FSM_getobjname;
                                 FSM_getobjname.eax = _loc3_;
                              }
                           }
                           else
                           {
                              _loc10_ = _loc3_ >>> 6;
                              _loc3_ = _loc3_ >>> 23;
                              _loc10_ = _loc10_ & 255;
                              if(_loc3_ < _loc10_)
                              {
                                 continue;
                              }
                           }
                        }
                        else
                        {
                           if(_loc8_ != 11)
                           {
                              if(_loc8_ != 6)
                              {
                                 if(_loc8_ == 5)
                                 {
                                    _loc1_ = FSM_getobjname;
                                    _loc3_ = _loc3_ >>> 14;
                                    _loc2_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                                    _loc3_ = _loc3_ * 12;
                                    _loc3_ = _loc2_ + _loc3_;
                                    _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                    _loc3_ = _loc3_ + 16;
                                    break;
                                 }
                              }
                              else
                              {
                                 _loc3_ = _loc3_ >>> 14;
                                 _loc1_ = _loc3_ & 256;
                                 if(_loc1_ != 0)
                                 {
                                    _loc3_ = _loc3_ & 255;
                                    _loc10_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                                    _loc1_ = _loc3_ * 12;
                                    _loc1_ = _loc10_ + _loc1_;
                                    _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                                    if(_loc1_ == 4)
                                    {
                                       _loc3_ = _loc3_ * 12;
                                       _loc3_ = _loc10_ + _loc3_;
                                       _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                       _loc3_ = _loc3_ + 16;
                                    }
                                    _loc10_ = FSM_getobjname;
                                    FSM_getobjname.eax = _loc10_;
                                 }
                                 if(_loc1_ == 0)
                                 {
                                    _loc3_ = FSM_getobjname;
                                    _loc10_ = FSM_getobjname;
                                    FSM_getobjname.eax = _loc10_;
                                 }
                                 else
                                 {
                                    _loc3_ = FSM_getobjname;
                                    _loc10_ = FSM_getobjname;
                                    FSM_getobjname.eax = _loc10_;
                                 }
                              }
                           }
                           else
                           {
                              _loc3_ = _loc3_ >>> 14;
                              _loc1_ = _loc3_ & 256;
                              if(_loc1_ != 0)
                              {
                                 _loc3_ = _loc3_ & 255;
                                 _loc1_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                                 _loc2_ = _loc3_ * 12;
                                 _loc2_ = _loc1_ + _loc2_;
                                 _loc2_ = op_li32(_loc2_ + 8) /*Alchemy*/;
                                 if(_loc2_ == 4)
                                 {
                                    _loc3_ = _loc3_ * 12;
                                    _loc3_ = _loc1_ + _loc3_;
                                    _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                    _loc3_ = _loc3_ + 16;
                                 }
                                 _loc1_ = FSM_getobjname;
                                 break;
                              }
                              _loc3_ = FSM_getobjname;
                              _loc1_ = FSM_getobjname;
                              break;
                           }
                        }
                     }
                     if(_loc9_ != 0)
                     {
                        FSM_getobjname.esp = FSM_getobjname.ebp;
                        FSM_getobjname.ebp = op_li32(FSM_getobjname.esp) /*Alchemy*/;
                        FSM_getobjname.esp = FSM_getobjname.esp + 4;
                        FSM_getobjname.esp = FSM_getobjname.esp + 4;
                        return;
                     }
                     FSM_getobjname.esp = FSM_getobjname.ebp;
                     FSM_getobjname.ebp = op_li32(FSM_getobjname.esp) /*Alchemy*/;
                     FSM_getobjname.esp = FSM_getobjname.esp + 4;
                     FSM_getobjname.esp = FSM_getobjname.esp + 4;
                     return;
                  }
                  _loc8_ = -1;
                  _loc9_ = op_li32(_loc10_ + 24) /*Alchemy*/;
                  _loc11_ = op_li32(_loc10_ + 56) /*Alchemy*/;
                  FSM_getobjname.esp = FSM_getobjname.esp - 16;
                  _loc12_ = _loc3_ + 1;
                  FSM_getobjname.esp = FSM_getobjname.esp - 4;
                  FSM_getobjname.start();
                  _loc9_ = FSM_getobjname.eax;
                  FSM_getobjname.esp = FSM_getobjname.esp + 16;
                  if(_loc9_ != 0)
                  {
                     _loc3_ = FSM_getobjname;
                     _loc1_ = _loc3_;
                     FSM_getobjname.eax = _loc1_;
                  }
                  else
                  {
                     FSM_getobjname.esp = FSM_getobjname.esp - 12;
                     FSM_getobjname.esp = FSM_getobjname.esp - 4;
                     FSM_getobjname.start();
                     _loc3_ = FSM_getobjname.eax;
                     FSM_getobjname.esp = FSM_getobjname.esp + 12;
                     _loc8_ = _loc3_ & 63;
                     if(_loc8_ <= 4)
                     {
                        if(_loc8_ != 0)
                        {
                           if(_loc8_ == 4)
                           {
                              _loc10_ = op_li32(_loc10_ + 28) /*Alchemy*/;
                              if(_loc10_ != 0)
                              {
                                 _loc1_ = FSM_getobjname;
                                 _loc3_ = _loc3_ & -8388608;
                                 _loc3_ = _loc3_ >>> 21;
                                 _loc3_ = _loc10_ + _loc3_;
                                 _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                 _loc3_ = _loc3_ + 16;
                                 break;
                              }
                              _loc3_ = FSM_getobjname;
                              _loc3_ = FSM_getobjname;
                              FSM_getobjname.eax = _loc3_;
                           }
                        }
                        else
                        {
                           _loc10_ = _loc3_ >>> 6;
                           _loc3_ = _loc3_ >>> 23;
                           _loc10_ = _loc10_ & 255;
                           if(_loc3_ < _loc10_)
                           {
                              continue;
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_ != 11)
                        {
                           if(_loc8_ != 6)
                           {
                              if(_loc8_ == 5)
                              {
                                 _loc1_ = FSM_getobjname;
                                 _loc3_ = _loc3_ >>> 14;
                                 _loc2_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                                 _loc3_ = _loc3_ * 12;
                                 _loc3_ = _loc2_ + _loc3_;
                                 _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                 _loc3_ = _loc3_ + 16;
                                 break;
                              }
                           }
                           else
                           {
                              _loc3_ = _loc3_ >>> 14;
                              _loc1_ = _loc3_ & 256;
                              if(_loc1_ != 0)
                              {
                                 _loc3_ = _loc3_ & 255;
                                 _loc10_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                                 _loc1_ = _loc3_ * 12;
                                 _loc1_ = _loc10_ + _loc1_;
                                 _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                                 if(_loc1_ == 4)
                                 {
                                    _loc3_ = _loc3_ * 12;
                                    _loc3_ = _loc10_ + _loc3_;
                                    _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                    _loc3_ = _loc3_ + 16;
                                 }
                                 _loc10_ = FSM_getobjname;
                                 FSM_getobjname.eax = _loc10_;
                              }
                              if(_loc1_ == 0)
                              {
                                 _loc3_ = FSM_getobjname;
                                 _loc10_ = FSM_getobjname;
                                 FSM_getobjname.eax = _loc10_;
                              }
                              else
                              {
                                 _loc3_ = FSM_getobjname;
                                 _loc10_ = FSM_getobjname;
                                 FSM_getobjname.eax = _loc10_;
                              }
                           }
                        }
                        else
                        {
                           _loc3_ = _loc3_ >>> 14;
                           _loc1_ = _loc3_ & 256;
                           if(_loc1_ != 0)
                           {
                              _loc3_ = _loc3_ & 255;
                              _loc1_ = op_li32(_loc10_ + 8) /*Alchemy*/;
                              _loc2_ = _loc3_ * 12;
                              _loc2_ = _loc1_ + _loc2_;
                              _loc2_ = op_li32(_loc2_ + 8) /*Alchemy*/;
                              if(_loc2_ == 4)
                              {
                                 _loc3_ = _loc3_ * 12;
                                 _loc3_ = _loc1_ + _loc3_;
                                 _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                                 _loc3_ = _loc3_ + 16;
                              }
                              _loc1_ = FSM_getobjname;
                              break;
                           }
                           _loc3_ = FSM_getobjname;
                           _loc1_ = FSM_getobjname;
                           break;
                        }
                     }
                  }
                  if(_loc9_ != 0)
                  {
                     FSM_getobjname.esp = FSM_getobjname.ebp;
                     FSM_getobjname.ebp = op_li32(FSM_getobjname.esp) /*Alchemy*/;
                     FSM_getobjname.esp = FSM_getobjname.esp + 4;
                     FSM_getobjname.esp = FSM_getobjname.esp + 4;
                     return;
                  }
                  FSM_getobjname.esp = FSM_getobjname.ebp;
                  FSM_getobjname.ebp = op_li32(FSM_getobjname.esp) /*Alchemy*/;
                  FSM_getobjname.esp = FSM_getobjname.esp + 4;
                  FSM_getobjname.esp = FSM_getobjname.esp + 4;
                  return;
               }
            }
            _loc3_ = 0;
            _loc1_ = _loc3_;
            FSM_getobjname.eax = _loc1_;
            FSM_getobjname.esp = FSM_getobjname.ebp;
            FSM_getobjname.ebp = op_li32(FSM_getobjname.esp) /*Alchemy*/;
            FSM_getobjname.esp = FSM_getobjname.esp + 4;
            FSM_getobjname.esp = FSM_getobjname.esp + 4;
            return;
         }
         FSM_getobjname.eax = _loc1_;
         FSM_getobjname.esp = FSM_getobjname.ebp;
         FSM_getobjname.ebp = op_li32(FSM_getobjname.esp) /*Alchemy*/;
         FSM_getobjname.esp = FSM_getobjname.esp + 4;
         FSM_getobjname.esp = FSM_getobjname.esp + 4;
      }
   }
}
