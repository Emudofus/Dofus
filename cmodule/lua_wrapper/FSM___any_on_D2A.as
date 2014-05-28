package cmodule.lua_wrapper
{
   public final class FSM___any_on_D2A extends Machine
   {
      
      public function FSM___any_on_D2A() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM___any_on_D2A.esp = FSM___any_on_D2A.esp - 4;
         FSM___any_on_D2A.ebp = FSM___any_on_D2A.esp;
         FSM___any_on_D2A.esp = FSM___any_on_D2A.esp - 0;
         _loc1_ = op_li32(FSM___any_on_D2A.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM___any_on_D2A.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(_loc2_ + 16) /*Alchemy*/;
         _loc4_ = _loc1_ >> 5;
         if(_loc4_ > _loc3_)
         {
            _loc1_ = _loc3_;
         }
         else
         {
            if(_loc4_ < _loc3_)
            {
               _loc1_ = _loc1_ & 31;
               if(_loc1_ != 0)
               {
                  _loc3_ = _loc4_ << 2;
                  _loc3_ = _loc2_ + _loc3_;
                  _loc3_ = op_li32(_loc3_ + 20) /*Alchemy*/;
                  _loc5_ = _loc3_ >>> _loc1_;
                  _loc1_ = _loc5_ << _loc1_;
                  if(_loc1_ != _loc3_)
                  {
                  }
                  _loc1_ = 1;
                  FSM___any_on_D2A.eax = _loc1_;
                  FSM___any_on_D2A.esp = FSM___any_on_D2A.ebp;
                  FSM___any_on_D2A.ebp = op_li32(FSM___any_on_D2A.esp) /*Alchemy*/;
                  FSM___any_on_D2A.esp = FSM___any_on_D2A.esp + 4;
                  FSM___any_on_D2A.esp = FSM___any_on_D2A.esp + 4;
                  return;
               }
            }
            _loc1_ = _loc4_;
         }
         if(_loc1_ <= 0)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc3_ = 0;
            while(true)
            {
               _loc4_ = _loc3_ ^ -1;
               _loc4_ = _loc1_ + _loc4_;
               _loc5_ = _loc4_ << 2;
               _loc5_ = _loc2_ + _loc5_;
               _loc5_ = op_li32(_loc5_ + 20) /*Alchemy*/;
               if(_loc5_ == 0)
               {
                  _loc3_ = _loc3_ + 1;
                  if(_loc4_ >= 1)
                  {
                     continue;
                  }
                  _loc1_ = 0;
                  break;
               }
               _loc1_ = 1;
               break;
            }
         }
         FSM___any_on_D2A.eax = _loc1_;
         FSM___any_on_D2A.esp = FSM___any_on_D2A.ebp;
         FSM___any_on_D2A.ebp = op_li32(FSM___any_on_D2A.esp) /*Alchemy*/;
         FSM___any_on_D2A.esp = FSM___any_on_D2A.esp + 4;
         FSM___any_on_D2A.esp = FSM___any_on_D2A.esp + 4;
      }
   }
}
