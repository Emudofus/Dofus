package cmodule.lua_wrapper
{
   public final class FSM___ULtod_D2A extends Machine
   {
      
      public function FSM___ULtod_D2A() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp - 4;
         FSM___ULtod_D2A.ebp = FSM___ULtod_D2A.esp;
         FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp - 0;
         _loc1_ = op_li32(FSM___ULtod_D2A.ebp + 20) /*Alchemy*/;
         _loc2_ = op_li32(FSM___ULtod_D2A.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM___ULtod_D2A.ebp + 12) /*Alchemy*/;
         _loc4_ = op_li32(FSM___ULtod_D2A.ebp + 16) /*Alchemy*/;
         _loc5_ = _loc1_ & 7;
         if(_loc5_ <= 2)
         {
            if(_loc5_ != 0)
            {
               if(_loc5_ != 1)
               {
                  if(_loc5_ != 2)
                  {
                     _loc1_ = _loc1_ & 8;
                     if(_loc1_ != 0)
                     {
                        _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
                        _loc1_ = _loc1_ | -2147483648;
                     }
                     if(_loc1_ != 0)
                     {
                     }
                  }
                  else
                  {
                     _loc4_ = op_li32(_loc3_) /*Alchemy*/;
                     _loc3_ = op_li32(_loc3_ + 4) /*Alchemy*/;
                     _loc1_ = _loc1_ & 8;
                     if(_loc1_ != 0)
                     {
                        _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
                        _loc1_ = _loc1_ | -2147483648;
                     }
                     if(_loc1_ != 0)
                     {
                     }
                  }
                  if(_loc5_ != 2)
                  {
                  }
               }
            }
            else
            {
               _loc3_ = 0;
               _loc1_ = _loc1_ & 8;
               if(_loc1_ != 0)
               {
                  _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
                  _loc1_ = _loc1_ | -2147483648;
               }
               if(_loc1_ != 0)
               {
               }
            }
            if(_loc5_ != 0)
            {
               FSM___ULtod_D2A.esp = FSM___ULtod_D2A.ebp;
               FSM___ULtod_D2A.ebp = op_li32(FSM___ULtod_D2A.esp) /*Alchemy*/;
               FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
               FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
               return;
            }
            FSM___ULtod_D2A.esp = FSM___ULtod_D2A.ebp;
            FSM___ULtod_D2A.ebp = op_li32(FSM___ULtod_D2A.esp) /*Alchemy*/;
            FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
            FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
            return;
         }
         if(_loc5_ <= 4)
         {
            if(_loc5_ != 3)
            {
               if(_loc5_ == 4)
               {
                  _loc3_ = 2147483647;
                  _loc3_ = -1;
               }
               if(_loc5_ != 4)
               {
                  _loc1_ = _loc1_ & 8;
                  if(_loc1_ != 0)
                  {
                     _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
                     _loc1_ = _loc1_ | -2147483648;
                  }
                  if(_loc1_ != 0)
                  {
                  }
               }
               else
               {
                  _loc1_ = _loc1_ & 8;
                  if(_loc1_ != 0)
                  {
                     _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
                     _loc1_ = _loc1_ | -2147483648;
                  }
                  if(_loc1_ != 0)
                  {
                  }
               }
            }
            else
            {
               _loc3_ = 2146435072;
               _loc3_ = 0;
               _loc1_ = _loc1_ & 8;
               if(_loc1_ != 0)
               {
                  _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
                  _loc1_ = _loc1_ | -2147483648;
               }
               if(_loc1_ != 0)
               {
               }
            }
            if(_loc5_ != 3)
            {
            }
         }
         else
         {
            if(_loc5_ != 5)
            {
               if(_loc5_ == 6)
               {
                  _loc3_ = 0;
                  _loc1_ = _loc1_ & 8;
                  if(_loc1_ != 0)
                  {
                     _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
                     _loc1_ = _loc1_ | -2147483648;
                  }
                  if(_loc1_ != 0)
                  {
                  }
               }
               else
               {
                  _loc1_ = _loc1_ & 8;
                  if(_loc1_ != 0)
                  {
                     _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
                     _loc1_ = _loc1_ | -2147483648;
                  }
                  if(_loc1_ != 0)
                  {
                  }
               }
               if(_loc5_ == 6)
               {
               }
            }
         }
         FSM___ULtod_D2A.esp = FSM___ULtod_D2A.ebp;
         FSM___ULtod_D2A.ebp = op_li32(FSM___ULtod_D2A.esp) /*Alchemy*/;
         FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
         FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
         return;
         _loc5_ = op_li32(_loc3_) /*Alchemy*/;
         _loc3_ = op_li32(_loc3_ + 4) /*Alchemy*/;
         _loc4_ = _loc4_ << 20;
         _loc4_ = _loc4_ + 1127219200;
         _loc3_ = _loc3_ & -1048577;
         _loc3_ = _loc3_ | _loc4_;
         _loc1_ = _loc1_ & 8;
         if(_loc1_ != 0)
         {
            _loc1_ = op_li32(_loc2_ + 4) /*Alchemy*/;
            _loc1_ = _loc1_ | -2147483648;
         }
         if(_loc1_ != 0)
         {
            FSM___ULtod_D2A.esp = FSM___ULtod_D2A.ebp;
            FSM___ULtod_D2A.ebp = op_li32(FSM___ULtod_D2A.esp) /*Alchemy*/;
            FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
            FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
            return;
         }
         FSM___ULtod_D2A.esp = FSM___ULtod_D2A.ebp;
         FSM___ULtod_D2A.ebp = op_li32(FSM___ULtod_D2A.esp) /*Alchemy*/;
         FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
         FSM___ULtod_D2A.esp = FSM___ULtod_D2A.esp + 4;
      }
   }
}
