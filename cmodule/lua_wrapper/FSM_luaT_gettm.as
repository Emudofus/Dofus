package cmodule.lua_wrapper
{
   public final class FSM_luaT_gettm extends Machine
   {
      
      public function FSM_luaT_gettm() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM_luaT_gettm.esp = FSM_luaT_gettm.esp - 4;
         FSM_luaT_gettm.ebp = FSM_luaT_gettm.esp;
         FSM_luaT_gettm.esp = FSM_luaT_gettm.esp - 0;
         _loc1_ = 1;
         _loc2_ = op_li32(FSM_luaT_gettm.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li8(_loc2_ + 7) /*Alchemy*/;
         _loc1_ = _loc1_ << _loc3_;
         _loc3_ = op_li32(FSM_luaT_gettm.ebp + 16) /*Alchemy*/;
         _loc4_ = op_li32(_loc3_ + 8) /*Alchemy*/;
         _loc1_ = _loc1_ + -1;
         _loc1_ = _loc1_ & _loc4_;
         _loc4_ = op_li32(_loc2_ + 16) /*Alchemy*/;
         _loc1_ = _loc1_ * 28;
         _loc5_ = op_li32(FSM_luaT_gettm.ebp + 12) /*Alchemy*/;
         _loc1_ = _loc4_ + _loc1_;
         while(true)
         {
            _loc4_ = op_li32(_loc1_ + 20) /*Alchemy*/;
            if(_loc4_ == 4)
            {
               _loc4_ = op_li32(_loc1_ + 12) /*Alchemy*/;
               if(_loc4_ == _loc3_)
               {
                  _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                  if(_loc3_ == 0)
                  {
                     _loc1_ = 1;
                     _loc3_ = op_li8(_loc2_ + 6) /*Alchemy*/;
                     _loc1_ = _loc1_ << _loc5_;
                     _loc1_ = _loc3_ | _loc1_;
                     _loc1_ = 0;
                  }
                  if(_loc3_ == 0)
                  {
                     FSM_luaT_gettm.eax = _loc1_;
                     FSM_luaT_gettm.esp = FSM_luaT_gettm.ebp;
                     FSM_luaT_gettm.ebp = op_li32(FSM_luaT_gettm.esp) /*Alchemy*/;
                     FSM_luaT_gettm.esp = FSM_luaT_gettm.esp + 4;
                     FSM_luaT_gettm.esp = FSM_luaT_gettm.esp + 4;
                     return;
                  }
                  FSM_luaT_gettm.eax = _loc1_;
                  FSM_luaT_gettm.esp = FSM_luaT_gettm.ebp;
                  FSM_luaT_gettm.ebp = op_li32(FSM_luaT_gettm.esp) /*Alchemy*/;
                  FSM_luaT_gettm.esp = FSM_luaT_gettm.esp + 4;
                  FSM_luaT_gettm.esp = FSM_luaT_gettm.esp + 4;
                  return;
               }
            }
            _loc1_ = op_li32(_loc1_ + 24) /*Alchemy*/;
            if(_loc1_ != 0)
            {
               continue;
            }
            break;
         }
         _loc1_ = FSM_luaT_gettm;
         _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         if(_loc3_ == 0)
         {
            _loc1_ = 1;
            _loc3_ = op_li8(_loc2_ + 6) /*Alchemy*/;
            _loc1_ = _loc1_ << _loc5_;
            _loc1_ = _loc3_ | _loc1_;
            _loc1_ = 0;
         }
         if(_loc3_ == 0)
         {
            FSM_luaT_gettm.eax = _loc1_;
            FSM_luaT_gettm.esp = FSM_luaT_gettm.ebp;
            FSM_luaT_gettm.ebp = op_li32(FSM_luaT_gettm.esp) /*Alchemy*/;
            FSM_luaT_gettm.esp = FSM_luaT_gettm.esp + 4;
            FSM_luaT_gettm.esp = FSM_luaT_gettm.esp + 4;
            return;
         }
         FSM_luaT_gettm.eax = _loc1_;
         FSM_luaT_gettm.esp = FSM_luaT_gettm.ebp;
         FSM_luaT_gettm.ebp = op_li32(FSM_luaT_gettm.esp) /*Alchemy*/;
         FSM_luaT_gettm.esp = FSM_luaT_gettm.esp + 4;
         FSM_luaT_gettm.esp = FSM_luaT_gettm.esp + 4;
      }
   }
}
