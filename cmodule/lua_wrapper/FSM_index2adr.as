package cmodule.lua_wrapper
{
   public final class FSM_index2adr extends Machine
   {
      
      public function FSM_index2adr() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         FSM_index2adr.esp = FSM_index2adr.esp - 4;
         FSM_index2adr.ebp = FSM_index2adr.esp;
         FSM_index2adr.esp = FSM_index2adr.esp - 0;
         _loc1_ = op_li32(FSM_index2adr.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_index2adr.ebp + 12) /*Alchemy*/;
         if(_loc2_ >= 1)
         {
            _loc3_ = FSM_index2adr;
            _loc4_ = op_li32(_loc1_ + 12) /*Alchemy*/;
            _loc2_ = _loc2_ * 12;
            _loc2_ = _loc2_ + _loc4_;
            _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc2_ = _loc2_ + -12;
            _loc1_ = uint(_loc1_) > uint(_loc2_)?_loc2_:_loc3_;
         }
         else
         {
            if(_loc2_ >= -9999)
            {
               _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               _loc2_ = _loc2_ * 12;
               _loc1_ = _loc1_ + _loc2_;
            }
            else
            {
               if(_loc2_ != -10002)
               {
                  if(_loc2_ != -10001)
                  {
                     if(_loc2_ == -10000)
                     {
                        _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
                        _loc1_ = _loc1_ + 92;
                     }
                     else
                     {
                        _loc1_ = op_li32(_loc1_ + 20) /*Alchemy*/;
                        _loc1_ = op_li32(_loc1_ + 4) /*Alchemy*/;
                        _loc1_ = op_li32(_loc1_) /*Alchemy*/;
                        _loc3_ = op_li8(_loc1_ + 7) /*Alchemy*/;
                        _loc2_ = -10002 - _loc2_;
                        if(_loc3_ >= _loc2_)
                        {
                           _loc2_ = _loc2_ * 12;
                           _loc1_ = _loc2_ + _loc1_;
                           _loc1_ = _loc1_ + 8;
                        }
                        else
                        {
                           _loc1_ = FSM_index2adr;
                        }
                     }
                  }
                  else
                  {
                     _loc2_ = 5;
                     _loc3_ = op_li32(_loc1_ + 20) /*Alchemy*/;
                     _loc3_ = op_li32(_loc3_ + 4) /*Alchemy*/;
                     _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                     _loc3_ = op_li32(_loc3_ + 12) /*Alchemy*/;
                     _loc1_ = _loc1_ + 84;
                  }
                  if(_loc2_ != -10001)
                  {
                  }
               }
               else
               {
                  _loc1_ = _loc1_ + 72;
               }
            }
         }
         FSM_index2adr.eax = _loc1_;
         FSM_index2adr.esp = FSM_index2adr.ebp;
         FSM_index2adr.ebp = op_li32(FSM_index2adr.esp) /*Alchemy*/;
         FSM_index2adr.esp = FSM_index2adr.esp + 4;
         FSM_index2adr.esp = FSM_index2adr.esp + 4;
      }
   }
}
