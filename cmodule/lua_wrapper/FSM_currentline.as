package cmodule.lua_wrapper
{
   public final class FSM_currentline extends Machine
   {
      
      public function FSM_currentline() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM_currentline.esp = FSM_currentline.esp - 4;
         FSM_currentline.ebp = FSM_currentline.esp;
         FSM_currentline.esp = FSM_currentline.esp - 0;
         _loc1_ = op_li32(FSM_currentline.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 4) /*Alchemy*/;
         _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         _loc4_ = op_li32(FSM_currentline.ebp + 8) /*Alchemy*/;
         if(_loc3_ == 6)
         {
            _loc3_ = op_li32(_loc2_) /*Alchemy*/;
            _loc3_ = op_li8(_loc3_ + 6) /*Alchemy*/;
            _loc5_ = _loc2_;
            if(_loc3_ == 0)
            {
               _loc3_ = op_li32(_loc4_ + 20) /*Alchemy*/;
               if(_loc3_ == _loc1_)
               {
                  _loc3_ = op_li32(_loc4_ + 24) /*Alchemy*/;
               }
               if(_loc3_ == _loc1_)
               {
                  _loc3_ = op_li32(_loc5_) /*Alchemy*/;
                  _loc3_ = op_li32(_loc3_ + 16) /*Alchemy*/;
                  _loc1_ = op_li32(_loc1_ + 12) /*Alchemy*/;
                  _loc3_ = op_li32(_loc3_ + 12) /*Alchemy*/;
                  _loc1_ = _loc1_ - _loc3_;
                  _loc1_ = _loc1_ >> 2;
                  _loc1_ = _loc1_ + -1;
               }
               else
               {
                  _loc3_ = op_li32(_loc5_) /*Alchemy*/;
                  _loc3_ = op_li32(_loc3_ + 16) /*Alchemy*/;
                  _loc1_ = op_li32(_loc1_ + 12) /*Alchemy*/;
                  _loc3_ = op_li32(_loc3_ + 12) /*Alchemy*/;
                  _loc1_ = _loc1_ - _loc3_;
                  _loc1_ = _loc1_ >> 2;
                  _loc1_ = _loc1_ + -1;
               }
            }
            if(_loc1_ <= -1)
            {
               _loc1_ = -1;
            }
            else
            {
               _loc2_ = op_li32(_loc2_) /*Alchemy*/;
               _loc2_ = op_li32(_loc2_ + 16) /*Alchemy*/;
               _loc2_ = op_li32(_loc2_ + 20) /*Alchemy*/;
               if(_loc2_ == 0)
               {
                  _loc1_ = 0;
               }
               else
               {
                  _loc1_ = _loc1_ << 2;
                  _loc1_ = _loc2_ + _loc1_;
                  _loc1_ = op_li32(_loc1_) /*Alchemy*/;
               }
            }
            FSM_currentline.eax = _loc1_;
            FSM_currentline.esp = FSM_currentline.ebp;
            FSM_currentline.ebp = op_li32(FSM_currentline.esp) /*Alchemy*/;
            FSM_currentline.esp = FSM_currentline.esp + 4;
            FSM_currentline.esp = FSM_currentline.esp + 4;
            return;
         }
         _loc1_ = -1;
         if(_loc1_ <= -1)
         {
            _loc1_ = -1;
         }
         else
         {
            _loc2_ = op_li32(_loc2_) /*Alchemy*/;
            _loc2_ = op_li32(_loc2_ + 16) /*Alchemy*/;
            _loc2_ = op_li32(_loc2_ + 20) /*Alchemy*/;
            if(_loc2_ == 0)
            {
               _loc1_ = 0;
            }
            else
            {
               _loc1_ = _loc1_ << 2;
               _loc1_ = _loc2_ + _loc1_;
               _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            }
         }
         FSM_currentline.eax = _loc1_;
         FSM_currentline.esp = FSM_currentline.ebp;
         FSM_currentline.ebp = op_li32(FSM_currentline.esp) /*Alchemy*/;
         FSM_currentline.esp = FSM_currentline.esp + 4;
         FSM_currentline.esp = FSM_currentline.esp + 4;
      }
   }
}
