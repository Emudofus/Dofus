package cmodule.lua_wrapper
{
   public final class FSM_aux_upvalue extends Machine
   {
      
      public function FSM_aux_upvalue() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM_aux_upvalue.esp = FSM_aux_upvalue.esp - 4;
         FSM_aux_upvalue.ebp = FSM_aux_upvalue.esp;
         FSM_aux_upvalue.esp = FSM_aux_upvalue.esp - 0;
         _loc1_ = op_li32(FSM_aux_upvalue.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_aux_upvalue.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM_aux_upvalue.ebp + 16) /*Alchemy*/;
         _loc4_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         if(_loc4_ == 6)
         {
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            _loc4_ = op_li8(_loc1_ + 6) /*Alchemy*/;
            _loc5_ = _loc1_;
            if(_loc4_ != 0)
            {
               if(_loc2_ >= 1)
               {
                  _loc5_ = op_li8(_loc1_ + 7) /*Alchemy*/;
                  if(_loc5_ >= _loc2_)
                  {
                     _loc5_ = FSM_aux_upvalue;
                     _loc2_ = _loc2_ * 12;
                     _loc2_ = _loc2_ + _loc1_;
                     _loc2_ = _loc2_ + 8;
                     FSM_aux_upvalue.eax = _loc5_;
                  }
                  if(_loc5_ >= _loc2_)
                  {
                     FSM_aux_upvalue.esp = FSM_aux_upvalue.ebp;
                     FSM_aux_upvalue.ebp = op_li32(FSM_aux_upvalue.esp) /*Alchemy*/;
                     FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
                     FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
                     return;
                  }
                  FSM_aux_upvalue.esp = FSM_aux_upvalue.ebp;
                  FSM_aux_upvalue.ebp = op_li32(FSM_aux_upvalue.esp) /*Alchemy*/;
                  FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
                  FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
                  return;
               }
            }
            else
            {
               _loc1_ = op_li32(_loc5_ + 16) /*Alchemy*/;
               _loc4_ = _loc5_;
               if(_loc2_ >= 1)
               {
                  _loc5_ = op_li32(_loc1_ + 36) /*Alchemy*/;
                  if(_loc5_ >= _loc2_)
                  {
                     _loc2_ = _loc2_ + -1;
                     _loc2_ = _loc2_ << 2;
                     _loc4_ = _loc4_ + _loc2_;
                     _loc4_ = op_li32(_loc4_ + 20) /*Alchemy*/;
                     _loc4_ = op_li32(_loc4_ + 8) /*Alchemy*/;
                     _loc1_ = op_li32(_loc1_ + 28) /*Alchemy*/;
                     _loc1_ = _loc1_ + _loc2_;
                     _loc1_ = op_li32(_loc1_) /*Alchemy*/;
                     _loc1_ = _loc1_ + 16;
                  }
                  if(_loc5_ >= _loc2_)
                  {
                     FSM_aux_upvalue.eax = _loc1_;
                     FSM_aux_upvalue.esp = FSM_aux_upvalue.ebp;
                     FSM_aux_upvalue.ebp = op_li32(FSM_aux_upvalue.esp) /*Alchemy*/;
                     FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
                     FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
                     return;
                  }
                  FSM_aux_upvalue.eax = _loc1_;
                  FSM_aux_upvalue.esp = FSM_aux_upvalue.ebp;
                  FSM_aux_upvalue.ebp = op_li32(FSM_aux_upvalue.esp) /*Alchemy*/;
                  FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
                  FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
                  return;
               }
            }
         }
         _loc1_ = 0;
         FSM_aux_upvalue.eax = _loc1_;
         FSM_aux_upvalue.esp = FSM_aux_upvalue.ebp;
         FSM_aux_upvalue.ebp = op_li32(FSM_aux_upvalue.esp) /*Alchemy*/;
         FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
         FSM_aux_upvalue.esp = FSM_aux_upvalue.esp + 4;
      }
   }
}
