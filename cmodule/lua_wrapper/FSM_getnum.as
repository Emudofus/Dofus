package cmodule.lua_wrapper
{
   public final class FSM_getnum extends Machine
   {
      
      public function FSM_getnum() {
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
         FSM_getnum.esp = FSM_getnum.esp - 4;
         FSM_getnum.ebp = FSM_getnum.esp;
         FSM_getnum.esp = FSM_getnum.esp - 0;
         _loc1_ = op_li32(FSM_getnum.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_getnum.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM_getnum.ebp + 16) /*Alchemy*/;
         _loc4_ = op_li32(FSM_getnum.ebp + 20) /*Alchemy*/;
         _loc5_ = _loc1_;
         if(_loc1_ != 0)
         {
            _loc1_ = op_li8(_loc1_) /*Alchemy*/;
            _loc6_ = _loc1_ << 24;
            _loc6_ = _loc6_ >> 24;
            _loc6_ = _loc6_ + -48;
            if(uint(_loc6_) <= uint(9))
            {
               _loc6_ = 0;
               while(true)
               {
                  _loc1_ = _loc1_ << 24;
                  _loc1_ = _loc1_ >> 24;
                  _loc6_ = _loc6_ * 10;
                  _loc1_ = _loc6_ + _loc1_;
                  _loc1_ = _loc1_ + -48;
                  if(_loc1_ <= _loc4_)
                  {
                     _loc7_ = op_li8(_loc5_ + 1) /*Alchemy*/;
                     _loc5_ = _loc5_ + 1;
                     _loc6_ = _loc7_ << 24;
                     _loc6_ = _loc6_ >> 24;
                     _loc8_ = _loc5_;
                     _loc6_ = _loc6_ + -48;
                     if(uint(_loc6_) <= uint(9))
                     {
                        _loc5_ = _loc8_;
                        _loc6_ = _loc1_;
                        _loc1_ = _loc7_;
                        continue;
                     }
                     if(_loc1_ >= _loc3_)
                     {
                        FSM_getnum.eax = _loc5_;
                        FSM_getnum.esp = FSM_getnum.ebp;
                        FSM_getnum.ebp = op_li32(FSM_getnum.esp) /*Alchemy*/;
                        FSM_getnum.esp = FSM_getnum.esp + 4;
                        FSM_getnum.esp = FSM_getnum.esp + 4;
                        return;
                     }
                     break;
                  }
                  break;
               }
            }
         }
         _loc1_ = 0;
         FSM_getnum.eax = _loc1_;
         FSM_getnum.esp = FSM_getnum.ebp;
         FSM_getnum.ebp = op_li32(FSM_getnum.esp) /*Alchemy*/;
         FSM_getnum.esp = FSM_getnum.esp + 4;
         FSM_getnum.esp = FSM_getnum.esp + 4;
      }
   }
}
