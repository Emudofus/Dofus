package cmodule.lua_wrapper
{
   public final class FSM___ratio_D2A extends Machine
   {
      
      public function FSM___ratio_D2A() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp - 4;
         FSM___ratio_D2A.ebp = FSM___ratio_D2A.esp;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp - 40;
         _loc1_ = FSM___ratio_D2A.ebp + -8;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp - 8;
         _loc2_ = op_li32(FSM___ratio_D2A.ebp + 8) /*Alchemy*/;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp - 4;
         FSM___ratio_D2A.start();
         _loc7_ = FSM___ratio_D2A.st0;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp + 8;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp - 8;
         _loc1_ = op_li32(FSM___ratio_D2A.ebp + 12) /*Alchemy*/;
         _loc3_ = FSM___ratio_D2A.ebp + -4;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp - 4;
         FSM___ratio_D2A.start();
         _loc8_ = FSM___ratio_D2A.st0;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp + 8;
         _loc2_ = op_li32(_loc2_ + 16) /*Alchemy*/;
         _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
         _loc1_ = _loc2_ - _loc1_;
         _loc2_ = op_li32(FSM___ratio_D2A.ebp + -8) /*Alchemy*/;
         _loc3_ = op_li32(FSM___ratio_D2A.ebp + -4) /*Alchemy*/;
         _loc1_ = _loc1_ << 5;
         _loc2_ = _loc2_ - _loc3_;
         _loc3_ = op_li32(FSM___ratio_D2A.ebp + -16) /*Alchemy*/;
         _loc4_ = op_li32(FSM___ratio_D2A.ebp + -12) /*Alchemy*/;
         _loc5_ = op_li32(FSM___ratio_D2A.ebp + -24) /*Alchemy*/;
         _loc6_ = op_li32(FSM___ratio_D2A.ebp + -20) /*Alchemy*/;
         _loc1_ = _loc1_ + _loc2_;
         if(_loc1_ >= 1)
         {
            _loc1_ = _loc1_ << 20;
            _loc1_ = _loc1_ + _loc4_;
            _loc7_ = op_lf64(FSM___ratio_D2A.ebp + -32) /*Alchemy*/;
         }
         else
         {
            _loc1_ = _loc1_ << 20;
            _loc1_ = _loc6_ - _loc1_;
            _loc8_ = op_lf64(FSM___ratio_D2A.ebp + -40) /*Alchemy*/;
         }
         if(_loc1_ >= 1)
         {
            _loc7_ = _loc7_ / _loc8_;
            FSM___ratio_D2A.st0 = _loc7_;
            FSM___ratio_D2A.esp = FSM___ratio_D2A.ebp;
            FSM___ratio_D2A.ebp = op_li32(FSM___ratio_D2A.esp) /*Alchemy*/;
            FSM___ratio_D2A.esp = FSM___ratio_D2A.esp + 4;
            FSM___ratio_D2A.esp = FSM___ratio_D2A.esp + 4;
            return;
         }
         _loc7_ = _loc7_ / _loc8_;
         FSM___ratio_D2A.st0 = _loc7_;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.ebp;
         FSM___ratio_D2A.ebp = op_li32(FSM___ratio_D2A.esp) /*Alchemy*/;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp + 4;
         FSM___ratio_D2A.esp = FSM___ratio_D2A.esp + 4;
      }
   }
}
