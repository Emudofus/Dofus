package cmodule.lua_wrapper
{
   public final class FSM___one_cmpldi2 extends Machine
   {
      
      public function FSM___one_cmpldi2() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         FSM___one_cmpldi2.esp = FSM___one_cmpldi2.esp - 4;
         FSM___one_cmpldi2.ebp = FSM___one_cmpldi2.esp;
         FSM___one_cmpldi2.esp = FSM___one_cmpldi2.esp - 0;
         _loc1_ = op_li32(FSM___one_cmpldi2.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM___one_cmpldi2.ebp + 12) /*Alchemy*/;
         _loc2_ = _loc2_ ^ -1;
         _loc1_ = _loc1_ ^ -1;
         FSM___one_cmpldi2.edx = _loc2_;
         FSM___one_cmpldi2.eax = _loc1_;
         FSM___one_cmpldi2.esp = FSM___one_cmpldi2.ebp;
         FSM___one_cmpldi2.ebp = op_li32(FSM___one_cmpldi2.esp) /*Alchemy*/;
         FSM___one_cmpldi2.esp = FSM___one_cmpldi2.esp + 4;
         FSM___one_cmpldi2.esp = FSM___one_cmpldi2.esp + 4;
      }
   }
}
