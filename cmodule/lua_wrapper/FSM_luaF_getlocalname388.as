package cmodule.lua_wrapper
{
   public final class FSM_luaF_getlocalname388 extends Machine
   {
      
      public function FSM_luaF_getlocalname388() {
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
         FSM_luaF_getlocalname388.esp = FSM_luaF_getlocalname388.esp - 4;
         FSM_luaF_getlocalname388.ebp = FSM_luaF_getlocalname388.esp;
         FSM_luaF_getlocalname388.esp = FSM_luaF_getlocalname388.esp - 0;
         _loc1_ = op_li32(FSM_luaF_getlocalname388.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_luaF_getlocalname388.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM_luaF_getlocalname388.ebp + 16) /*Alchemy*/;
         _loc4_ = op_li32(FSM_luaF_getlocalname388.ebp + 20) /*Alchemy*/;
         _loc5_ = _loc1_;
         if(_loc2_ >= 1)
         {
            _loc6_ = 0;
            while(true)
            {
               _loc7_ = _loc5_;
               _loc5_ = _loc6_;
               _loc6_ = op_li32(_loc7_ + 4) /*Alchemy*/;
               if(_loc6_ > _loc4_)
               {
                  break;
               }
               _loc6_ = op_li32(_loc7_ + 8) /*Alchemy*/;
               if(_loc6_ > _loc4_)
               {
                  _loc6_ = _loc3_ + -1;
                  if(_loc3_ != 1)
                  {
                     _loc3_ = _loc6_;
                  }
                  else
                  {
                     _loc3_ = _loc5_ * 12;
                     _loc3_ = _loc1_ + _loc3_;
                     _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                     _loc3_ = _loc3_ + 16;
                     FSM_luaF_getlocalname388.eax = _loc3_;
                     FSM_luaF_getlocalname388.esp = FSM_luaF_getlocalname388.ebp;
                     FSM_luaF_getlocalname388.ebp = op_li32(FSM_luaF_getlocalname388.esp) /*Alchemy*/;
                     FSM_luaF_getlocalname388.esp = FSM_luaF_getlocalname388.esp + 4;
                     FSM_luaF_getlocalname388.esp = FSM_luaF_getlocalname388.esp + 4;
                     return;
                  }
               }
               _loc6_ = _loc7_ + 12;
               _loc7_ = _loc5_ + 1;
               if(_loc7_ < _loc2_)
               {
                  _loc5_ = _loc6_;
                  _loc6_ = _loc7_;
                  continue;
               }
               break;
            }
         }
         _loc1_ = 0;
         FSM_luaF_getlocalname388.eax = _loc1_;
         FSM_luaF_getlocalname388.esp = FSM_luaF_getlocalname388.ebp;
         FSM_luaF_getlocalname388.ebp = op_li32(FSM_luaF_getlocalname388.esp) /*Alchemy*/;
         FSM_luaF_getlocalname388.esp = FSM_luaF_getlocalname388.esp + 4;
         FSM_luaF_getlocalname388.esp = FSM_luaF_getlocalname388.esp + 4;
      }
   }
}
