package cmodule.lua_wrapper
{
   public final class FSM___iordi3 extends Machine
   {
      
      public function FSM___iordi3() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM___iordi3.esp = FSM___iordi3.esp - 4;
         FSM___iordi3.ebp = FSM___iordi3.esp;
         FSM___iordi3.esp = FSM___iordi3.esp - 0;
         _loc1_ = op_li32(FSM___iordi3.ebp + 16) /*Alchemy*/;
         _loc2_ = op_li32(FSM___iordi3.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM___iordi3.ebp + 12) /*Alchemy*/;
         _loc4_ = op_li32(FSM___iordi3.ebp + 20) /*Alchemy*/;
         _loc3_ = _loc3_ | _loc4_;
         _loc1_ = _loc1_ | _loc2_;
         FSM___iordi3.edx = _loc3_;
         FSM___iordi3.eax = _loc1_;
         FSM___iordi3.esp = FSM___iordi3.ebp;
         FSM___iordi3.ebp = op_li32(FSM___iordi3.esp) /*Alchemy*/;
         FSM___iordi3.esp = FSM___iordi3.esp + 4;
         FSM___iordi3.esp = FSM___iordi3.esp + 4;
      }
   }
}
