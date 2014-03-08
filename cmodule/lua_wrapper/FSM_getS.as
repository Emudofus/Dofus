package cmodule.lua_wrapper
{
   public final class FSM_getS extends Machine
   {
      
      public function FSM_getS() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM_getS.esp = FSM_getS.esp - 4;
         FSM_getS.ebp = FSM_getS.esp;
         FSM_getS.esp = FSM_getS.esp - 0;
         _loc1_ = op_li32(FSM_getS.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 4) /*Alchemy*/;
         _loc3_ = _loc1_ + 4;
         _loc4_ = op_li32(FSM_getS.ebp + 16) /*Alchemy*/;
         if(_loc2_ != 0)
         {
            _loc5_ = 0;
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
         }
         else
         {
            _loc1_ = 0;
         }
         if(_loc2_ != 0)
         {
            FSM_getS.eax = _loc1_;
            FSM_getS.esp = FSM_getS.ebp;
            FSM_getS.ebp = op_li32(FSM_getS.esp) /*Alchemy*/;
            FSM_getS.esp = FSM_getS.esp + 4;
            FSM_getS.esp = FSM_getS.esp + 4;
            return;
         }
         FSM_getS.eax = _loc1_;
         FSM_getS.esp = FSM_getS.ebp;
         FSM_getS.ebp = op_li32(FSM_getS.esp) /*Alchemy*/;
         FSM_getS.esp = FSM_getS.esp + 4;
         FSM_getS.esp = FSM_getS.esp + 4;
      }
   }
}
