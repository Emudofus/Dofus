package cmodule.lua_wrapper
{
   public final class FSM_lua_setmetatable extends Machine
   {
      
      public function FSM_lua_setmetatable() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp - 4;
         FSM_lua_setmetatable.ebp = FSM_lua_setmetatable.esp;
         FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp - 0;
         _loc1_ = op_li32(FSM_lua_setmetatable.ebp + 8) /*Alchemy*/;
         FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp - 8;
         _loc2_ = op_li32(FSM_lua_setmetatable.ebp + 12) /*Alchemy*/;
         FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp - 4;
         FSM_lua_setmetatable.start();
         _loc2_ = FSM_lua_setmetatable.eax;
         FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 8;
         _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc4_ = op_li32(_loc3_ + -4) /*Alchemy*/;
         _loc5_ = _loc1_ + 8;
         if(_loc4_ == 0)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = op_li32(_loc3_ + -12) /*Alchemy*/;
         }
         _loc4_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         if(_loc4_ != 7)
         {
            if(_loc4_ == 5)
            {
               _loc4_ = op_li32(_loc2_) /*Alchemy*/;
               if(_loc3_ != 0)
               {
                  _loc3_ = op_li8(_loc3_ + 5) /*Alchemy*/;
                  _loc3_ = _loc3_ & 3;
                  if(_loc3_ != 0)
                  {
                     _loc2_ = op_li32(_loc2_) /*Alchemy*/;
                     _loc3_ = op_li8(_loc2_ + 5) /*Alchemy*/;
                     _loc4_ = _loc2_ + 5;
                     _loc6_ = _loc3_ & 4;
                     if(_loc6_ != 0)
                     {
                        _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
                        _loc3_ = _loc3_ & -5;
                        _loc3_ = op_li32(_loc1_ + 40) /*Alchemy*/;
                     }
                     if(_loc6_ != 0)
                     {
                        _loc1_ = op_li32(_loc5_) /*Alchemy*/;
                        _loc1_ = _loc1_ + -12;
                        FSM_lua_setmetatable.esp = FSM_lua_setmetatable.ebp;
                        FSM_lua_setmetatable.ebp = op_li32(FSM_lua_setmetatable.esp) /*Alchemy*/;
                        FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
                        FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
                        return;
                     }
                     _loc1_ = op_li32(_loc5_) /*Alchemy*/;
                     _loc1_ = _loc1_ + -12;
                     FSM_lua_setmetatable.esp = FSM_lua_setmetatable.ebp;
                     FSM_lua_setmetatable.ebp = op_li32(FSM_lua_setmetatable.esp) /*Alchemy*/;
                     FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
                     FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
                     return;
                  }
               }
            }
            else
            {
               _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
               _loc2_ = _loc4_ << 2;
               _loc1_ = _loc1_ + _loc2_;
            }
         }
         else
         {
            _loc4_ = op_li32(_loc2_) /*Alchemy*/;
            _loc4_ = _loc2_;
            if(_loc3_ != 0)
            {
               _loc2_ = op_li8(_loc3_ + 5) /*Alchemy*/;
               _loc2_ = _loc2_ & 3;
               if(_loc2_ != 0)
               {
                  _loc4_ = op_li32(_loc4_) /*Alchemy*/;
                  _loc2_ = op_li8(_loc4_ + 5) /*Alchemy*/;
                  _loc4_ = _loc4_ + 5;
                  _loc6_ = _loc2_ & 4;
                  if(_loc6_ != 0)
                  {
                     _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
                     _loc6_ = op_li8(_loc1_ + 21) /*Alchemy*/;
                     if(_loc6_ == 1)
                     {
                        FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp - 8;
                        FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp - 4;
                        FSM_lua_setmetatable.start();
                        FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 8;
                     }
                     else
                     {
                        _loc1_ = op_li8(_loc1_ + 20) /*Alchemy*/;
                        _loc3_ = _loc2_ & -8;
                        _loc1_ = _loc1_ & 3;
                        _loc1_ = _loc1_ | _loc3_;
                     }
                     if(_loc6_ == 1)
                     {
                     }
                  }
                  _loc1_ = op_li32(_loc5_) /*Alchemy*/;
                  _loc1_ = _loc1_ + -12;
                  FSM_lua_setmetatable.esp = FSM_lua_setmetatable.ebp;
                  FSM_lua_setmetatable.ebp = op_li32(FSM_lua_setmetatable.esp) /*Alchemy*/;
                  FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
                  FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
                  return;
               }
               if(_loc2_ != 0)
               {
               }
            }
         }
         if(_loc4_ != 7)
         {
            _loc1_ = op_li32(_loc5_) /*Alchemy*/;
            _loc1_ = _loc1_ + -12;
            FSM_lua_setmetatable.esp = FSM_lua_setmetatable.ebp;
            FSM_lua_setmetatable.ebp = op_li32(FSM_lua_setmetatable.esp) /*Alchemy*/;
            FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
            FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
            return;
         }
         _loc1_ = op_li32(_loc5_) /*Alchemy*/;
         _loc1_ = _loc1_ + -12;
         FSM_lua_setmetatable.esp = FSM_lua_setmetatable.ebp;
         FSM_lua_setmetatable.ebp = op_li32(FSM_lua_setmetatable.esp) /*Alchemy*/;
         FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
         FSM_lua_setmetatable.esp = FSM_lua_setmetatable.esp + 4;
      }
   }
}
