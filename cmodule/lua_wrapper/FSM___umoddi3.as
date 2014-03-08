package cmodule.lua_wrapper
{
   public final class FSM___umoddi3 extends Machine
   {
      
      public function FSM___umoddi3() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM___umoddi3.esp = FSM___umoddi3.esp - 4;
         FSM___umoddi3.ebp = FSM___umoddi3.esp;
         FSM___umoddi3.esp = FSM___umoddi3.esp - 8;
         _loc1_ = FSM___umoddi3.ebp + -8;
         FSM___umoddi3.esp = FSM___umoddi3.esp - 20;
         _loc2_ = op_li32(FSM___umoddi3.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM___umoddi3.ebp + 12) /*Alchemy*/;
         _loc4_ = op_li32(FSM___umoddi3.ebp + 16) /*Alchemy*/;
         _loc5_ = op_li32(FSM___umoddi3.ebp + 20) /*Alchemy*/;
         FSM___umoddi3.esp = FSM___umoddi3.esp - 4;
         FSM___umoddi3.start();
         _loc1_ = FSM___umoddi3.eax;
         _loc1_ = FSM___umoddi3.edx;
         FSM___umoddi3.esp = FSM___umoddi3.esp + 20;
         _loc1_ = op_li32(FSM___umoddi3.ebp + -8) /*Alchemy*/;
         _loc2_ = op_li32(FSM___umoddi3.ebp + -4) /*Alchemy*/;
         FSM___umoddi3.edx = _loc2_;
         FSM___umoddi3.eax = _loc1_;
         FSM___umoddi3.esp = FSM___umoddi3.ebp;
         FSM___umoddi3.ebp = op_li32(FSM___umoddi3.esp) /*Alchemy*/;
         FSM___umoddi3.esp = FSM___umoddi3.esp + 4;
         FSM___umoddi3.esp = FSM___umoddi3.esp + 4;
      }
   }
}
