package cmodule.lua_wrapper
{
   public final class FSM___fix_locale_grouping_str extends Machine
   {
      
      public function FSM___fix_locale_grouping_str() {
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
         FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp - 4;
         FSM___fix_locale_grouping_str.ebp = FSM___fix_locale_grouping_str.esp;
         FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp - 0;
         _loc1_ = op_li32(FSM___fix_locale_grouping_str.ebp + 8) /*Alchemy*/;
         if(_loc1_ != 0)
         {
            _loc2_ = op_li8(_loc1_) /*Alchemy*/;
            if(_loc2_ != 0)
            {
               _loc2_ = _loc1_;
               _loc3_ = _loc1_;
               loop0:
               while(true)
               {
                  _loc7_ = _loc2_;
                  _loc5_ = _loc3_;
                  _loc3_ = op_li8(_loc7_) /*Alchemy*/;
                  _loc4_ = _loc5_;
                  _loc6_ = _loc7_;
                  if(_loc3_ != 0)
                  {
                     _loc3_ = 0;
                     _loc2_ = _loc3_;
                     while(true)
                     {
                        _loc8_ = _loc6_ + _loc2_;
                        _loc8_ = op_li8(_loc8_) /*Alchemy*/;
                        _loc9_ = _loc4_ + _loc3_;
                        if(_loc8_ != 59)
                        {
                           _loc10_ = _loc8_ & 255;
                           if(_loc10_ == 45)
                           {
                              _loc10_ = _loc6_ + _loc2_;
                              _loc10_ = op_li8(_loc10_ + 1) /*Alchemy*/;
                              if(_loc10_ == 49)
                              {
                                 _loc8_ = 127;
                                 _loc8_ = _loc6_ + _loc2_;
                                 _loc8_ = op_li8(_loc8_ + 2) /*Alchemy*/;
                                 _loc2_ = _loc2_ + 2;
                                 _loc3_ = _loc3_ + 1;
                                 if(_loc8_ != 0)
                                 {
                                    continue;
                                 }
                                 _loc3_ = _loc5_ + _loc3_;
                              }
                              if(_loc10_ == 49)
                              {
                                 FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.ebp;
                                 FSM___fix_locale_grouping_str.ebp = op_li32(FSM___fix_locale_grouping_str.esp) /*Alchemy*/;
                                 FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
                                 FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
                                 return;
                              }
                              FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.ebp;
                              FSM___fix_locale_grouping_str.ebp = op_li32(FSM___fix_locale_grouping_str.esp) /*Alchemy*/;
                              FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
                              FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
                              return;
                           }
                           _loc4_ = FSM___fix_locale_grouping_str;
                           _loc10_ = _loc8_ & 255;
                           _loc10_ = _loc10_ << 2;
                           _loc4_ = _loc4_ + _loc10_;
                           _loc4_ = op_li32(_loc4_ + 52) /*Alchemy*/;
                           _loc4_ = _loc4_ & 1024;
                           if(_loc4_ != 0)
                           {
                              _loc4_ = FSM___fix_locale_grouping_str;
                              _loc10_ = _loc2_ | 1;
                              _loc7_ = _loc7_ + _loc10_;
                              _loc10_ = op_li8(_loc7_) /*Alchemy*/;
                              _loc11_ = _loc10_ << 2;
                              _loc4_ = _loc4_ + _loc11_;
                              _loc4_ = op_li32(_loc4_ + 52) /*Alchemy*/;
                              _loc8_ = _loc8_ + -48;
                              _loc4_ = _loc4_ & 1024;
                              if(_loc4_ == 0)
                              {
                                 _loc2_ = _loc6_ + _loc2_;
                                 _loc7_ = _loc8_;
                              }
                              else
                              {
                                 _loc2_ = _loc8_ * 10;
                                 _loc2_ = _loc2_ + _loc10_;
                                 _loc4_ = _loc2_ + -48;
                                 _loc2_ = _loc7_;
                                 _loc7_ = _loc4_;
                              }
                              _loc4_ = _loc7_;
                              _loc4_ = _loc4_ & 255;
                              if(_loc4_ == 0)
                              {
                                 _loc2_ = FSM___fix_locale_grouping_str;
                                 _loc2_ = _loc9_ == _loc1_?_loc2_:_loc1_;
                                 FSM___fix_locale_grouping_str.eax = _loc2_;
                                 FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.ebp;
                                 FSM___fix_locale_grouping_str.ebp = op_li32(FSM___fix_locale_grouping_str.esp) /*Alchemy*/;
                                 FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
                                 FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
                                 return;
                              }
                              _loc3_ = _loc3_ + _loc5_;
                              _loc3_ = _loc3_ + 1;
                              break;
                           }
                           break loop0;
                        }
                        _loc2_ = _loc6_ + _loc2_;
                        _loc3_ = _loc4_ + _loc3_;
                        break;
                     }
                     _loc2_ = _loc2_ + 1;
                     continue;
                  }
                  _loc3_ = _loc5_;
                  _loc2_ = _loc3_;
                  _loc3_ = 0;
                  FSM___fix_locale_grouping_str.eax = _loc1_;
                  FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.ebp;
                  FSM___fix_locale_grouping_str.ebp = op_li32(FSM___fix_locale_grouping_str.esp) /*Alchemy*/;
                  FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
                  FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
                  return;
               }
            }
            if(_loc2_ != 0)
            {
            }
         }
         _loc1_ = FSM___fix_locale_grouping_str;
         FSM___fix_locale_grouping_str.eax = _loc1_;
         FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.ebp;
         FSM___fix_locale_grouping_str.ebp = op_li32(FSM___fix_locale_grouping_str.esp) /*Alchemy*/;
         FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
         FSM___fix_locale_grouping_str.esp = FSM___fix_locale_grouping_str.esp + 4;
      }
   }
}
