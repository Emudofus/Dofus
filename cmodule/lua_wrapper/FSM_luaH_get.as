package cmodule.lua_wrapper
{
   public final class FSM_luaH_get extends Machine
   {
      
      public function FSM_luaH_get() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         FSM_luaH_get.esp = FSM_luaH_get.esp - 4;
         FSM_luaH_get.ebp = FSM_luaH_get.esp;
         FSM_luaH_get.esp = FSM_luaH_get.esp - 0;
         _loc1_ = op_li32(FSM_luaH_get.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM_luaH_get.ebp + 8) /*Alchemy*/;
         if(_loc2_ != 0)
         {
            if(_loc2_ != 3)
            {
               if(_loc2_ == 4)
               {
                  _loc2_ = 1;
                  _loc4_ = op_li8(_loc3_ + 7) /*Alchemy*/;
                  _loc2_ = _loc2_ << _loc4_;
                  _loc1_ = op_li32(_loc1_) /*Alchemy*/;
                  _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                  _loc2_ = _loc2_ + -1;
                  _loc2_ = _loc2_ & _loc4_;
                  _loc3_ = op_li32(_loc3_ + 16) /*Alchemy*/;
                  _loc2_ = _loc2_ * 28;
                  _loc3_ = _loc3_ + _loc2_;
                  while(true)
                  {
                     _loc2_ = op_li32(_loc3_ + 20) /*Alchemy*/;
                     if(_loc2_ == 4)
                     {
                        _loc2_ = op_li32(_loc3_ + 12) /*Alchemy*/;
                        if(_loc2_ == _loc1_)
                        {
                           FSM_luaH_get.eax = _loc3_;
                           FSM_luaH_get.esp = FSM_luaH_get.ebp;
                           FSM_luaH_get.ebp = op_li32(FSM_luaH_get.esp) /*Alchemy*/;
                           FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
                           FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
                           return;
                        }
                     }
                     _loc3_ = op_li32(_loc3_ + 24) /*Alchemy*/;
                     if(_loc3_ != 0)
                     {
                        continue;
                     }
                     break;
                  }
               }
               _loc1_ = FSM_luaH_get;
               FSM_luaH_get.eax = _loc1_;
               FSM_luaH_get.esp = FSM_luaH_get.ebp;
               FSM_luaH_get.ebp = op_li32(FSM_luaH_get.esp) /*Alchemy*/;
               FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
               FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
               return;
            }
            _loc5_ = op_lf64(_loc1_) /*Alchemy*/;
            _loc2_ = int(_loc5_);
            _loc6_ = Number(_loc2_);
            if(_loc6_ == _loc5_)
            {
               FSM_luaH_get.esp = FSM_luaH_get.esp - 8;
               FSM_luaH_get.esp = FSM_luaH_get.esp - 4;
               FSM_luaH_get.start();
               _loc1_ = FSM_luaH_get.eax;
               FSM_luaH_get.esp = FSM_luaH_get.esp + 8;
            }
            if(_loc6_ == _loc5_)
            {
               FSM_luaH_get.eax = _loc1_;
               FSM_luaH_get.esp = FSM_luaH_get.ebp;
               FSM_luaH_get.ebp = op_li32(FSM_luaH_get.esp) /*Alchemy*/;
               FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
               FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
               return;
            }
            FSM_luaH_get.eax = _loc1_;
            FSM_luaH_get.esp = FSM_luaH_get.ebp;
            FSM_luaH_get.ebp = op_li32(FSM_luaH_get.esp) /*Alchemy*/;
            FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
            FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
            return;
            FSM_luaH_get.esp = FSM_luaH_get.esp - 8;
            FSM_luaH_get.esp = FSM_luaH_get.esp - 4;
            FSM_luaH_get.start();
            _loc2_ = FSM_luaH_get.eax;
            FSM_luaH_get.esp = FSM_luaH_get.esp + 8;
            while(true)
            {
               FSM_luaH_get.esp = FSM_luaH_get.esp - 8;
               _loc3_ = _loc2_ + 12;
               FSM_luaH_get.esp = FSM_luaH_get.esp - 4;
               FSM_luaH_get.start();
               _loc3_ = FSM_luaH_get.eax;
               FSM_luaH_get.esp = FSM_luaH_get.esp + 8;
               if(_loc3_ != 0)
               {
                  FSM_luaH_get.eax = _loc2_;
                  break;
               }
               _loc2_ = op_li32(_loc2_ + 24) /*Alchemy*/;
               if(_loc2_ != 0)
               {
                  continue;
               }
            }
            FSM_luaH_get.esp = FSM_luaH_get.ebp;
            FSM_luaH_get.ebp = op_li32(FSM_luaH_get.esp) /*Alchemy*/;
            FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
            FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
            return;
         }
         if(_loc2_ != 0)
         {
            _loc1_ = FSM_luaH_get;
            FSM_luaH_get.eax = _loc1_;
            FSM_luaH_get.esp = FSM_luaH_get.ebp;
            FSM_luaH_get.ebp = op_li32(FSM_luaH_get.esp) /*Alchemy*/;
            FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
            FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
            return;
         }
         _loc1_ = FSM_luaH_get;
         FSM_luaH_get.eax = _loc1_;
         FSM_luaH_get.esp = FSM_luaH_get.ebp;
         FSM_luaH_get.ebp = op_li32(FSM_luaH_get.esp) /*Alchemy*/;
         FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
         FSM_luaH_get.esp = FSM_luaH_get.esp + 4;
      }
   }
}
