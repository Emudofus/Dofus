package cmodule.lua_wrapper
{
   public final class FSM_need_value extends Machine
   {
      
      public function FSM_need_value() {
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
         FSM_need_value.esp = FSM_need_value.esp - 4;
         FSM_need_value.ebp = FSM_need_value.esp;
         FSM_need_value.esp = FSM_need_value.esp - 0;
         _loc1_ = op_li32(FSM_need_value.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_need_value.ebp + 12) /*Alchemy*/;
         if(_loc2_ != -1)
         {
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            _loc3_ = op_li32(_loc1_ + 12) /*Alchemy*/;
            while(true)
            {
               _loc4_ = _loc2_ << 2;
               _loc4_ = _loc3_ + _loc4_;
               if(_loc2_ > 0)
               {
                  _loc5_ = FSM_need_value;
                  _loc6_ = _loc2_ << 2;
                  _loc6_ = _loc6_ + _loc3_;
                  _loc7_ = op_li32(_loc6_ + -4) /*Alchemy*/;
                  _loc7_ = _loc7_ & 63;
                  _loc5_ = _loc5_ + _loc7_;
                  _loc5_ = op_li8(_loc5_) /*Alchemy*/;
                  _loc5_ = _loc5_ << 24;
                  _loc5_ = _loc5_ >> 24;
                  _loc6_ = _loc6_ + -4;
                  _loc4_ = _loc5_ > -1?_loc4_:_loc6_;
               }
               _loc4_ = op_li32(_loc4_) /*Alchemy*/;
               _loc4_ = _loc4_ & 63;
               if(_loc4_ != 27)
               {
                  _loc1_ = 1;
                  break;
               }
               _loc4_ = op_li32(_loc1_ + 12) /*Alchemy*/;
               _loc5_ = _loc2_ << 2;
               _loc4_ = _loc4_ + _loc5_;
               _loc4_ = op_li32(_loc4_) /*Alchemy*/;
               _loc4_ = _loc4_ >>> 14;
               _loc4_ = _loc4_ + -131071;
               if(_loc4_ == -1)
               {
                  _loc2_ = -1;
               }
               else
               {
                  _loc2_ = _loc2_ + _loc4_;
                  _loc2_ = _loc2_ + 1;
               }
               if(_loc2_ != -1)
               {
                  continue;
               }
            }
            FSM_need_value.eax = _loc1_;
            FSM_need_value.esp = FSM_need_value.ebp;
            FSM_need_value.ebp = op_li32(FSM_need_value.esp) /*Alchemy*/;
            FSM_need_value.esp = FSM_need_value.esp + 4;
            FSM_need_value.esp = FSM_need_value.esp + 4;
            return;
         }
         _loc1_ = 0;
         FSM_need_value.eax = _loc1_;
         FSM_need_value.esp = FSM_need_value.ebp;
         FSM_need_value.ebp = op_li32(FSM_need_value.esp) /*Alchemy*/;
         FSM_need_value.esp = FSM_need_value.esp + 4;
         FSM_need_value.esp = FSM_need_value.esp + 4;
      }
   }
}
