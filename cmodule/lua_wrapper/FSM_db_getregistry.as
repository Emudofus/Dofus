package cmodule.lua_wrapper
{
   public final class FSM_db_getregistry extends Machine
   {
      
      public function FSM_db_getregistry() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = NaN;
         FSM_db_getregistry.esp = FSM_db_getregistry.esp - 4;
         FSM_db_getregistry.ebp = FSM_db_getregistry.esp;
         FSM_db_getregistry.esp = FSM_db_getregistry.esp - 0;
         _loc1_ = -10000;
         FSM_db_getregistry.esp = FSM_db_getregistry.esp - 8;
         _loc2_ = op_li32(FSM_db_getregistry.ebp + 8) /*Alchemy*/;
         FSM_db_getregistry.esp = FSM_db_getregistry.esp - 4;
         FSM_db_getregistry.start();
         _loc1_ = FSM_db_getregistry.eax;
         FSM_db_getregistry.esp = FSM_db_getregistry.esp + 8;
         _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         _loc4_ = op_lf64(_loc1_) /*Alchemy*/;
         _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc1_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         _loc1_ = _loc1_ + 12;
         _loc1_ = 1;
         FSM_db_getregistry.eax = _loc1_;
         FSM_db_getregistry.esp = FSM_db_getregistry.ebp;
         FSM_db_getregistry.ebp = op_li32(FSM_db_getregistry.esp) /*Alchemy*/;
         FSM_db_getregistry.esp = FSM_db_getregistry.esp + 4;
         FSM_db_getregistry.esp = FSM_db_getregistry.esp + 4;
      }
   }
}
