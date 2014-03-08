package cmodule.lua_wrapper
{
   public final class FSM___ulp_D2A extends Machine
   {
      
      public function FSM___ulp_D2A() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = NaN;
         FSM___ulp_D2A.esp = FSM___ulp_D2A.esp - 4;
         FSM___ulp_D2A.ebp = FSM___ulp_D2A.esp;
         FSM___ulp_D2A.esp = FSM___ulp_D2A.esp - 24;
         _loc1_ = op_li32(FSM___ulp_D2A.ebp + 12) /*Alchemy*/;
         _loc1_ = _loc1_ & 2146435072;
         _loc2_ = _loc1_ + -54525952;
         if(_loc2_ >= 1)
         {
            _loc1_ = 0;
            _loc4_ = op_lf64(FSM___ulp_D2A.ebp + -8) /*Alchemy*/;
         }
         else
         {
            _loc1_ = 54525952 - _loc1_;
            _loc1_ = _loc1_ >> 20;
            if(_loc1_ <= 19)
            {
               _loc2_ = 524288;
               _loc3_ = 0;
               _loc1_ = _loc2_ >>> _loc1_;
               _loc4_ = op_lf64(FSM___ulp_D2A.ebp + -16) /*Alchemy*/;
            }
            else
            {
               _loc2_ = _loc1_ + -20;
               if(_loc2_ <= 30)
               {
                  _loc2_ = 1;
                  _loc1_ = 51 - _loc1_;
                  _loc3_ = 0;
                  _loc1_ = _loc2_ << _loc1_;
                  _loc4_ = op_lf64(FSM___ulp_D2A.ebp + -24) /*Alchemy*/;
               }
               else
               {
                  _loc4_ = 4.9E-324;
               }
               if(_loc2_ <= 30)
               {
               }
            }
            if(_loc1_ <= 19)
            {
            }
         }
         if(_loc2_ >= 1)
         {
            FSM___ulp_D2A.st0 = _loc4_;
            FSM___ulp_D2A.esp = FSM___ulp_D2A.ebp;
            FSM___ulp_D2A.ebp = op_li32(FSM___ulp_D2A.esp) /*Alchemy*/;
            FSM___ulp_D2A.esp = FSM___ulp_D2A.esp + 4;
            FSM___ulp_D2A.esp = FSM___ulp_D2A.esp + 4;
            return;
         }
         FSM___ulp_D2A.st0 = _loc4_;
         FSM___ulp_D2A.esp = FSM___ulp_D2A.ebp;
         FSM___ulp_D2A.ebp = op_li32(FSM___ulp_D2A.esp) /*Alchemy*/;
         FSM___ulp_D2A.esp = FSM___ulp_D2A.esp + 4;
         FSM___ulp_D2A.esp = FSM___ulp_D2A.esp + 4;
      }
   }
}
