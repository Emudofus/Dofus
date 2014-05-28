package cmodule.lua_wrapper
{
   public final class FSM__UTF8_wcsnrtombs extends Machine
   {
      
      public function FSM__UTF8_wcsnrtombs() {
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
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp - 4;
         FSM__UTF8_wcsnrtombs.ebp = FSM__UTF8_wcsnrtombs.esp;
         FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp - 16;
         _loc1_ = op_li32(FSM__UTF8_wcsnrtombs.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM__UTF8_wcsnrtombs.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM__UTF8_wcsnrtombs.ebp + 16) /*Alchemy*/;
         _loc4_ = op_li32(FSM__UTF8_wcsnrtombs.ebp + 20) /*Alchemy*/;
         _loc5_ = op_li32(FSM__UTF8_wcsnrtombs.ebp + 24) /*Alchemy*/;
         _loc6_ = op_li32(_loc5_ + 4) /*Alchemy*/;
         if(_loc6_ != 0)
         {
            _loc1_ = 22;
            _loc1_ = -1;
         }
         else
         {
            _loc6_ = op_li32(_loc2_) /*Alchemy*/;
            if(_loc1_ != 0)
            {
               _loc7_ = 0;
               _loc8_ = FSM__UTF8_wcsnrtombs.ebp + -16;
               _loc9_ = _loc7_;
               _loc10_ = _loc7_;
               while(true)
               {
                  _loc12_ = _loc4_;
                  _loc11_ = _loc7_;
                  _loc7_ = _loc1_ + _loc11_;
                  _loc4_ = _loc6_;
                  if(_loc12_ != 0)
                  {
                     if(_loc9_ == _loc3_)
                     {
                        break;
                     }
                     _loc13_ = op_li32(_loc4_) /*Alchemy*/;
                     if(uint(_loc13_) <= uint(127))
                     {
                        _loc4_ = op_li32(_loc4_) /*Alchemy*/;
                        if(_loc4_ != 0)
                        {
                           _loc4_ = 1;
                           continue;
                        }
                        _loc4_ = 1;
                     }
                     else
                     {
                        _loc14_ = op_li32(FSM__UTF8_wcsnrtombs) /*Alchemy*/;
                        if(uint(_loc14_) < uint(_loc12_))
                        {
                           FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp - 12;
                           FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp - 4;
                           FSM__UTF8_wcsnrtombs.start();
                           _loc7_ = FSM__UTF8_wcsnrtombs.eax;
                           FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 12;
                           if(_loc7_ == -1)
                           {
                              _loc6_ = -1;
                              FSM__UTF8_wcsnrtombs.eax = _loc6_;
                           }
                           if(_loc7_ != -1)
                           {
                           }
                        }
                        else
                        {
                           FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp - 12;
                           FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp - 4;
                           FSM__UTF8_wcsnrtombs.start();
                           _loc13_ = FSM__UTF8_wcsnrtombs.eax;
                           FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 12;
                           if(_loc13_ == -1)
                           {
                              _loc6_ = -1;
                              FSM__UTF8_wcsnrtombs.eax = _loc6_;
                           }
                           else
                           {
                              if(uint(_loc13_) <= uint(_loc12_))
                              {
                                 _loc14_ = _loc8_;
                                 _loc15_ = _loc13_;
                                 memcpy(_loc7_,_loc14_,_loc15_);
                                 _loc7_ = _loc13_;
                              }
                              else
                              {
                                 break;
                              }
                           }
                           if(_loc13_ == -1)
                           {
                           }
                        }
                        if(uint(_loc14_) < uint(_loc12_))
                        {
                           _loc4_ = op_li32(_loc4_) /*Alchemy*/;
                           if(_loc4_ != 0)
                           {
                              _loc4_ = _loc7_;
                              continue;
                           }
                           _loc4_ = _loc7_;
                        }
                        else
                        {
                           _loc4_ = op_li32(_loc4_) /*Alchemy*/;
                           if(_loc4_ != 0)
                           {
                              _loc4_ = _loc7_;
                              continue;
                           }
                           _loc4_ = _loc7_;
                        }
                     }
                     if(uint(_loc13_) <= uint(127))
                     {
                        _loc6_ = 0;
                        _loc4_ = _loc10_ + _loc4_;
                        _loc4_ = _loc4_ + -1;
                        FSM__UTF8_wcsnrtombs.eax = _loc4_;
                     }
                     else
                     {
                        _loc6_ = 0;
                        _loc4_ = _loc10_ + _loc4_;
                        _loc4_ = _loc4_ + -1;
                        FSM__UTF8_wcsnrtombs.eax = _loc4_;
                     }
                  }
                  else
                  {
                     break;
                  }
                  break;
               }
               FSM__UTF8_wcsnrtombs.eax = _loc10_;
            }
            else
            {
               if(_loc3_ == 0)
               {
                  _loc6_ = 0;
               }
               else
               {
                  _loc4_ = 0;
                  _loc2_ = _loc3_ + -1;
                  _loc3_ = -1;
                  _loc1_ = FSM__UTF8_wcsnrtombs.ebp + -16;
                  while(true)
                  {
                     _loc7_ = op_li32(_loc6_) /*Alchemy*/;
                     _loc8_ = _loc6_;
                     if(uint(_loc7_) <= uint(127))
                     {
                        _loc7_ = 1;
                     }
                     else
                     {
                        FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp - 12;
                        FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp - 4;
                        FSM__UTF8_wcsnrtombs.start();
                        _loc7_ = FSM__UTF8_wcsnrtombs.eax;
                        FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 12;
                        if(_loc7_ == -1)
                        {
                           _loc6_ = -1;
                           break;
                        }
                     }
                     if(uint(_loc7_) <= uint(127))
                     {
                        _loc8_ = op_li32(_loc8_) /*Alchemy*/;
                        if(_loc8_ == 0)
                        {
                           _loc6_ = _loc4_ + _loc7_;
                           _loc6_ = _loc6_ + -1;
                           FSM__UTF8_wcsnrtombs.eax = _loc6_;
                        }
                        else
                        {
                           _loc6_ = _loc6_ + 4;
                           _loc3_ = _loc3_ + 1;
                           _loc4_ = _loc7_ + _loc4_;
                           if(_loc2_ != _loc3_)
                           {
                              continue;
                           }
                           _loc6_ = _loc4_;
                           break;
                        }
                     }
                     else
                     {
                        _loc8_ = op_li32(_loc8_) /*Alchemy*/;
                        if(_loc8_ == 0)
                        {
                           _loc6_ = _loc4_ + _loc7_;
                           _loc6_ = _loc6_ + -1;
                           FSM__UTF8_wcsnrtombs.eax = _loc6_;
                        }
                        else
                        {
                           _loc6_ = _loc6_ + 4;
                           _loc3_ = _loc3_ + 1;
                           _loc4_ = _loc7_ + _loc4_;
                           if(_loc2_ != _loc3_)
                           {
                              continue;
                           }
                           _loc6_ = _loc4_;
                           break;
                        }
                     }
                  }
               }
               _loc1_ = _loc6_;
            }
            if(_loc1_ != 0)
            {
               FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.ebp;
               FSM__UTF8_wcsnrtombs.ebp = op_li32(FSM__UTF8_wcsnrtombs.esp) /*Alchemy*/;
               FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 4;
               FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 4;
               return;
            }
            FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.ebp;
            FSM__UTF8_wcsnrtombs.ebp = op_li32(FSM__UTF8_wcsnrtombs.esp) /*Alchemy*/;
            FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 4;
            FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 4;
            return;
         }
         if(_loc6_ != 0)
         {
            FSM__UTF8_wcsnrtombs.eax = _loc1_;
            FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.ebp;
            FSM__UTF8_wcsnrtombs.ebp = op_li32(FSM__UTF8_wcsnrtombs.esp) /*Alchemy*/;
            FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 4;
            FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 4;
            return;
         }
         FSM__UTF8_wcsnrtombs.eax = _loc1_;
         FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.ebp;
         FSM__UTF8_wcsnrtombs.ebp = op_li32(FSM__UTF8_wcsnrtombs.esp) /*Alchemy*/;
         FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 4;
         FSM__UTF8_wcsnrtombs.esp = FSM__UTF8_wcsnrtombs.esp + 4;
      }
   }
}
