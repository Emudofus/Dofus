package cmodule.lua_wrapper
{
   public final class FSM_localeconv extends Machine
   {
      
      public function FSM_localeconv() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         FSM_localeconv.esp = FSM_localeconv.esp - 4;
         FSM_localeconv.ebp = FSM_localeconv.esp;
         FSM_localeconv.esp = FSM_localeconv.esp - 0;
         _loc1_ = op_li8(FSM_localeconv) /*Alchemy*/;
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
         }
         if(_loc1_ == 0)
         {
            _loc1_ = op_li8(FSM_localeconv) /*Alchemy*/;
            if(_loc1_ == 0)
            {
               _loc1_ = FSM_localeconv;
               _loc2_ = op_li32(FSM_localeconv) /*Alchemy*/;
               _loc3_ = FSM_localeconv;
               _loc1_ = _loc2_ == 0?_loc1_:_loc3_;
               _loc2_ = op_li32(_loc1_) /*Alchemy*/;
               _loc2_ = op_li32(_loc1_ + 4) /*Alchemy*/;
               _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               _loc1_ = 1;
            }
            if(_loc1_ == 0)
            {
               FSM_localeconv.esp = FSM_localeconv.ebp;
               FSM_localeconv.ebp = op_li32(FSM_localeconv.esp) /*Alchemy*/;
               FSM_localeconv.esp = FSM_localeconv.esp + 4;
               FSM_localeconv.esp = FSM_localeconv.esp + 4;
               return;
            }
            FSM_localeconv.esp = FSM_localeconv.ebp;
            FSM_localeconv.ebp = op_li32(FSM_localeconv.esp) /*Alchemy*/;
            FSM_localeconv.esp = FSM_localeconv.esp + 4;
            FSM_localeconv.esp = FSM_localeconv.esp + 4;
            return;
         }
         _loc1_ = op_li8(FSM_localeconv) /*Alchemy*/;
         if(_loc1_ == 0)
         {
            _loc1_ = FSM_localeconv;
            _loc2_ = op_li32(FSM_localeconv) /*Alchemy*/;
            _loc3_ = FSM_localeconv;
            _loc1_ = _loc2_ == 0?_loc1_:_loc3_;
            _loc2_ = op_li32(_loc1_) /*Alchemy*/;
            _loc2_ = op_li32(_loc1_ + 4) /*Alchemy*/;
            _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc1_ = 1;
         }
         if(_loc1_ == 0)
         {
            FSM_localeconv.esp = FSM_localeconv.ebp;
            FSM_localeconv.ebp = op_li32(FSM_localeconv.esp) /*Alchemy*/;
            FSM_localeconv.esp = FSM_localeconv.esp + 4;
            FSM_localeconv.esp = FSM_localeconv.esp + 4;
            return;
         }
         FSM_localeconv.esp = FSM_localeconv.ebp;
         FSM_localeconv.ebp = op_li32(FSM_localeconv.esp) /*Alchemy*/;
         FSM_localeconv.esp = FSM_localeconv.esp + 4;
         FSM_localeconv.esp = FSM_localeconv.esp + 4;
      }
   }
}
