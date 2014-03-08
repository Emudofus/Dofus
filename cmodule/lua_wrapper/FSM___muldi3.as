package cmodule.lua_wrapper
{
   public final class FSM___muldi3 extends Machine
   {
      
      public function FSM___muldi3() {
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
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         FSM___muldi3.esp = FSM___muldi3.esp - 4;
         FSM___muldi3.ebp = FSM___muldi3.esp;
         FSM___muldi3.esp = FSM___muldi3.esp - 0;
         _loc1_ = 0;
         _loc1_ = op_li32(FSM___muldi3.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM___muldi3.ebp + 20) /*Alchemy*/;
         _loc3_ = op_li32(FSM___muldi3.ebp + 8) /*Alchemy*/;
         _loc4_ = _loc1_ >> 31;
         _loc5_ = op_li32(FSM___muldi3.ebp + 16) /*Alchemy*/;
         _loc6_ = _loc2_ >> 31;
         _loc3_ = __addc(_loc3_,_loc4_);
         _loc7_ = __adde(_loc1_,_loc4_);
         _loc5_ = __addc(_loc5_,_loc6_);
         _loc8_ = __adde(_loc2_,_loc6_);
         _loc1_ = _loc1_ >>> 31;
         _loc7_ = _loc7_ ^ _loc4_;
         _loc3_ = _loc3_ ^ _loc4_;
         _loc2_ = _loc2_ >>> 31;
         _loc4_ = _loc8_ ^ _loc6_;
         _loc5_ = _loc5_ ^ _loc6_;
         _loc6_ = _loc7_;
         _loc8_ = _loc7_;
         if(_loc7_ == 0)
         {
            if(_loc4_ == 0)
            {
               FSM___muldi3.esp = FSM___muldi3.esp - 8;
               FSM___muldi3.esp = FSM___muldi3.esp - 4;
               FSM___muldi3.start();
               _loc3_ = FSM___muldi3.eax;
               _loc4_ = FSM___muldi3.edx;
               FSM___muldi3.esp = FSM___muldi3.esp + 8;
               if(_loc1_ != _loc2_)
               {
                  _loc1_ = 0;
                  _loc3_ = __subc(_loc1_,_loc3_);
                  _loc4_ = __sube(_loc1_,_loc4_);
                  FSM___muldi3.edx = _loc4_;
                  FSM___muldi3.eax = _loc3_;
               }
               FSM___muldi3.esp = FSM___muldi3.ebp;
               FSM___muldi3.ebp = op_li32(FSM___muldi3.esp) /*Alchemy*/;
               FSM___muldi3.esp = FSM___muldi3.esp + 4;
               FSM___muldi3.esp = FSM___muldi3.esp + 4;
               return;
            }
            if(_loc4_ == 0)
            {
               _loc1_ = _loc3_;
               _loc2_ = _loc4_;
               FSM___muldi3.edx = _loc2_;
               FSM___muldi3.eax = _loc1_;
               FSM___muldi3.esp = FSM___muldi3.ebp;
               FSM___muldi3.ebp = op_li32(FSM___muldi3.esp) /*Alchemy*/;
               FSM___muldi3.esp = FSM___muldi3.esp + 4;
               FSM___muldi3.esp = FSM___muldi3.esp + 4;
               return;
            }
            _loc1_ = _loc3_;
            _loc2_ = _loc4_;
            FSM___muldi3.edx = _loc2_;
            FSM___muldi3.eax = _loc1_;
            FSM___muldi3.esp = FSM___muldi3.ebp;
            FSM___muldi3.ebp = op_li32(FSM___muldi3.esp) /*Alchemy*/;
            FSM___muldi3.esp = FSM___muldi3.esp + 4;
            FSM___muldi3.esp = FSM___muldi3.esp + 4;
            return;
         }
         _loc7_ = uint(_loc5_) < uint(_loc4_)?_loc5_:_loc4_;
         _loc9_ = uint(_loc5_) < uint(_loc4_)?_loc4_:_loc5_;
         _loc10_ = uint(_loc6_) < uint(_loc3_)?_loc8_:_loc3_;
         _loc8_ = uint(_loc6_) < uint(_loc3_)?_loc3_:_loc8_;
         _loc11_ = uint(_loc5_) < uint(_loc4_)?1:0;
         _loc12_ = uint(_loc6_) < uint(_loc3_)?1:0;
         _loc7_ = _loc9_ - _loc7_;
         _loc8_ = _loc8_ - _loc10_;
         FSM___muldi3.esp = FSM___muldi3.esp - 8;
         _loc9_ = _loc11_ ^ _loc12_;
         _loc7_ = _loc7_ * _loc8_;
         _loc3_ = _loc9_ & 1;
         _loc5_ = 0 - _loc7_;
         _loc3_ = _loc3_ != 0?_loc5_:_loc7_;
         _loc4_ = _loc4_ * _loc6_;
         FSM___muldi3.esp = FSM___muldi3.esp - 4;
         FSM___muldi3.start();
         _loc5_ = FSM___muldi3.eax;
         _loc6_ = FSM___muldi3.edx;
         _loc3_ = _loc3_ + _loc4_;
         _loc3_ = _loc3_ + _loc5_;
         FSM___muldi3.esp = FSM___muldi3.esp + 8;
         _loc4_ = _loc3_ + _loc6_;
         if(_loc1_ != _loc2_)
         {
            _loc3_ = _loc5_;
            _loc1_ = 0;
            _loc3_ = __subc(_loc1_,_loc3_);
            _loc4_ = __sube(_loc1_,_loc4_);
            FSM___muldi3.edx = _loc4_;
            FSM___muldi3.eax = _loc3_;
         }
         else
         {
            _loc3_ = _loc5_;
            _loc1_ = _loc3_;
            _loc2_ = _loc4_;
            FSM___muldi3.edx = _loc2_;
            FSM___muldi3.eax = _loc1_;
         }
         FSM___muldi3.esp = FSM___muldi3.ebp;
         FSM___muldi3.ebp = op_li32(FSM___muldi3.esp) /*Alchemy*/;
         FSM___muldi3.esp = FSM___muldi3.esp + 4;
         FSM___muldi3.esp = FSM___muldi3.esp + 4;
      }
   }
}
