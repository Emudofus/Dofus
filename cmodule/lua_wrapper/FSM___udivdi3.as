package cmodule.lua_wrapper
{
   public final class FSM___udivdi3 extends Machine
   {
      
      public function FSM___udivdi3() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM___udivdi3.esp = FSM___udivdi3.esp - 4;
         FSM___udivdi3.ebp = FSM___udivdi3.esp;
         FSM___udivdi3.esp = FSM___udivdi3.esp - 0;
         _loc1_ = 0;
         FSM___udivdi3.esp = FSM___udivdi3.esp - 20;
         _loc2_ = op_li32(FSM___udivdi3.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM___udivdi3.ebp + 12) /*Alchemy*/;
         _loc4_ = op_li32(FSM___udivdi3.ebp + 16) /*Alchemy*/;
         _loc5_ = op_li32(FSM___udivdi3.ebp + 20) /*Alchemy*/;
         FSM___udivdi3.esp = FSM___udivdi3.esp - 4;
         FSM___udivdi3.start();
         _loc1_ = FSM___udivdi3.eax;
         _loc2_ = FSM___udivdi3.edx;
         FSM___udivdi3.esp = FSM___udivdi3.esp + 20;
         FSM___udivdi3.edx = _loc2_;
         FSM___udivdi3.eax = _loc1_;
         FSM___udivdi3.esp = FSM___udivdi3.ebp;
         FSM___udivdi3.ebp = op_li32(FSM___udivdi3.esp) /*Alchemy*/;
         FSM___udivdi3.esp = FSM___udivdi3.esp + 4;
         FSM___udivdi3.esp = FSM___udivdi3.esp + 4;
      }
   }
}
