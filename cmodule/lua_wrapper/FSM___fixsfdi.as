package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM___fixsfdi extends Machine
   {
      
      public function FSM___fixsfdi() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         FSM___fixsfdi.esp = FSM___fixsfdi.esp - 4;
         FSM___fixsfdi.ebp = FSM___fixsfdi.esp;
         FSM___fixsfdi.esp = FSM___fixsfdi.esp - 0;
         _loc4_ = 0;
         _loc5_ = op_lf32(FSM___fixsfdi.ebp + 8) /*Alchemy*/;
         _loc4_ = _loc4_;
         _loc4_ = _loc4_;
         _loc6_ = _loc5_;
         if(_loc6_ < _loc4_)
         {
            _loc4_ = -9.22337E18;
            _loc4_ = _loc4_;
            _loc4_ = _loc4_;
            _loc6_ = _loc5_;
            if(_loc6_ <= _loc4_)
            {
               _loc1_ = -2147483648;
               _loc2_ = 0;
            }
            else
            {
               _loc1_ = 0;
               _loc4_ = _loc5_;
               _loc4_ = -_loc4_;
               FSM___fixsfdi.esp = FSM___fixsfdi.esp - 4;
               _loc5_ = _loc4_;
               FSM___fixsfdi.esp = FSM___fixsfdi.esp - 4;
               FSM___fixsfdi.funcs[FSM___fixsfdi]();
               _loc2_ = FSM___fixsfdi.eax;
               _loc3_ = FSM___fixsfdi.edx;
               FSM___fixsfdi.esp = FSM___fixsfdi.esp + 4;
               _loc2_ = __subc(_loc1_,_loc2_);
               _loc1_ = __sube(_loc1_,_loc3_);
            }
            if(_loc6_ <= _loc4_)
            {
               FSM___fixsfdi.edx = _loc1_;
               FSM___fixsfdi.eax = _loc2_;
            }
            else
            {
               FSM___fixsfdi.edx = _loc1_;
               FSM___fixsfdi.eax = _loc2_;
            }
         }
         else
         {
            _loc4_ = 9.22337E18;
            _loc4_ = _loc4_;
            _loc4_ = _loc4_;
            _loc6_ = _loc5_;
            if(_loc6_ >= _loc4_)
            {
               _loc1_ = 2147483647;
               _loc2_ = -1;
               FSM___fixsfdi.edx = _loc1_;
               FSM___fixsfdi.eax = _loc2_;
            }
            else
            {
               FSM___fixsfdi.esp = FSM___fixsfdi.esp - 4;
               FSM___fixsfdi.esp = FSM___fixsfdi.esp - 4;
               FSM___fixsfdi.funcs[FSM___fixsfdi]();
               _loc1_ = FSM___fixsfdi.eax;
               _loc2_ = FSM___fixsfdi.edx;
               FSM___fixsfdi.esp = FSM___fixsfdi.esp + 4;
               FSM___fixsfdi.edx = _loc2_;
               FSM___fixsfdi.eax = _loc1_;
            }
            if(_loc6_ >= _loc4_)
            {
            }
         }
         FSM___fixsfdi.esp = FSM___fixsfdi.ebp;
         FSM___fixsfdi.ebp = op_li32(FSM___fixsfdi.esp) /*Alchemy*/;
         FSM___fixsfdi.esp = FSM___fixsfdi.esp + 4;
         FSM___fixsfdi.esp = FSM___fixsfdi.esp + 4;
      }
   }
}
