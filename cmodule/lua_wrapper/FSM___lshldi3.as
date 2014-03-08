package cmodule.lua_wrapper
{
   public final class FSM___lshldi3 extends Machine
   {
      
      public function FSM___lshldi3() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         FSM___lshldi3.esp = FSM___lshldi3.esp - 4;
         FSM___lshldi3.ebp = FSM___lshldi3.esp;
         FSM___lshldi3.esp = FSM___lshldi3.esp - 0;
         _loc1_ = op_li32(FSM___lshldi3.ebp + 16) /*Alchemy*/;
         _loc2_ = op_li32(FSM___lshldi3.ebp + 20) /*Alchemy*/;
         _loc3_ = op_li32(FSM___lshldi3.ebp + 8) /*Alchemy*/;
         _loc4_ = op_li32(FSM___lshldi3.ebp + 12) /*Alchemy*/;
         _loc5_ = uint(_loc1_) < uint(32)?1:0;
         _loc6_ = _loc2_ == 0?1:0;
         _loc5_ = _loc6_ != 0?_loc5_:0;
         if(_loc5_ == 0)
         {
            _loc4_ = uint(_loc1_) < uint(64)?1:0;
            _loc2_ = _loc2_ == 0?1:0;
            _loc2_ = _loc2_ != 0?_loc4_:0;
            if(_loc2_ == 0)
            {
               _loc1_ = 0;
               _loc2_ = _loc1_;
            }
            else
            {
               _loc2_ = 0;
               _loc1_ = _loc1_ + -32;
               _loc1_ = _loc3_ << _loc1_;
               FSM___lshldi3.edx = _loc1_;
               FSM___lshldi3.eax = _loc2_;
            }
            FSM___lshldi3.esp = FSM___lshldi3.ebp;
            FSM___lshldi3.ebp = op_li32(FSM___lshldi3.esp) /*Alchemy*/;
            FSM___lshldi3.esp = FSM___lshldi3.esp + 4;
            FSM___lshldi3.esp = FSM___lshldi3.esp + 4;
            return;
         }
         _loc2_ = _loc1_ | _loc2_;
         if(_loc2_ == 0)
         {
            _loc1_ = _loc3_;
            _loc2_ = _loc4_;
         }
         else
         {
            _loc2_ = 32 - _loc1_;
            _loc2_ = _loc3_ >>> _loc2_;
            _loc4_ = _loc4_ << _loc1_;
            _loc1_ = _loc3_ << _loc1_;
            _loc2_ = _loc2_ | _loc4_;
         }
         FSM___lshldi3.edx = _loc2_;
         FSM___lshldi3.eax = _loc1_;
         FSM___lshldi3.esp = FSM___lshldi3.ebp;
         FSM___lshldi3.ebp = op_li32(FSM___lshldi3.esp) /*Alchemy*/;
         FSM___lshldi3.esp = FSM___lshldi3.esp + 4;
         FSM___lshldi3.esp = FSM___lshldi3.esp + 4;
      }
   }
}
