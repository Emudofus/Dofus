package cmodule.lua_wrapper
{
   public final class FSM___ashrdi3 extends Machine
   {
      
      public function FSM___ashrdi3() {
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
         FSM___ashrdi3.esp = FSM___ashrdi3.esp - 4;
         FSM___ashrdi3.ebp = FSM___ashrdi3.esp;
         FSM___ashrdi3.esp = FSM___ashrdi3.esp - 0;
         _loc1_ = op_li32(FSM___ashrdi3.ebp + 16) /*Alchemy*/;
         _loc2_ = op_li32(FSM___ashrdi3.ebp + 20) /*Alchemy*/;
         _loc3_ = op_li32(FSM___ashrdi3.ebp + 8) /*Alchemy*/;
         _loc4_ = op_li32(FSM___ashrdi3.ebp + 12) /*Alchemy*/;
         _loc5_ = uint(_loc1_) < uint(32)?1:0;
         _loc6_ = _loc2_ == 0?1:0;
         _loc5_ = _loc6_ != 0?_loc5_:0;
         if(_loc5_ == 0)
         {
            _loc3_ = 0;
            _loc5_ = _loc4_ >> 31;
            _loc6_ = _loc2_ != 0?1:0;
            _loc7_ = uint(_loc1_) > uint(63)?1:0;
            _loc2_ = _loc2_ == 0?1:0;
            _loc8_ = _loc3_;
            _loc9_ = _loc5_;
            _loc2_ = _loc2_ != 0?_loc7_:_loc6_;
            if(_loc2_ == 0)
            {
               _loc3_ = _loc1_ + -32;
               _loc3_ = _loc4_ >> _loc3_;
               _loc3_ = _loc3_ | _loc8_;
               FSM___ashrdi3.edx = _loc5_;
            }
            else
            {
               _loc1_ = _loc5_ | _loc3_;
               _loc2_ = _loc8_ | _loc9_;
               FSM___ashrdi3.edx = _loc1_;
               FSM___ashrdi3.eax = _loc2_;
            }
            FSM___ashrdi3.esp = FSM___ashrdi3.ebp;
            FSM___ashrdi3.ebp = op_li32(FSM___ashrdi3.esp) /*Alchemy*/;
            FSM___ashrdi3.esp = FSM___ashrdi3.esp + 4;
            FSM___ashrdi3.esp = FSM___ashrdi3.esp + 4;
            return;
         }
         _loc2_ = _loc1_ | _loc2_;
         if(_loc2_ != 0)
         {
            _loc2_ = 32 - _loc1_;
            _loc2_ = _loc4_ << _loc2_;
            _loc3_ = _loc3_ >>> _loc1_;
            _loc4_ = _loc4_ >> _loc1_;
            _loc3_ = _loc2_ | _loc3_;
         }
         FSM___ashrdi3.edx = _loc4_;
         FSM___ashrdi3.eax = _loc3_;
         FSM___ashrdi3.esp = FSM___ashrdi3.ebp;
         FSM___ashrdi3.ebp = op_li32(FSM___ashrdi3.esp) /*Alchemy*/;
         FSM___ashrdi3.esp = FSM___ashrdi3.esp + 4;
         FSM___ashrdi3.esp = FSM___ashrdi3.esp + 4;
      }
   }
}
