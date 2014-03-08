package cmodule.lua_wrapper
{
   public final class FSM___divdi3 extends Machine
   {
      
      public function FSM___divdi3() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         FSM___divdi3.esp = FSM___divdi3.esp - 4;
         FSM___divdi3.ebp = FSM___divdi3.esp;
         FSM___divdi3.esp = FSM___divdi3.esp - 0;
         _loc1_ = 0;
         _loc2_ = op_li32(FSM___divdi3.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM___divdi3.ebp + 20) /*Alchemy*/;
         _loc4_ = op_li32(FSM___divdi3.ebp + 8) /*Alchemy*/;
         _loc5_ = _loc2_ >> 31;
         _loc6_ = op_li32(FSM___divdi3.ebp + 16) /*Alchemy*/;
         _loc7_ = _loc3_ >> 31;
         _loc4_ = __addc(_loc4_,_loc5_);
         _loc8_ = __adde(_loc2_,_loc5_);
         _loc6_ = __addc(_loc6_,_loc7_);
         _loc9_ = __adde(_loc3_,_loc7_);
         FSM___divdi3.esp = FSM___divdi3.esp - 20;
         _loc9_ = _loc9_ ^ _loc7_;
         _loc6_ = _loc6_ ^ _loc7_;
         _loc7_ = _loc8_ ^ _loc5_;
         _loc4_ = _loc4_ ^ _loc5_;
         FSM___divdi3.esp = FSM___divdi3.esp - 4;
         FSM___divdi3.start();
         _loc1_ = FSM___divdi3.eax;
         _loc4_ = FSM___divdi3.edx;
         FSM___divdi3.esp = FSM___divdi3.esp + 20;
         _loc2_ = _loc2_ >>> 31;
         _loc3_ = _loc3_ >>> 31;
         if(_loc2_ != _loc3_)
         {
            _loc2_ = 0;
            _loc1_ = __subc(_loc2_,_loc1_);
            _loc4_ = __sube(_loc2_,_loc4_);
         }
         FSM___divdi3.edx = _loc4_;
         FSM___divdi3.eax = _loc1_;
         FSM___divdi3.esp = FSM___divdi3.ebp;
         FSM___divdi3.ebp = op_li32(FSM___divdi3.esp) /*Alchemy*/;
         FSM___divdi3.esp = FSM___divdi3.esp + 4;
         FSM___divdi3.esp = FSM___divdi3.esp + 4;
      }
   }
}
