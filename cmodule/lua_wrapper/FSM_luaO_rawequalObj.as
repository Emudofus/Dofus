package cmodule.lua_wrapper
{
   public final class FSM_luaO_rawequalObj extends Machine
   {
      
      public function FSM_luaO_rawequalObj() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         FSM_luaO_rawequalObj.esp = FSM_luaO_rawequalObj.esp - 4;
         FSM_luaO_rawequalObj.ebp = FSM_luaO_rawequalObj.esp;
         FSM_luaO_rawequalObj.esp = FSM_luaO_rawequalObj.esp - 0;
         _loc1_ = op_li32(FSM_luaO_rawequalObj.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_luaO_rawequalObj.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc4_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         if(_loc3_ != _loc4_)
         {
            _loc1_ = 0;
         }
         else
         {
            if(_loc3_ <= 1)
            {
               if(_loc3_ != 0)
               {
                  if(_loc3_ != 1)
                  {
                  }
                  _loc1_ = op_li32(_loc1_) /*Alchemy*/;
                  _loc2_ = op_li32(_loc2_) /*Alchemy*/;
                  _loc1_ = _loc1_ == _loc2_?1:0;
                  _loc1_ = _loc1_ & 1;
               }
               else
               {
                  _loc1_ = 1;
               }
            }
            else
            {
               if(_loc3_ != 2)
               {
                  if(_loc3_ == 3)
                  {
                     _loc5_ = op_lf64(_loc1_) /*Alchemy*/;
                     _loc6_ = op_lf64(_loc2_) /*Alchemy*/;
                     _loc1_ = _loc5_ == _loc6_?1:0;
                  }
                  _loc1_ = _loc1_ & 1;
               }
            }
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            _loc2_ = op_li32(_loc2_) /*Alchemy*/;
            _loc1_ = _loc1_ == _loc2_?1:0;
            _loc1_ = _loc1_ & 1;
         }
         FSM_luaO_rawequalObj.eax = _loc1_;
         FSM_luaO_rawequalObj.esp = FSM_luaO_rawequalObj.ebp;
         FSM_luaO_rawequalObj.ebp = op_li32(FSM_luaO_rawequalObj.esp) /*Alchemy*/;
         FSM_luaO_rawequalObj.esp = FSM_luaO_rawequalObj.esp + 4;
         FSM_luaO_rawequalObj.esp = FSM_luaO_rawequalObj.esp + 4;
      }
   }
}
