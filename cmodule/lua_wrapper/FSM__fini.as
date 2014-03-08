package cmodule.lua_wrapper
{
   public final class FSM__fini extends Machine
   {
      
      public function FSM__fini() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         FSM__fini.esp = FSM__fini.esp - 4;
         FSM__fini.ebp = FSM__fini.esp;
         FSM__fini.esp = FSM__fini.esp - 0;
         _loc1_ = FSM__fini;
         _loc2_ = 4;
         log(_loc2_,FSM__fini.gworker.stringFromPtr(_loc1_));
         FSM__fini.esp = FSM__fini.ebp;
         FSM__fini.ebp = op_li32(FSM__fini.esp) /*Alchemy*/;
         FSM__fini.esp = FSM__fini.esp + 4;
         FSM__fini.esp = FSM__fini.esp + 4;
      }
   }
}
