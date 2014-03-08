package cmodule.lua_wrapper
{
   public final class FSM_getthread extends Machine
   {
      
      public function FSM_getthread() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM_getthread.esp = FSM_getthread.esp - 4;
         FSM_getthread.ebp = FSM_getthread.esp;
         FSM_getthread.esp = FSM_getthread.esp - 0;
         _loc1_ = 1;
         FSM_getthread.esp = FSM_getthread.esp - 8;
         _loc2_ = op_li32(FSM_getthread.ebp + 8) /*Alchemy*/;
         FSM_getthread.esp = FSM_getthread.esp - 4;
         FSM_getthread.start();
         _loc1_ = FSM_getthread.eax;
         FSM_getthread.esp = FSM_getthread.esp + 8;
         _loc3_ = op_li32(FSM_getthread.ebp + 12) /*Alchemy*/;
         _loc4_ = FSM_getthread;
         if(_loc1_ != _loc4_)
         {
            _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            if(_loc1_ == 8)
            {
               _loc1_ = 1;
               FSM_getthread.esp = FSM_getthread.esp - 8;
               FSM_getthread.esp = FSM_getthread.esp - 4;
               FSM_getthread.start();
               _loc2_ = FSM_getthread.eax;
               FSM_getthread.esp = FSM_getthread.esp + 8;
               _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
               if(_loc3_ == 8)
               {
                  _loc2_ = op_li32(_loc2_) /*Alchemy*/;
               }
               else
               {
                  _loc2_ = 0;
               }
            }
            if(_loc1_ == 8)
            {
               FSM_getthread.eax = _loc2_;
               FSM_getthread.esp = FSM_getthread.ebp;
               FSM_getthread.ebp = op_li32(FSM_getthread.esp) /*Alchemy*/;
               FSM_getthread.esp = FSM_getthread.esp + 4;
               FSM_getthread.esp = FSM_getthread.esp + 4;
               return;
            }
            FSM_getthread.eax = _loc2_;
            FSM_getthread.esp = FSM_getthread.ebp;
            FSM_getthread.ebp = op_li32(FSM_getthread.esp) /*Alchemy*/;
            FSM_getthread.esp = FSM_getthread.esp + 4;
            FSM_getthread.esp = FSM_getthread.esp + 4;
            return;
         }
         _loc1_ = 0;
         FSM_getthread.eax = _loc2_;
         FSM_getthread.esp = FSM_getthread.ebp;
         FSM_getthread.ebp = op_li32(FSM_getthread.esp) /*Alchemy*/;
         FSM_getthread.esp = FSM_getthread.esp + 4;
         FSM_getthread.esp = FSM_getthread.esp + 4;
      }
   }
}
