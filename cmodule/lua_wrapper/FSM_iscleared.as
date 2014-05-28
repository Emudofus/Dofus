package cmodule.lua_wrapper
{
   public final class FSM_iscleared extends Machine
   {
      
      public function FSM_iscleared() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM_iscleared.esp = FSM_iscleared.esp - 4;
         FSM_iscleared.ebp = FSM_iscleared.esp;
         FSM_iscleared.esp = FSM_iscleared.esp - 0;
         _loc1_ = op_li32(FSM_iscleared.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM_iscleared.ebp + 12) /*Alchemy*/;
         if(_loc2_ > 3)
         {
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            if(_loc2_ == 4)
            {
               _loc2_ = 0;
               _loc3_ = op_li8(_loc1_ + 5) /*Alchemy*/;
               _loc3_ = _loc3_ & -4;
               FSM_iscleared.eax = _loc2_;
            }
            else
            {
               _loc4_ = op_li8(_loc1_ + 5) /*Alchemy*/;
               _loc4_ = _loc4_ & 3;
               if(_loc4_ != 0)
               {
                  _loc1_ = 1;
               }
               else
               {
                  if(_loc2_ == 7)
                  {
                     if(_loc3_ == 0)
                     {
                        _loc1_ = op_li8(_loc1_ + 5) /*Alchemy*/;
                        _loc1_ = _loc1_ >>> 3;
                        _loc1_ = _loc1_ & 1;
                     }
                  }
               }
               FSM_iscleared.eax = _loc1_;
            }
            if(_loc2_ == 4)
            {
               FSM_iscleared.esp = FSM_iscleared.ebp;
               FSM_iscleared.ebp = op_li32(FSM_iscleared.esp) /*Alchemy*/;
               FSM_iscleared.esp = FSM_iscleared.esp + 4;
               FSM_iscleared.esp = FSM_iscleared.esp + 4;
               return;
            }
            FSM_iscleared.esp = FSM_iscleared.ebp;
            FSM_iscleared.ebp = op_li32(FSM_iscleared.esp) /*Alchemy*/;
            FSM_iscleared.esp = FSM_iscleared.esp + 4;
            FSM_iscleared.esp = FSM_iscleared.esp + 4;
            return;
         }
         _loc1_ = 0;
         FSM_iscleared.eax = _loc1_;
         FSM_iscleared.esp = FSM_iscleared.ebp;
         FSM_iscleared.ebp = op_li32(FSM_iscleared.esp) /*Alchemy*/;
         FSM_iscleared.esp = FSM_iscleared.esp + 4;
         FSM_iscleared.esp = FSM_iscleared.esp + 4;
      }
   }
}
