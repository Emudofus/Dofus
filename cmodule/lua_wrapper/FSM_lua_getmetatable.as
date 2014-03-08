package cmodule.lua_wrapper
{
   public final class FSM_lua_getmetatable extends Machine
   {
      
      public function FSM_lua_getmetatable() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp - 4;
         FSM_lua_getmetatable.ebp = FSM_lua_getmetatable.esp;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp - 0;
         _loc1_ = op_li32(FSM_lua_getmetatable.ebp + 8) /*Alchemy*/;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp - 8;
         _loc2_ = op_li32(FSM_lua_getmetatable.ebp + 12) /*Alchemy*/;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp - 4;
         FSM_lua_getmetatable.start();
         _loc2_ = FSM_lua_getmetatable.eax;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 8;
         _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         if(_loc3_ != 7)
         {
            if(_loc3_ == 5)
            {
               _loc2_ = op_li32(_loc2_) /*Alchemy*/;
               _loc2_ = op_li32(_loc2_ + 8) /*Alchemy*/;
               if(_loc2_ != 0)
               {
                  _loc3_ = 5;
                  _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                  _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                  _loc2_ = _loc2_ + 12;
                  _loc1_ = 1;
               }
               if(_loc2_ != 0)
               {
                  FSM_lua_getmetatable.eax = _loc1_;
                  FSM_lua_getmetatable.esp = FSM_lua_getmetatable.ebp;
                  FSM_lua_getmetatable.ebp = op_li32(FSM_lua_getmetatable.esp) /*Alchemy*/;
                  FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
                  FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
                  return;
               }
               FSM_lua_getmetatable.eax = _loc1_;
               FSM_lua_getmetatable.esp = FSM_lua_getmetatable.ebp;
               FSM_lua_getmetatable.ebp = op_li32(FSM_lua_getmetatable.esp) /*Alchemy*/;
               FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
               FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
               return;
            }
            _loc2_ = op_li32(_loc1_ + 16) /*Alchemy*/;
            _loc3_ = _loc3_ << 2;
            _loc2_ = _loc2_ + _loc3_;
            _loc2_ = op_li32(_loc2_ + 132) /*Alchemy*/;
            if(_loc2_ != 0)
            {
               _loc3_ = 5;
               _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               _loc2_ = _loc2_ + 12;
               _loc1_ = 1;
            }
            if(_loc2_ != 0)
            {
               FSM_lua_getmetatable.eax = _loc1_;
               FSM_lua_getmetatable.esp = FSM_lua_getmetatable.ebp;
               FSM_lua_getmetatable.ebp = op_li32(FSM_lua_getmetatable.esp) /*Alchemy*/;
               FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
               FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
               return;
            }
            FSM_lua_getmetatable.eax = _loc1_;
            FSM_lua_getmetatable.esp = FSM_lua_getmetatable.ebp;
            FSM_lua_getmetatable.ebp = op_li32(FSM_lua_getmetatable.esp) /*Alchemy*/;
            FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
            FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
            return;
         }
         _loc2_ = op_li32(_loc2_) /*Alchemy*/;
         _loc2_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         if(_loc2_ != 0)
         {
            _loc3_ = 5;
            _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc2_ = _loc2_ + 12;
            _loc1_ = 1;
         }
         if(_loc2_ != 0)
         {
            FSM_lua_getmetatable.eax = _loc1_;
            FSM_lua_getmetatable.esp = FSM_lua_getmetatable.ebp;
            FSM_lua_getmetatable.ebp = op_li32(FSM_lua_getmetatable.esp) /*Alchemy*/;
            FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
            FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
            return;
         }
         FSM_lua_getmetatable.eax = _loc1_;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.ebp;
         FSM_lua_getmetatable.ebp = op_li32(FSM_lua_getmetatable.esp) /*Alchemy*/;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
         return;
         _loc1_ = 0;
         FSM_lua_getmetatable.eax = _loc1_;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.ebp;
         FSM_lua_getmetatable.ebp = op_li32(FSM_lua_getmetatable.esp) /*Alchemy*/;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
         FSM_lua_getmetatable.esp = FSM_lua_getmetatable.esp + 4;
      }
   }
}
