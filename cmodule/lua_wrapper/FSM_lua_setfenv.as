package cmodule.lua_wrapper
{
   public final class FSM_lua_setfenv extends Machine
   {
      
      public function FSM_lua_setfenv() {
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
         FSM_lua_setfenv.esp = FSM_lua_setfenv.esp - 4;
         FSM_lua_setfenv.ebp = FSM_lua_setfenv.esp;
         FSM_lua_setfenv.esp = FSM_lua_setfenv.esp - 0;
         _loc1_ = op_li32(FSM_lua_setfenv.ebp + 8) /*Alchemy*/;
         FSM_lua_setfenv.esp = FSM_lua_setfenv.esp - 8;
         _loc2_ = op_li32(FSM_lua_setfenv.ebp + 12) /*Alchemy*/;
         FSM_lua_setfenv.esp = FSM_lua_setfenv.esp - 4;
         FSM_lua_setfenv.start();
         _loc2_ = FSM_lua_setfenv.eax;
         FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 8;
         _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         if(_loc3_ != 6)
         {
            if(_loc3_ != 7)
            {
               if(_loc3_ != 8)
               {
                  _loc3_ = 0;
               }
               else
               {
                  _loc3_ = 5;
                  _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                  _loc5_ = op_li32(_loc2_) /*Alchemy*/;
                  _loc4_ = op_li32(_loc4_ + -12) /*Alchemy*/;
                  _loc3_ = 1;
               }
               if(_loc3_ != 8)
               {
                  if(_loc3_ == 0)
                  {
                     _loc2_ = _loc3_;
                  }
                  _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
                  _loc3_ = _loc3_ + -12;
                  FSM_lua_setfenv.eax = _loc2_;
                  FSM_lua_setfenv.esp = FSM_lua_setfenv.ebp;
                  FSM_lua_setfenv.ebp = op_li32(FSM_lua_setfenv.esp) /*Alchemy*/;
                  FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
                  FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
                  return;
               }
               if(_loc3_ == 0)
               {
                  _loc2_ = _loc3_;
               }
               _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               _loc3_ = _loc3_ + -12;
               FSM_lua_setfenv.eax = _loc2_;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.ebp;
               FSM_lua_setfenv.ebp = op_li32(FSM_lua_setfenv.esp) /*Alchemy*/;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
               return;
            }
            _loc3_ = 1;
            _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc5_ = op_li32(_loc2_) /*Alchemy*/;
            _loc4_ = op_li32(_loc4_ + -12) /*Alchemy*/;
            if(_loc3_ != 7)
            {
            }
         }
         else
         {
            _loc3_ = 1;
            _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc5_ = op_li32(_loc2_) /*Alchemy*/;
            _loc4_ = op_li32(_loc4_ + -12) /*Alchemy*/;
         }
         if(_loc3_ != 6)
         {
            _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc4_ = op_li32(_loc4_ + -12) /*Alchemy*/;
            _loc5_ = op_li8(_loc4_ + 5) /*Alchemy*/;
            _loc5_ = _loc5_ & 3;
            if(_loc5_ != 0)
            {
               _loc2_ = op_li32(_loc2_) /*Alchemy*/;
               _loc5_ = op_li8(_loc2_ + 5) /*Alchemy*/;
               _loc2_ = _loc2_ + 5;
               _loc6_ = _loc5_ & 4;
               if(_loc6_ != 0)
               {
                  _loc6_ = op_li32(_loc1_ + 16) /*Alchemy*/;
                  _loc7_ = op_li8(_loc6_ + 21) /*Alchemy*/;
                  if(_loc7_ == 1)
                  {
                     FSM_lua_setfenv.esp = FSM_lua_setfenv.esp - 8;
                     FSM_lua_setfenv.esp = FSM_lua_setfenv.esp - 4;
                     FSM_lua_setfenv.start();
                     FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 8;
                     _loc2_ = _loc3_;
                  }
                  else
                  {
                     _loc4_ = op_li8(_loc6_ + 20) /*Alchemy*/;
                     _loc5_ = _loc5_ & -8;
                     _loc4_ = _loc4_ & 3;
                     _loc4_ = _loc4_ | _loc5_;
                     _loc2_ = _loc3_;
                  }
                  if(_loc7_ == 1)
                  {
                  }
               }
               _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               _loc3_ = _loc3_ + -12;
               FSM_lua_setfenv.eax = _loc2_;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.ebp;
               FSM_lua_setfenv.ebp = op_li32(FSM_lua_setfenv.esp) /*Alchemy*/;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
               return;
            }
            if(_loc5_ == 0)
            {
               _loc2_ = _loc3_;
               _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               _loc3_ = _loc3_ + -12;
               FSM_lua_setfenv.eax = _loc2_;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.ebp;
               FSM_lua_setfenv.ebp = op_li32(FSM_lua_setfenv.esp) /*Alchemy*/;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
               FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
               return;
            }
            _loc2_ = _loc3_;
            _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc3_ = _loc3_ + -12;
            FSM_lua_setfenv.eax = _loc2_;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.ebp;
            FSM_lua_setfenv.ebp = op_li32(FSM_lua_setfenv.esp) /*Alchemy*/;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
            return;
         }
         _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc4_ = op_li32(_loc4_ + -12) /*Alchemy*/;
         _loc5_ = op_li8(_loc4_ + 5) /*Alchemy*/;
         _loc5_ = _loc5_ & 3;
         if(_loc5_ != 0)
         {
            _loc2_ = op_li32(_loc2_) /*Alchemy*/;
            _loc5_ = op_li8(_loc2_ + 5) /*Alchemy*/;
            _loc2_ = _loc2_ + 5;
            _loc6_ = _loc5_ & 4;
            if(_loc6_ != 0)
            {
               _loc6_ = op_li32(_loc1_ + 16) /*Alchemy*/;
               _loc7_ = op_li8(_loc6_ + 21) /*Alchemy*/;
               if(_loc7_ == 1)
               {
                  FSM_lua_setfenv.esp = FSM_lua_setfenv.esp - 8;
                  FSM_lua_setfenv.esp = FSM_lua_setfenv.esp - 4;
                  FSM_lua_setfenv.start();
                  FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 8;
                  _loc2_ = _loc3_;
               }
               else
               {
                  _loc4_ = op_li8(_loc6_ + 20) /*Alchemy*/;
                  _loc5_ = _loc5_ & -8;
                  _loc4_ = _loc4_ & 3;
                  _loc4_ = _loc4_ | _loc5_;
                  _loc2_ = _loc3_;
               }
               if(_loc7_ == 1)
               {
               }
            }
            _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc3_ = _loc3_ + -12;
            FSM_lua_setfenv.eax = _loc2_;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.ebp;
            FSM_lua_setfenv.ebp = op_li32(FSM_lua_setfenv.esp) /*Alchemy*/;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
            return;
         }
         if(_loc5_ == 0)
         {
            _loc2_ = _loc3_;
            _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc3_ = _loc3_ + -12;
            FSM_lua_setfenv.eax = _loc2_;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.ebp;
            FSM_lua_setfenv.ebp = op_li32(FSM_lua_setfenv.esp) /*Alchemy*/;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
            FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
            return;
         }
         _loc2_ = _loc3_;
         _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc3_ = _loc3_ + -12;
         FSM_lua_setfenv.eax = _loc2_;
         FSM_lua_setfenv.esp = FSM_lua_setfenv.ebp;
         FSM_lua_setfenv.ebp = op_li32(FSM_lua_setfenv.esp) /*Alchemy*/;
         FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
         FSM_lua_setfenv.esp = FSM_lua_setfenv.esp + 4;
      }
   }
}
