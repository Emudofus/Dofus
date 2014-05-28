package cmodule.lua_wrapper
{
   public final class FSM_luaB_corunning extends Machine
   {
      
      public function FSM_luaB_corunning() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM_luaB_corunning.esp = FSM_luaB_corunning.esp - 4;
         FSM_luaB_corunning.ebp = FSM_luaB_corunning.esp;
         FSM_luaB_corunning.esp = FSM_luaB_corunning.esp - 0;
         _loc1_ = 8;
         _loc2_ = op_li32(FSM_luaB_corunning.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         _loc1_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         _loc3_ = _loc1_ + 12;
         _loc3_ = op_li32(_loc2_ + 16) /*Alchemy*/;
         _loc3_ = op_li32(_loc3_ + 104) /*Alchemy*/;
         _loc4_ = _loc2_ + 8;
         if(_loc3_ == _loc2_)
         {
            _loc2_ = 0;
            _loc1_ = op_li32(_loc4_) /*Alchemy*/;
            _loc1_ = _loc1_ + 12;
         }
         if(_loc3_ == _loc2_)
         {
            _loc1_ = 1;
            FSM_luaB_corunning.eax = _loc1_;
            FSM_luaB_corunning.esp = FSM_luaB_corunning.ebp;
            FSM_luaB_corunning.ebp = op_li32(FSM_luaB_corunning.esp) /*Alchemy*/;
            FSM_luaB_corunning.esp = FSM_luaB_corunning.esp + 4;
            FSM_luaB_corunning.esp = FSM_luaB_corunning.esp + 4;
            return;
         }
         _loc1_ = 1;
         FSM_luaB_corunning.eax = _loc1_;
         FSM_luaB_corunning.esp = FSM_luaB_corunning.ebp;
         FSM_luaB_corunning.ebp = op_li32(FSM_luaB_corunning.esp) /*Alchemy*/;
         FSM_luaB_corunning.esp = FSM_luaB_corunning.esp + 4;
         FSM_luaB_corunning.esp = FSM_luaB_corunning.esp + 4;
      }
   }
}
