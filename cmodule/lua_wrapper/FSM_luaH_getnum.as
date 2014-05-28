package cmodule.lua_wrapper
{
   public final class FSM_luaH_getnum extends Machine
   {
      
      public function FSM_luaH_getnum() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         FSM_luaH_getnum.esp = FSM_luaH_getnum.esp - 4;
         FSM_luaH_getnum.ebp = FSM_luaH_getnum.esp;
         FSM_luaH_getnum.esp = FSM_luaH_getnum.esp - 8;
         _loc1_ = op_li32(FSM_luaH_getnum.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM_luaH_getnum.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(_loc2_ + 28) /*Alchemy*/;
         _loc4_ = _loc1_ + -1;
         if(uint(_loc4_) < uint(_loc3_))
         {
            _loc1_ = op_li32(_loc2_ + 12) /*Alchemy*/;
            _loc2_ = _loc4_ * 12;
            _loc1_ = _loc1_ + _loc2_;
         }
         else
         {
            _loc6_ = 0;
            _loc7_ = Number(_loc1_);
            _loc1_ = op_li32(FSM_luaH_getnum.ebp + -8) /*Alchemy*/;
            _loc3_ = op_li32(FSM_luaH_getnum.ebp + -4) /*Alchemy*/;
            if(_loc7_ == _loc6_)
            {
               _loc1_ = op_li32(_loc2_ + 16) /*Alchemy*/;
            }
            else
            {
               _loc4_ = 1;
               _loc5_ = op_li8(_loc2_ + 7) /*Alchemy*/;
               _loc4_ = _loc4_ << _loc5_;
               _loc4_ = _loc4_ + -1;
               _loc4_ = _loc4_ | 1;
               _loc1_ = _loc3_ + _loc1_;
               _loc1_ = uint(_loc1_) % uint(_loc4_);
               _loc2_ = op_li32(_loc2_ + 16) /*Alchemy*/;
               _loc1_ = _loc1_ * 28;
               _loc1_ = _loc2_ + _loc1_;
            }
            while(true)
            {
               _loc2_ = op_li32(_loc1_ + 20) /*Alchemy*/;
               if(_loc2_ == 3)
               {
                  _loc6_ = op_lf64(_loc1_ + 12) /*Alchemy*/;
                  if(_loc6_ == _loc7_)
                  {
                  }
               }
               _loc1_ = op_li32(_loc1_ + 24) /*Alchemy*/;
               if(_loc1_ != 0)
               {
                  continue;
               }
               break;
            }
            _loc1_ = FSM_luaH_getnum;
         }
         if(uint(_loc4_) < uint(_loc3_))
         {
            FSM_luaH_getnum.eax = _loc1_;
            FSM_luaH_getnum.esp = FSM_luaH_getnum.ebp;
            FSM_luaH_getnum.ebp = op_li32(FSM_luaH_getnum.esp) /*Alchemy*/;
            FSM_luaH_getnum.esp = FSM_luaH_getnum.esp + 4;
            FSM_luaH_getnum.esp = FSM_luaH_getnum.esp + 4;
            return;
         }
         FSM_luaH_getnum.eax = _loc1_;
         FSM_luaH_getnum.esp = FSM_luaH_getnum.ebp;
         FSM_luaH_getnum.ebp = op_li32(FSM_luaH_getnum.esp) /*Alchemy*/;
         FSM_luaH_getnum.esp = FSM_luaH_getnum.esp + 4;
         FSM_luaH_getnum.esp = FSM_luaH_getnum.esp + 4;
      }
   }
}
