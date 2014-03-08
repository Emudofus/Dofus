package cmodule.lua_wrapper
{
   public final class FSM_checkArgMode extends Machine
   {
      
      public function FSM_checkArgMode() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         FSM_checkArgMode.esp = FSM_checkArgMode.esp - 4;
         FSM_checkArgMode.ebp = FSM_checkArgMode.esp;
         FSM_checkArgMode.esp = FSM_checkArgMode.esp - 0;
         _loc1_ = op_li32(FSM_checkArgMode.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_checkArgMode.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM_checkArgMode.ebp + 16) /*Alchemy*/;
         if(_loc3_ != 3)
         {
            if(_loc3_ != 2)
            {
               if(_loc3_ == 0)
               {
                  _loc1_ = _loc2_ == 0?1:0;
               }
               else
               {
                  _loc1_ = 1;
               }
               FSM_checkArgMode.eax = _loc1_;
               FSM_checkArgMode.esp = FSM_checkArgMode.ebp;
               FSM_checkArgMode.ebp = op_li32(FSM_checkArgMode.esp) /*Alchemy*/;
               FSM_checkArgMode.esp = FSM_checkArgMode.esp + 4;
               FSM_checkArgMode.esp = FSM_checkArgMode.esp + 4;
               return;
            }
            _loc1_ = _loc1_ & 1;
            FSM_checkArgMode.eax = _loc1_;
            FSM_checkArgMode.esp = FSM_checkArgMode.ebp;
            FSM_checkArgMode.ebp = op_li32(FSM_checkArgMode.esp) /*Alchemy*/;
            FSM_checkArgMode.esp = FSM_checkArgMode.esp + 4;
            FSM_checkArgMode.esp = FSM_checkArgMode.esp + 4;
            return;
         }
         _loc3_ = _loc2_ & 256;
         if(_loc3_ != 0)
         {
            _loc1_ = op_li32(_loc1_ + 40) /*Alchemy*/;
            _loc2_ = _loc2_ & -257;
            _loc1_ = _loc2_ < _loc1_?1:0;
         }
         _loc1_ = _loc1_ & 1;
         FSM_checkArgMode.eax = _loc1_;
         FSM_checkArgMode.esp = FSM_checkArgMode.ebp;
         FSM_checkArgMode.ebp = op_li32(FSM_checkArgMode.esp) /*Alchemy*/;
         FSM_checkArgMode.esp = FSM_checkArgMode.esp + 4;
         FSM_checkArgMode.esp = FSM_checkArgMode.esp + 4;
         return;
         _loc1_ = op_li8(_loc1_ + 75) /*Alchemy*/;
         _loc1_ = _loc1_ > _loc2_?1:0;
         _loc1_ = _loc1_ & 1;
         FSM_checkArgMode.eax = _loc1_;
         FSM_checkArgMode.esp = FSM_checkArgMode.ebp;
         FSM_checkArgMode.ebp = op_li32(FSM_checkArgMode.esp) /*Alchemy*/;
         FSM_checkArgMode.esp = FSM_checkArgMode.esp + 4;
         FSM_checkArgMode.esp = FSM_checkArgMode.esp + 4;
      }
   }
}
