package cmodule.lua_wrapper
{
   public final class FSM_countint389 extends Machine
   {
      
      public function FSM_countint389() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         FSM_countint389.esp = FSM_countint389.esp - 4;
         FSM_countint389.ebp = FSM_countint389.esp;
         FSM_countint389.esp = FSM_countint389.esp - 0;
         _loc5_ = op_lf64(FSM_countint389.ebp + 8) /*Alchemy*/;
         _loc1_ = op_li32(FSM_countint389.ebp + 20) /*Alchemy*/;
         _loc2_ = op_li32(FSM_countint389.ebp + 16) /*Alchemy*/;
         if(_loc2_ != 3)
         {
            _loc2_ = -2;
         }
         else
         {
            _loc2_ = int(_loc5_);
            _loc3_ = _loc2_ + -1;
            _loc6_ = Number(_loc2_);
            _loc2_ = _loc6_ == _loc5_?_loc3_:-2;
         }
         if(uint(_loc2_) <= uint(67108863))
         {
            if(uint(_loc2_) <= uint(255))
            {
               _loc3_ = -1;
            }
            else
            {
               _loc3_ = -1;
               while(true)
               {
                  _loc3_ = _loc3_ + 1;
                  _loc2_ = _loc2_ >>> 8;
                  if(uint(_loc2_) >= uint(256))
                  {
                     continue;
                  }
                  break;
               }
               _loc3_ = _loc3_ << 3;
               _loc3_ = _loc3_ | 7;
            }
            _loc4_ = FSM_countint389;
            _loc2_ = _loc4_ + _loc2_;
            _loc2_ = op_li8(_loc2_) /*Alchemy*/;
            _loc2_ = _loc2_ + _loc3_;
            _loc2_ = _loc2_ << 2;
            _loc1_ = _loc2_ + _loc1_;
            _loc2_ = op_li32(_loc1_ + 4) /*Alchemy*/;
            _loc2_ = _loc2_ + 1;
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = 0;
         }
         if(uint(_loc2_) <= uint(67108863))
         {
            FSM_countint389.eax = _loc1_;
            FSM_countint389.esp = FSM_countint389.ebp;
            FSM_countint389.ebp = op_li32(FSM_countint389.esp) /*Alchemy*/;
            FSM_countint389.esp = FSM_countint389.esp + 4;
            FSM_countint389.esp = FSM_countint389.esp + 4;
            return;
         }
         FSM_countint389.eax = _loc1_;
         FSM_countint389.esp = FSM_countint389.ebp;
         FSM_countint389.ebp = op_li32(FSM_countint389.esp) /*Alchemy*/;
         FSM_countint389.esp = FSM_countint389.esp + 4;
         FSM_countint389.esp = FSM_countint389.esp + 4;
      }
   }
}
