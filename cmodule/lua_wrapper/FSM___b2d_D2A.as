package cmodule.lua_wrapper
{
   public final class FSM___b2d_D2A extends Machine
   {
      
      public function FSM___b2d_D2A() {
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
         var _loc10_:* = 0;
         var _loc11_:* = NaN;
         FSM___b2d_D2A.esp = FSM___b2d_D2A.esp - 4;
         FSM___b2d_D2A.ebp = FSM___b2d_D2A.esp;
         FSM___b2d_D2A.esp = FSM___b2d_D2A.esp - 8;
         _loc1_ = op_li32(FSM___b2d_D2A.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 16) /*Alchemy*/;
         _loc3_ = _loc2_ + -1;
         _loc4_ = _loc3_ << 2;
         _loc5_ = _loc1_ + 20;
         _loc4_ = _loc5_ + _loc4_;
         _loc6_ = op_li32(_loc4_) /*Alchemy*/;
         _loc7_ = uint(_loc6_) < uint(65536)?16:0;
         _loc8_ = _loc6_ << _loc7_;
         _loc9_ = uint(_loc8_) < uint(16777216)?8:0;
         _loc8_ = _loc8_ << _loc9_;
         _loc10_ = uint(_loc8_) < uint(268435456)?4:0;
         _loc7_ = _loc9_ | _loc7_;
         _loc8_ = _loc8_ << _loc10_;
         _loc9_ = uint(_loc8_) < uint(1073741824)?2:0;
         _loc7_ = _loc7_ | _loc10_;
         _loc7_ = _loc7_ | _loc9_;
         _loc8_ = _loc8_ << _loc9_;
         _loc9_ = op_li32(FSM___b2d_D2A.ebp + 12) /*Alchemy*/;
         if(_loc8_ > -1)
         {
            _loc8_ = _loc8_ & 1073741824;
            _loc7_ = _loc7_ + 1;
            _loc7_ = _loc8_ == 0?32:_loc7_;
         }
         _loc8_ = 32 - _loc7_;
         if(_loc7_ <= 10)
         {
            _loc4_ = _loc7_ + 21;
            _loc5_ = 11 - _loc7_;
            _loc4_ = _loc6_ << _loc4_;
            _loc6_ = _loc6_ >>> _loc5_;
            if(_loc3_ <= 0)
            {
               _loc5_ = _loc6_;
            }
            else
            {
               _loc2_ = _loc2_ << 2;
               _loc1_ = _loc2_ + _loc1_;
               _loc1_ = op_li32(_loc1_ + 12) /*Alchemy*/;
               _loc5_ = _loc1_ >>> _loc5_;
               _loc4_ = _loc5_ | _loc4_;
               _loc5_ = _loc6_;
            }
         }
         else
         {
            if(_loc3_ <= 0)
            {
               _loc1_ = 0;
               _loc2_ = _loc4_;
            }
            else
            {
               _loc2_ = _loc2_ << 2;
               _loc1_ = _loc2_ + _loc1_;
               _loc4_ = op_li32(_loc1_ + 12) /*Alchemy*/;
               _loc1_ = _loc1_ + 12;
               _loc2_ = _loc1_;
               _loc1_ = _loc4_;
            }
            _loc4_ = _loc2_;
            _loc2_ = _loc7_ + -11;
            if(_loc7_ == 11)
            {
               _loc5_ = _loc6_;
               _loc4_ = _loc1_;
            }
            else
            {
               _loc3_ = 43 - _loc7_;
               _loc7_ = _loc1_ >>> _loc3_;
               _loc6_ = _loc6_ << _loc2_;
               _loc6_ = _loc7_ | _loc6_;
               if(uint(_loc4_) <= uint(_loc5_))
               {
                  _loc4_ = 0;
               }
               else
               {
                  _loc4_ = op_li32(_loc4_ + -4) /*Alchemy*/;
               }
               _loc4_ = _loc4_ >>> _loc3_;
               _loc5_ = _loc1_ << _loc2_;
               _loc4_ = _loc4_ | _loc5_;
               _loc5_ = _loc6_;
            }
         }
         _loc1_ = _loc5_;
         _loc2_ = _loc4_;
         _loc1_ = _loc1_ | 1072693248;
         _loc11_ = op_lf64(FSM___b2d_D2A.ebp + -8) /*Alchemy*/;
         FSM___b2d_D2A.st0 = _loc11_;
         FSM___b2d_D2A.esp = FSM___b2d_D2A.ebp;
         FSM___b2d_D2A.ebp = op_li32(FSM___b2d_D2A.esp) /*Alchemy*/;
         FSM___b2d_D2A.esp = FSM___b2d_D2A.esp + 4;
         FSM___b2d_D2A.esp = FSM___b2d_D2A.esp + 4;
      }
   }
}
