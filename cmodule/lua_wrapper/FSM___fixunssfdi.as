package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM___fixunssfdi extends Machine
   {
      
      public function FSM___fixunssfdi() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         FSM___fixunssfdi.esp = FSM___fixunssfdi.esp - 4;
         FSM___fixunssfdi.ebp = FSM___fixunssfdi.esp;
         FSM___fixunssfdi.esp = FSM___fixunssfdi.esp - 0;
         _loc5_ = 1.84467E19;
         _loc6_ = op_lf32(FSM___fixunssfdi.ebp + 8) /*Alchemy*/;
         _loc5_ = _loc5_;
         _loc5_ = _loc5_;
         _loc7_ = _loc6_;
         if(_loc7_ < _loc5_)
         {
            _loc5_ = 0;
            _loc5_ = _loc5_;
            _loc5_ = _loc5_;
            _loc7_ = _loc6_;
            if(_loc7_ >= _loc5_)
            {
               _loc1_ = 0;
               _loc5_ = _loc6_;
               _loc6_ = _loc5_ + -2147480000;
               _loc6_ = _loc6_ * 2.32831E-10;
               FSM___fixunssfdi.esp = FSM___fixunssfdi.esp - 8;
               _loc2_ = uint(_loc6_);
               FSM___fixunssfdi.esp = FSM___fixunssfdi.esp - 4;
               FSM___fixunssfdi.funcs[FSM___fixunssfdi]();
               _loc6_ = FSM___fixunssfdi.st0;
               _loc5_ = _loc5_ - _loc6_;
               _loc6_ = 0;
               _loc7_ = _loc5_ + 4.29497E9;
               _loc7_ = _loc5_ < _loc6_?_loc7_:_loc5_;
               _loc3_ = _loc2_ + -1;
               _loc8_ = 4.29497E9;
               _loc9_ = _loc7_ - 4.29497E9;
               _loc9_ = _loc7_ > _loc8_?_loc9_:_loc7_;
               _loc2_ = _loc5_ >= _loc6_?_loc2_:_loc3_;
               _loc1_ = _loc5_ >= _loc6_?0:_loc1_;
               _loc3_ = _loc2_ + 1;
               _loc1_ = _loc7_ <= _loc8_?_loc1_:_loc1_;
               _loc4_ = uint(_loc9_);
               FSM___fixunssfdi.esp = FSM___fixunssfdi.esp + 8;
               _loc1_ = _loc1_ | _loc4_;
               _loc2_ = _loc7_ <= _loc8_?_loc2_:_loc3_;
               FSM___fixunssfdi.edx = _loc2_;
            }
            if(_loc7_ >= _loc5_)
            {
               FSM___fixunssfdi.eax = _loc1_;
               FSM___fixunssfdi.esp = FSM___fixunssfdi.ebp;
               FSM___fixunssfdi.ebp = op_li32(FSM___fixunssfdi.esp) /*Alchemy*/;
               FSM___fixunssfdi.esp = FSM___fixunssfdi.esp + 4;
               FSM___fixunssfdi.esp = FSM___fixunssfdi.esp + 4;
               return;
            }
            FSM___fixunssfdi.eax = _loc1_;
            FSM___fixunssfdi.esp = FSM___fixunssfdi.ebp;
            FSM___fixunssfdi.ebp = op_li32(FSM___fixunssfdi.esp) /*Alchemy*/;
            FSM___fixunssfdi.esp = FSM___fixunssfdi.esp + 4;
            FSM___fixunssfdi.esp = FSM___fixunssfdi.esp + 4;
            return;
         }
         _loc1_ = -1;
         FSM___fixunssfdi.edx = _loc1_;
         FSM___fixunssfdi.eax = _loc1_;
         FSM___fixunssfdi.esp = FSM___fixunssfdi.ebp;
         FSM___fixunssfdi.ebp = op_li32(FSM___fixunssfdi.esp) /*Alchemy*/;
         FSM___fixunssfdi.esp = FSM___fixunssfdi.esp + 4;
         FSM___fixunssfdi.esp = FSM___fixunssfdi.esp + 4;
      }
   }
}
