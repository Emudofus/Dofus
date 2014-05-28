package cmodule.lua_wrapper
{
   public final class FSM___hexdig_init_D2A extends Machine
   {
      
      public function FSM___hexdig_init_D2A() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM___hexdig_init_D2A.esp = FSM___hexdig_init_D2A.esp - 4;
         FSM___hexdig_init_D2A.ebp = FSM___hexdig_init_D2A.esp;
         FSM___hexdig_init_D2A.esp = FSM___hexdig_init_D2A.esp - 0;
         _loc1_ = FSM___hexdig_init_D2A;
         _loc2_ = 48;
         _loc1_ = _loc1_ + 1;
         _loc3_ = 16;
         while(true)
         {
            _loc4_ = FSM___hexdig_init_D2A;
            _loc2_ = _loc2_ & 255;
            _loc2_ = _loc4_ + _loc2_;
            _loc2_ = op_li8(_loc1_) /*Alchemy*/;
            _loc3_ = _loc3_ + 1;
            _loc1_ = _loc1_ + 1;
            if(_loc2_ != 0)
            {
               continue;
            }
            break;
         }
         _loc1_ = FSM___hexdig_init_D2A;
         _loc2_ = 97;
         _loc1_ = _loc1_ + 1;
         _loc3_ = 26;
         while(true)
         {
            _loc4_ = FSM___hexdig_init_D2A;
            _loc2_ = _loc2_ & 255;
            _loc2_ = _loc4_ + _loc2_;
            _loc2_ = op_li8(_loc1_) /*Alchemy*/;
            _loc3_ = _loc3_ + 1;
            _loc1_ = _loc1_ + 1;
            if(_loc2_ != 0)
            {
               continue;
            }
            break;
         }
         _loc1_ = FSM___hexdig_init_D2A;
         _loc2_ = 65;
         _loc1_ = _loc1_ + 1;
         _loc3_ = 26;
         while(true)
         {
            _loc4_ = FSM___hexdig_init_D2A;
            _loc2_ = _loc2_ & 255;
            _loc2_ = _loc4_ + _loc2_;
            _loc2_ = op_li8(_loc1_) /*Alchemy*/;
            _loc3_ = _loc3_ + 1;
            _loc1_ = _loc1_ + 1;
            if(_loc2_ != 0)
            {
               continue;
            }
            break;
         }
         FSM___hexdig_init_D2A.esp = FSM___hexdig_init_D2A.ebp;
         FSM___hexdig_init_D2A.ebp = op_li32(FSM___hexdig_init_D2A.esp) /*Alchemy*/;
         FSM___hexdig_init_D2A.esp = FSM___hexdig_init_D2A.esp + 4;
         FSM___hexdig_init_D2A.esp = FSM___hexdig_init_D2A.esp + 4;
      }
   }
}
