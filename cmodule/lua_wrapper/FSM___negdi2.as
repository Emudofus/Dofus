package cmodule.lua_wrapper
{
   public final class FSM___negdi2 extends Machine
   {
      
      public function FSM___negdi2() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM___negdi2.esp = FSM___negdi2.esp - 4;
         FSM___negdi2.ebp = FSM___negdi2.esp;
         FSM___negdi2.esp = FSM___negdi2.esp - 0;
         _loc1_ = 0;
         _loc2_ = op_li32(FSM___negdi2.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM___negdi2.ebp + 12) /*Alchemy*/;
         _loc4_ = _loc2_ != 0?1:0;
         _loc3_ = __subc(_loc1_,_loc3_);
         _loc4_ = _loc4_ & 1;
         _loc1_ = __subc(_loc1_,_loc2_);
         _loc2_ = __subc(_loc3_,_loc4_);
         FSM___negdi2.edx = _loc2_;
         FSM___negdi2.eax = _loc1_;
         FSM___negdi2.esp = FSM___negdi2.ebp;
         FSM___negdi2.ebp = op_li32(FSM___negdi2.esp) /*Alchemy*/;
         FSM___negdi2.esp = FSM___negdi2.esp + 4;
         FSM___negdi2.esp = FSM___negdi2.esp + 4;
      }
   }
}
