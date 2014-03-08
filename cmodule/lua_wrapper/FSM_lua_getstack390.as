package cmodule.lua_wrapper
{
   public final class FSM_lua_getstack390 extends Machine
   {
      
      public function FSM_lua_getstack390() {
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
         FSM_lua_getstack390.esp = FSM_lua_getstack390.esp - 4;
         FSM_lua_getstack390.ebp = FSM_lua_getstack390.esp;
         FSM_lua_getstack390.esp = FSM_lua_getstack390.esp - 0;
         _loc1_ = op_li32(FSM_lua_getstack390.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_lua_getstack390.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM_lua_getstack390.ebp + 16) /*Alchemy*/;
         _loc4_ = op_li32(FSM_lua_getstack390.ebp + 20) /*Alchemy*/;
         _loc5_ = _loc1_;
         if(_loc3_ >= 1)
         {
            _loc6_ = 0;
            while(true)
            {
               _loc7_ = _loc5_;
               if(uint(_loc5_) <= uint(_loc2_))
               {
                  _loc1_ = _loc7_;
                  break;
               }
               _loc7_ = op_li32(_loc5_ + 4) /*Alchemy*/;
               _loc7_ = op_li32(_loc7_) /*Alchemy*/;
               _loc7_ = op_li8(_loc7_ + 6) /*Alchemy*/;
               _loc3_ = _loc3_ + -1;
               if(_loc7_ == 0)
               {
                  _loc7_ = op_li32(_loc5_ + 20) /*Alchemy*/;
                  _loc3_ = _loc3_ - _loc7_;
               }
               _loc7_ = _loc6_ ^ -1;
               _loc7_ = _loc7_ * 24;
               _loc5_ = _loc5_ + -24;
               _loc6_ = _loc6_ + 1;
               _loc7_ = _loc1_ + _loc7_;
               if(_loc3_ >= 1)
               {
                  continue;
               }
               _loc1_ = _loc7_;
               break;
            }
         }
         if(_loc3_ == 0)
         {
            if(uint(_loc1_) > uint(_loc2_))
            {
               _loc3_ = 1;
               _loc1_ = _loc1_ - _loc2_;
               _loc1_ = _loc1_ / 24;
               FSM_lua_getstack390.eax = _loc3_;
            }
            if(uint(_loc1_) > uint(_loc2_))
            {
               FSM_lua_getstack390.esp = FSM_lua_getstack390.ebp;
               FSM_lua_getstack390.ebp = op_li32(FSM_lua_getstack390.esp) /*Alchemy*/;
               FSM_lua_getstack390.esp = FSM_lua_getstack390.esp + 4;
               FSM_lua_getstack390.esp = FSM_lua_getstack390.esp + 4;
               return;
            }
            FSM_lua_getstack390.esp = FSM_lua_getstack390.ebp;
            FSM_lua_getstack390.ebp = op_li32(FSM_lua_getstack390.esp) /*Alchemy*/;
            FSM_lua_getstack390.esp = FSM_lua_getstack390.esp + 4;
            FSM_lua_getstack390.esp = FSM_lua_getstack390.esp + 4;
            return;
         }
         if(_loc3_ <= -1)
         {
            _loc1_ = 0;
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = 0;
         }
         if(_loc3_ <= -1)
         {
            FSM_lua_getstack390.eax = _loc1_;
            FSM_lua_getstack390.esp = FSM_lua_getstack390.ebp;
            FSM_lua_getstack390.ebp = op_li32(FSM_lua_getstack390.esp) /*Alchemy*/;
            FSM_lua_getstack390.esp = FSM_lua_getstack390.esp + 4;
            FSM_lua_getstack390.esp = FSM_lua_getstack390.esp + 4;
            return;
         }
         FSM_lua_getstack390.eax = _loc1_;
         FSM_lua_getstack390.esp = FSM_lua_getstack390.ebp;
         FSM_lua_getstack390.ebp = op_li32(FSM_lua_getstack390.esp) /*Alchemy*/;
         FSM_lua_getstack390.esp = FSM_lua_getstack390.esp + 4;
         FSM_lua_getstack390.esp = FSM_lua_getstack390.esp + 4;
      }
   }
}
