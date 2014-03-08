package cmodule.lua_wrapper
{
   public final class FSM_lua_getfenv extends Machine
   {
      
      public function FSM_lua_getfenv() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         FSM_lua_getfenv.esp = FSM_lua_getfenv.esp - 4;
         FSM_lua_getfenv.ebp = FSM_lua_getfenv.esp;
         FSM_lua_getfenv.esp = FSM_lua_getfenv.esp - 0;
         _loc1_ = op_li32(FSM_lua_getfenv.ebp + 8) /*Alchemy*/;
         FSM_lua_getfenv.esp = FSM_lua_getfenv.esp - 8;
         _loc2_ = op_li32(FSM_lua_getfenv.ebp + 12) /*Alchemy*/;
         FSM_lua_getfenv.esp = FSM_lua_getfenv.esp - 4;
         FSM_lua_getfenv.start();
         _loc2_ = FSM_lua_getfenv.eax;
         FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 8;
         _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         _loc1_ = _loc1_ + 8;
         if(_loc3_ != 8)
         {
            if(_loc3_ != 7)
            {
               if(_loc3_ != 6)
               {
                  _loc2_ = 0;
                  _loc3_ = op_li32(_loc1_) /*Alchemy*/;
               }
               _loc2_ = op_li32(_loc1_) /*Alchemy*/;
               _loc2_ = _loc2_ + 12;
               FSM_lua_getfenv.esp = FSM_lua_getfenv.ebp;
               FSM_lua_getfenv.ebp = op_li32(FSM_lua_getfenv.esp) /*Alchemy*/;
               FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
               FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
               return;
            }
            if(_loc3_ != 7)
            {
               _loc3_ = 5;
               _loc2_ = op_li32(_loc2_) /*Alchemy*/;
               _loc4_ = op_li32(_loc1_) /*Alchemy*/;
               _loc2_ = op_li32(_loc2_ + 12) /*Alchemy*/;
               _loc2_ = op_li32(_loc1_) /*Alchemy*/;
               _loc2_ = _loc2_ + 12;
               FSM_lua_getfenv.esp = FSM_lua_getfenv.ebp;
               FSM_lua_getfenv.ebp = op_li32(FSM_lua_getfenv.esp) /*Alchemy*/;
               FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
               FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
               return;
            }
            _loc3_ = 5;
            _loc2_ = op_li32(_loc2_) /*Alchemy*/;
            _loc4_ = op_li32(_loc1_) /*Alchemy*/;
            _loc2_ = op_li32(_loc2_ + 12) /*Alchemy*/;
            _loc2_ = op_li32(_loc1_) /*Alchemy*/;
            _loc2_ = _loc2_ + 12;
            FSM_lua_getfenv.esp = FSM_lua_getfenv.ebp;
            FSM_lua_getfenv.ebp = op_li32(FSM_lua_getfenv.esp) /*Alchemy*/;
            FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
            FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
            return;
         }
         _loc2_ = op_li32(_loc2_) /*Alchemy*/;
         _loc3_ = op_li32(_loc1_) /*Alchemy*/;
         _loc5_ = op_lf64(_loc2_ + 72) /*Alchemy*/;
         _loc2_ = op_li32(_loc2_ + 80) /*Alchemy*/;
         if(_loc3_ != 8)
         {
            _loc2_ = op_li32(_loc1_) /*Alchemy*/;
            _loc2_ = _loc2_ + 12;
            FSM_lua_getfenv.esp = FSM_lua_getfenv.ebp;
            FSM_lua_getfenv.ebp = op_li32(FSM_lua_getfenv.esp) /*Alchemy*/;
            FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
            FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
            return;
         }
         _loc2_ = op_li32(_loc1_) /*Alchemy*/;
         _loc2_ = _loc2_ + 12;
         FSM_lua_getfenv.esp = FSM_lua_getfenv.ebp;
         FSM_lua_getfenv.ebp = op_li32(FSM_lua_getfenv.esp) /*Alchemy*/;
         FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
         FSM_lua_getfenv.esp = FSM_lua_getfenv.esp + 4;
      }
   }
}
