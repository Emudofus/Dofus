package cmodule.lua_wrapper
{
   public final class FSM_db_getfenv extends Machine
   {
      
      public function FSM_db_getfenv() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         FSM_db_getfenv.esp = FSM_db_getfenv.esp - 4;
         FSM_db_getfenv.ebp = FSM_db_getfenv.esp;
         FSM_db_getfenv.esp = FSM_db_getfenv.esp - 0;
         _loc1_ = 1;
         FSM_db_getfenv.esp = FSM_db_getfenv.esp - 8;
         _loc2_ = op_li32(FSM_db_getfenv.ebp + 8) /*Alchemy*/;
         FSM_db_getfenv.esp = FSM_db_getfenv.esp - 4;
         FSM_db_getfenv.start();
         FSM_db_getfenv.esp = FSM_db_getfenv.esp + 8;
         FSM_db_getfenv.eax = _loc1_;
         FSM_db_getfenv.esp = FSM_db_getfenv.ebp;
         FSM_db_getfenv.ebp = op_li32(FSM_db_getfenv.esp) /*Alchemy*/;
         FSM_db_getfenv.esp = FSM_db_getfenv.esp + 4;
         FSM_db_getfenv.esp = FSM_db_getfenv.esp + 4;
      }
   }
}
