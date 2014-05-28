package cmodule.lua_wrapper
{
   public final class FSM_time extends Machine
   {
      
      public function FSM_time() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         FSM_time.esp = FSM_time.esp - 4;
         FSM_time.ebp = FSM_time.esp;
         FSM_time.esp = FSM_time.esp - 0;
         _loc1_ = FSM_time.gworker.getSecsSetMS();
         _loc2_ = _loc1_;
         _loc1_ = FSM_time.sMS;
         FSM_time.eax = _loc2_;
         FSM_time.esp = FSM_time.ebp;
         FSM_time.ebp = op_li32(FSM_time.esp) /*Alchemy*/;
         FSM_time.esp = FSM_time.esp + 4;
         FSM_time.esp = FSM_time.esp + 4;
      }
   }
}
