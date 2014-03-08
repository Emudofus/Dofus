package cmodule.lua_wrapper
{
   public final class FSM__exit extends Machine
   {
      
      public function FSM__exit() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         FSM__exit.esp = FSM__exit.esp - 4;
         FSM__exit.ebp = FSM__exit.esp;
         FSM__exit.esp = FSM__exit.esp - 0;
         _loc1_ = op_li32(FSM__exit.ebp + 8) /*Alchemy*/;
         throw new AlchemyExit(_loc1_);
      }
   }
}
