package cmodule.lua_wrapper
{
   public final class FSM_strstr extends Machine
   {
      
      public function FSM_strstr() {
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
         FSM_strstr.esp = FSM_strstr.esp - 4;
         FSM_strstr.ebp = FSM_strstr.esp;
         FSM_strstr.esp = FSM_strstr.esp - 0;
         _loc1_ = op_li32(FSM_strstr.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li8(_loc1_) /*Alchemy*/;
         _loc3_ = op_li32(FSM_strstr.ebp + 8) /*Alchemy*/;
         _loc4_ = _loc1_ + 1;
         _loc5_ = _loc3_;
         if(_loc2_ == 0)
         {
            _loc1_ = _loc3_;
            FSM_strstr.eax = _loc1_;
         }
         else
         {
            _loc3_ = op_li8(_loc4_) /*Alchemy*/;
            if(_loc3_ != 0)
            {
               _loc3_ = _loc1_;
               while(true)
               {
                  _loc6_ = op_li8(_loc3_ + 2) /*Alchemy*/;
                  _loc3_ = _loc3_ + 1;
                  if(_loc6_ != 0)
                  {
                     continue;
                  }
                  break;
               }
               _loc3_ = _loc3_ + 1;
            }
            else
            {
               _loc3_ = _loc4_;
            }
            _loc6_ = _loc4_;
            _loc7_ = _loc3_;
            loop1:
            while(true)
            {
               _loc8_ = op_li8(_loc5_) /*Alchemy*/;
               _loc9_ = _loc5_;
               if(_loc8_ == 0)
               {
                  _loc1_ = 0;
                  FSM_strstr.eax = _loc1_;
                  break;
               }
               _loc10_ = _loc2_ & 255;
               _loc8_ = _loc8_ & 255;
               if(_loc8_ != _loc10_)
               {
                  continue;
               }
               if(_loc3_ != _loc4_)
               {
                  _loc8_ = 1;
                  _loc10_ = _loc7_ - _loc6_;
                  while(true)
                  {
                     _loc11_ = _loc1_ + _loc8_;
                     _loc12_ = _loc5_ + _loc8_;
                     _loc12_ = op_li8(_loc12_) /*Alchemy*/;
                     _loc11_ = op_li8(_loc11_) /*Alchemy*/;
                     if(_loc12_ == _loc11_)
                     {
                        _loc11_ = _loc10_ + -1;
                        _loc8_ = _loc8_ + 1;
                        _loc12_ = _loc12_ & 255;
                        if(_loc12_ != 0)
                        {
                           if(_loc10_ != 1)
                           {
                              _loc10_ = _loc11_;
                              continue;
                           }
                           break;
                        }
                        break;
                        break;
                     }
                     continue loop1;
                  }
               }
               FSM_strstr.eax = _loc9_;
               break;
            }
         }
         FSM_strstr.esp = FSM_strstr.ebp;
         FSM_strstr.ebp = op_li32(FSM_strstr.esp) /*Alchemy*/;
         FSM_strstr.esp = FSM_strstr.esp + 4;
         FSM_strstr.esp = FSM_strstr.esp + 4;
      }
   }
}
