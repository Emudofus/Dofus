package cmodule.lua_wrapper
{
   public final class FSM_lua_topointer extends Machine
   {
      
      public function FSM_lua_topointer() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM_lua_topointer.esp = FSM_lua_topointer.esp - 4;
         FSM_lua_topointer.ebp = FSM_lua_topointer.esp;
         FSM_lua_topointer.esp = FSM_lua_topointer.esp - 0;
         _loc1_ = FSM_lua_topointer;
         _loc2_ = op_li32(FSM_lua_topointer.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         _loc4_ = op_li32(_loc2_ + 12) /*Alchemy*/;
         _loc1_ = uint(_loc3_) > uint(_loc4_)?_loc4_:_loc1_;
         _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         if(_loc3_ <= 5)
         {
            if(_loc3_ != 2)
            {
               if(_loc3_ != 5)
               {
                  _loc1_ = 0;
               }
               FSM_lua_topointer.eax = _loc1_;
               FSM_lua_topointer.esp = FSM_lua_topointer.ebp;
               FSM_lua_topointer.ebp = op_li32(FSM_lua_topointer.esp) /*Alchemy*/;
               FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
               FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
               return;
            }
            _loc1_ = 1;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp - 8;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp - 4;
            FSM_lua_topointer.start();
            _loc1_ = FSM_lua_topointer.eax;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp + 8;
            _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            if(_loc2_ != 2)
            {
               if(_loc2_ == 7)
               {
                  _loc1_ = op_li32(_loc1_) /*Alchemy*/;
                  _loc1_ = _loc1_ + 20;
               }
               else
               {
                  _loc1_ = 0;
               }
            }
            FSM_lua_topointer.eax = _loc1_;
            FSM_lua_topointer.esp = FSM_lua_topointer.ebp;
            FSM_lua_topointer.ebp = op_li32(FSM_lua_topointer.esp) /*Alchemy*/;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
            return;
            if(_loc3_ != 2)
            {
               _loc1_ = op_li32(_loc1_) /*Alchemy*/;
               FSM_lua_topointer.eax = _loc1_;
               FSM_lua_topointer.esp = FSM_lua_topointer.ebp;
               FSM_lua_topointer.ebp = op_li32(FSM_lua_topointer.esp) /*Alchemy*/;
               FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
               FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
               return;
            }
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            FSM_lua_topointer.eax = _loc1_;
            FSM_lua_topointer.esp = FSM_lua_topointer.ebp;
            FSM_lua_topointer.ebp = op_li32(FSM_lua_topointer.esp) /*Alchemy*/;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
            return;
         }
         if(_loc3_ != 6)
         {
            if(_loc3_ != 7)
            {
               if(_loc3_ != 8)
               {
                  _loc1_ = 0;
               }
               else
               {
                  _loc2_ = op_li32(_loc1_) /*Alchemy*/;
                  FSM_lua_topointer.eax = _loc2_;
               }
               FSM_lua_topointer.esp = FSM_lua_topointer.ebp;
               FSM_lua_topointer.ebp = op_li32(FSM_lua_topointer.esp) /*Alchemy*/;
               FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
               FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
               return;
            }
            _loc1_ = 1;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp - 8;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp - 4;
            FSM_lua_topointer.start();
            _loc1_ = FSM_lua_topointer.eax;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp + 8;
            _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            if(_loc2_ != 2)
            {
               if(_loc2_ == 7)
               {
                  _loc1_ = op_li32(_loc1_) /*Alchemy*/;
                  _loc1_ = _loc1_ + 20;
               }
               else
               {
                  _loc1_ = 0;
               }
            }
            if(_loc3_ != 7)
            {
               FSM_lua_topointer.eax = _loc1_;
               FSM_lua_topointer.esp = FSM_lua_topointer.ebp;
               FSM_lua_topointer.ebp = op_li32(FSM_lua_topointer.esp) /*Alchemy*/;
               FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
               FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
               return;
            }
            FSM_lua_topointer.eax = _loc1_;
            FSM_lua_topointer.esp = FSM_lua_topointer.ebp;
            FSM_lua_topointer.ebp = op_li32(FSM_lua_topointer.esp) /*Alchemy*/;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
            FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
            return;
         }
         _loc1_ = op_li32(_loc1_) /*Alchemy*/;
         FSM_lua_topointer.eax = _loc1_;
         FSM_lua_topointer.esp = FSM_lua_topointer.ebp;
         FSM_lua_topointer.ebp = op_li32(FSM_lua_topointer.esp) /*Alchemy*/;
         FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
         FSM_lua_topointer.esp = FSM_lua_topointer.esp + 4;
      }
   }
}
