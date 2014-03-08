package cmodule.lua_wrapper
{
   public final class FSM_mainposition extends Machine
   {
      
      public function FSM_mainposition() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         FSM_mainposition.esp = FSM_mainposition.esp - 4;
         FSM_mainposition.ebp = FSM_mainposition.esp;
         FSM_mainposition.esp = FSM_mainposition.esp - 8;
         _loc1_ = op_li32(FSM_mainposition.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM_mainposition.ebp + 8) /*Alchemy*/;
         if(_loc2_ <= 2)
         {
            if(_loc2_ != 1)
            {
               if(_loc2_ != 2)
               {
                  _loc2_ = 1;
                  _loc4_ = op_li8(_loc3_ + 7) /*Alchemy*/;
                  _loc2_ = _loc2_ << _loc4_;
                  _loc2_ = _loc2_ + -1;
                  _loc1_ = op_li32(_loc1_) /*Alchemy*/;
                  _loc2_ = _loc2_ | 1;
                  _loc1_ = uint(_loc1_) % uint(_loc2_);
                  _loc2_ = op_li32(_loc3_ + 16) /*Alchemy*/;
                  _loc1_ = _loc1_ * 28;
                  _loc1_ = _loc2_ + _loc1_;
               }
               else
               {
                  _loc2_ = 1;
                  _loc4_ = op_li8(_loc3_ + 7) /*Alchemy*/;
                  _loc2_ = _loc2_ << _loc4_;
                  _loc2_ = _loc2_ + -1;
                  _loc1_ = op_li32(_loc1_) /*Alchemy*/;
                  _loc2_ = _loc2_ | 1;
                  _loc1_ = uint(_loc1_) % uint(_loc2_);
               }
               FSM_mainposition.eax = _loc1_;
               FSM_mainposition.esp = FSM_mainposition.ebp;
               FSM_mainposition.ebp = op_li32(FSM_mainposition.esp) /*Alchemy*/;
               FSM_mainposition.esp = FSM_mainposition.esp + 4;
               FSM_mainposition.esp = FSM_mainposition.esp + 4;
               return;
            }
            _loc2_ = 1;
            _loc4_ = op_li8(_loc3_ + 7) /*Alchemy*/;
            _loc2_ = _loc2_ << _loc4_;
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            _loc3_ = op_li32(_loc3_ + 16) /*Alchemy*/;
            _loc1_ = _loc1_ * 28;
            _loc1_ = _loc3_ + _loc1_;
            FSM_mainposition.eax = _loc1_;
            FSM_mainposition.esp = FSM_mainposition.ebp;
            FSM_mainposition.ebp = op_li32(FSM_mainposition.esp) /*Alchemy*/;
            FSM_mainposition.esp = FSM_mainposition.esp + 4;
            FSM_mainposition.esp = FSM_mainposition.esp + 4;
            return;
         }
         if(_loc2_ != 4)
         {
            if(_loc2_ == 3)
            {
               _loc6_ = 0;
               _loc7_ = op_lf64(_loc1_) /*Alchemy*/;
               _loc1_ = op_li32(FSM_mainposition.ebp + -8) /*Alchemy*/;
               _loc2_ = op_li32(FSM_mainposition.ebp + -4) /*Alchemy*/;
               if(_loc7_ == _loc6_)
               {
                  _loc1_ = op_li32(_loc3_ + 16) /*Alchemy*/;
               }
               else
               {
                  _loc4_ = 1;
                  _loc5_ = op_li8(_loc3_ + 7) /*Alchemy*/;
                  _loc4_ = _loc4_ << _loc5_;
                  _loc4_ = _loc4_ + -1;
                  _loc4_ = _loc4_ | 1;
                  _loc1_ = _loc2_ + _loc1_;
                  _loc1_ = uint(_loc1_) % uint(_loc4_);
               }
            }
            else
            {
               _loc2_ = 1;
               _loc4_ = op_li8(_loc3_ + 7) /*Alchemy*/;
               _loc2_ = _loc2_ << _loc4_;
               _loc2_ = _loc2_ + -1;
               _loc1_ = op_li32(_loc1_) /*Alchemy*/;
               _loc2_ = _loc2_ | 1;
               _loc1_ = uint(_loc1_) % uint(_loc2_);
               _loc2_ = op_li32(_loc3_ + 16) /*Alchemy*/;
               _loc1_ = _loc1_ * 28;
               _loc1_ = _loc2_ + _loc1_;
            }
            if(_loc2_ == 3)
            {
               FSM_mainposition.eax = _loc1_;
               FSM_mainposition.esp = FSM_mainposition.ebp;
               FSM_mainposition.ebp = op_li32(FSM_mainposition.esp) /*Alchemy*/;
               FSM_mainposition.esp = FSM_mainposition.esp + 4;
               FSM_mainposition.esp = FSM_mainposition.esp + 4;
               return;
            }
            FSM_mainposition.eax = _loc1_;
            FSM_mainposition.esp = FSM_mainposition.ebp;
            FSM_mainposition.ebp = op_li32(FSM_mainposition.esp) /*Alchemy*/;
            FSM_mainposition.esp = FSM_mainposition.esp + 4;
            FSM_mainposition.esp = FSM_mainposition.esp + 4;
            return;
         }
         _loc2_ = 1;
         _loc4_ = op_li8(_loc3_ + 7) /*Alchemy*/;
         _loc2_ = _loc2_ << _loc4_;
         _loc1_ = op_li32(_loc1_) /*Alchemy*/;
         _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
         _loc3_ = op_li32(_loc3_ + 16) /*Alchemy*/;
         _loc1_ = _loc1_ * 28;
         _loc1_ = _loc3_ + _loc1_;
         FSM_mainposition.eax = _loc1_;
         FSM_mainposition.esp = FSM_mainposition.ebp;
         FSM_mainposition.ebp = op_li32(FSM_mainposition.esp) /*Alchemy*/;
         FSM_mainposition.esp = FSM_mainposition.esp + 4;
         FSM_mainposition.esp = FSM_mainposition.esp + 4;
         return;
         _loc2_ = _loc2_ + -1;
         _loc1_ = _loc2_ & _loc1_;
         _loc3_ = op_li32(_loc3_ + 16) /*Alchemy*/;
         _loc1_ = _loc1_ * 28;
         _loc1_ = _loc3_ + _loc1_;
         FSM_mainposition.eax = _loc1_;
         FSM_mainposition.esp = FSM_mainposition.ebp;
         FSM_mainposition.ebp = op_li32(FSM_mainposition.esp) /*Alchemy*/;
         FSM_mainposition.esp = FSM_mainposition.esp + 4;
         FSM_mainposition.esp = FSM_mainposition.esp + 4;
      }
   }
}
