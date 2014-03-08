package cmodule.lua_wrapper
{
   public final class FSM___floatdidf extends Machine
   {
      
      public function FSM___floatdidf() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         FSM___floatdidf.esp = FSM___floatdidf.esp - 4;
         FSM___floatdidf.ebp = FSM___floatdidf.esp;
         FSM___floatdidf.esp = FSM___floatdidf.esp - 0;
         _loc1_ = op_li32(FSM___floatdidf.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM___floatdidf.ebp + 8) /*Alchemy*/;
         _loc3_ = _loc1_ >> 31;
         _loc2_ = __addc(_loc2_,_loc3_);
         _loc4_ = __adde(_loc1_,_loc3_);
         _loc4_ = _loc4_ ^ _loc3_;
         _loc2_ = _loc2_ ^ _loc3_;
         _loc5_ = Number(uint(_loc4_));
         _loc6_ = Number(uint(_loc2_));
         _loc5_ = _loc5_ * 4.29497E9;
         _loc5_ = _loc6_ + _loc5_;
         if(_loc1_ <= -1)
         {
            _loc5_ = -_loc5_;
         }
         FSM___floatdidf.st0 = _loc5_;
         FSM___floatdidf.esp = FSM___floatdidf.ebp;
         FSM___floatdidf.ebp = op_li32(FSM___floatdidf.esp) /*Alchemy*/;
         FSM___floatdidf.esp = FSM___floatdidf.esp + 4;
         FSM___floatdidf.esp = FSM___floatdidf.esp + 4;
      }
   }
}
