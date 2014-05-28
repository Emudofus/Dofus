package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public class FSM__longjmp extends Machine
   {
      
      public function FSM__longjmp() {
         super();
      }
      
      public static function start() : void {
         FSM__longjmp.gworker = new FSM__longjmp();
         throw new AlchemyDispatch();
      }
      
      override public function work() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:Machine = null;
         mstate.pop();
         _loc1_ = _mr32(mstate.esp);
         _loc2_ = _mr32(mstate.esp + 4);
         log(4,"longjmp: " + _loc1_);
         _loc3_ = _mr32(_loc1_ + 4);
         _loc4_ = _mr32(_loc1_ + 8);
         _loc5_ = _mr32(_loc1_ + 12);
         log(3,"longjmp -- buf: " + _loc1_ + " state: " + _loc3_ + " esp: " + _loc4_ + " ebp: " + _loc5_);
         if(!_loc1_ || !_loc4_ || !_loc5_)
         {
            throw "longjmp -- bad jmp_buf";
         }
         else
         {
            _loc6_ = findMachineForESP(_loc4_);
            if(!_loc6_)
            {
               debugTraceMem(_loc1_ - 24,_loc1_ + 24);
               throw "longjmp -- bad esp";
            }
            else
            {
               delete FSM__longjmp[[_loc6_]];
               mstate.gworker = _loc6_;
               _loc6_.state = _loc3_;
               mstate.esp = _loc4_;
               mstate.ebp = _loc5_;
               mstate.eax = _loc2_;
               throw new AlchemyDispatch();
            }
         }
      }
   }
}
