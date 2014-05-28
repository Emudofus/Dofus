package cmodule.lua_wrapper
{
   public final class FSM_findlocal extends Machine
   {
      
      public function FSM_findlocal() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         FSM_findlocal.esp = FSM_findlocal.esp - 4;
         FSM_findlocal.ebp = FSM_findlocal.esp;
         FSM_findlocal.esp = FSM_findlocal.esp - 0;
         _loc1_ = op_li32(FSM_findlocal.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 4) /*Alchemy*/;
         _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
         _loc4_ = op_li32(FSM_findlocal.ebp + 8) /*Alchemy*/;
         _loc5_ = op_li32(FSM_findlocal.ebp + 16) /*Alchemy*/;
         if(_loc3_ == 6)
         {
            _loc6_ = op_li32(_loc2_) /*Alchemy*/;
            _loc7_ = op_li8(_loc6_ + 6) /*Alchemy*/;
            if(_loc7_ == 0)
            {
               _loc6_ = op_li32(_loc6_ + 16) /*Alchemy*/;
            }
            if(_loc6_ != 0)
            {
               if(_loc3_ == 6)
               {
                  _loc3_ = op_li32(_loc2_) /*Alchemy*/;
                  _loc3_ = op_li8(_loc3_ + 6) /*Alchemy*/;
                  if(_loc3_ == 0)
                  {
                     _loc3_ = op_li32(_loc4_ + 20) /*Alchemy*/;
                     if(_loc3_ == _loc1_)
                     {
                        _loc3_ = op_li32(_loc4_ + 24) /*Alchemy*/;
                     }
                     if(_loc3_ == _loc1_)
                     {
                        _loc2_ = op_li32(_loc2_) /*Alchemy*/;
                        _loc2_ = op_li32(_loc2_ + 16) /*Alchemy*/;
                        _loc3_ = op_li32(_loc1_ + 12) /*Alchemy*/;
                        _loc2_ = op_li32(_loc2_ + 12) /*Alchemy*/;
                        _loc2_ = _loc3_ - _loc2_;
                        _loc2_ = _loc2_ >> 2;
                        _loc2_ = _loc2_ + -1;
                     }
                     else
                     {
                        _loc2_ = op_li32(_loc2_) /*Alchemy*/;
                        _loc2_ = op_li32(_loc2_ + 16) /*Alchemy*/;
                        _loc3_ = op_li32(_loc1_ + 12) /*Alchemy*/;
                        _loc2_ = op_li32(_loc2_ + 12) /*Alchemy*/;
                        _loc2_ = _loc3_ - _loc2_;
                        _loc2_ = _loc2_ >> 2;
                        _loc2_ = _loc2_ + -1;
                     }
                  }
                  _loc3_ = op_li32(_loc6_ + 24) /*Alchemy*/;
                  _loc6_ = op_li32(_loc6_ + 56) /*Alchemy*/;
                  FSM_findlocal.esp = FSM_findlocal.esp - 16;
                  FSM_findlocal.esp = FSM_findlocal.esp - 4;
                  FSM_findlocal.start();
                  _loc2_ = FSM_findlocal.eax;
                  FSM_findlocal.esp = FSM_findlocal.esp + 16;
                  if(_loc2_ == 0)
                  {
                  }
                  FSM_findlocal.eax = _loc2_;
                  FSM_findlocal.esp = FSM_findlocal.ebp;
                  FSM_findlocal.ebp = op_li32(FSM_findlocal.esp) /*Alchemy*/;
                  FSM_findlocal.esp = FSM_findlocal.esp + 4;
                  FSM_findlocal.esp = FSM_findlocal.esp + 4;
                  return;
               }
               if(_loc3_ != 6)
               {
                  _loc2_ = -1;
                  _loc3_ = op_li32(_loc6_ + 24) /*Alchemy*/;
                  _loc6_ = op_li32(_loc6_ + 56) /*Alchemy*/;
                  FSM_findlocal.esp = FSM_findlocal.esp - 16;
                  FSM_findlocal.esp = FSM_findlocal.esp - 4;
                  FSM_findlocal.start();
                  _loc2_ = FSM_findlocal.eax;
                  FSM_findlocal.esp = FSM_findlocal.esp + 16;
                  if(_loc2_ == 0)
                  {
                  }
                  FSM_findlocal.eax = _loc2_;
                  FSM_findlocal.esp = FSM_findlocal.ebp;
                  FSM_findlocal.ebp = op_li32(FSM_findlocal.esp) /*Alchemy*/;
                  FSM_findlocal.esp = FSM_findlocal.esp + 4;
                  FSM_findlocal.esp = FSM_findlocal.esp + 4;
                  return;
               }
               _loc2_ = -1;
               _loc3_ = op_li32(_loc6_ + 24) /*Alchemy*/;
               _loc6_ = op_li32(_loc6_ + 56) /*Alchemy*/;
               FSM_findlocal.esp = FSM_findlocal.esp - 16;
               FSM_findlocal.esp = FSM_findlocal.esp - 4;
               FSM_findlocal.start();
               _loc2_ = FSM_findlocal.eax;
               FSM_findlocal.esp = FSM_findlocal.esp + 16;
               if(_loc2_ == 0)
               {
               }
               FSM_findlocal.eax = _loc2_;
               FSM_findlocal.esp = FSM_findlocal.ebp;
               FSM_findlocal.ebp = op_li32(FSM_findlocal.esp) /*Alchemy*/;
               FSM_findlocal.esp = FSM_findlocal.esp + 4;
               FSM_findlocal.esp = FSM_findlocal.esp + 4;
               return;
            }
            _loc2_ = op_li32(_loc4_ + 20) /*Alchemy*/;
            if(_loc2_ == _loc1_)
            {
               _loc2_ = _loc4_ + 8;
            }
            else
            {
               _loc2_ = _loc1_ + 28;
            }
            _loc3_ = FSM_findlocal;
            _loc2_ = op_li32(_loc2_) /*Alchemy*/;
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            _loc2_ = _loc2_ - _loc1_;
            _loc2_ = _loc2_ / 12;
            _loc2_ = _loc2_ >= _loc5_?1:0;
            _loc1_ = _loc5_ > 0?1:0;
            _loc2_ = _loc2_ & _loc1_;
            _loc2_ = _loc2_ & 1;
            _loc2_ = _loc2_ != 0?_loc3_:0;
            FSM_findlocal.eax = _loc2_;
            FSM_findlocal.esp = FSM_findlocal.ebp;
            FSM_findlocal.ebp = op_li32(FSM_findlocal.esp) /*Alchemy*/;
            FSM_findlocal.esp = FSM_findlocal.esp + 4;
            FSM_findlocal.esp = FSM_findlocal.esp + 4;
            return;
         }
         _loc6_ = 0;
         if(_loc6_ != 0)
         {
            if(_loc3_ == 6)
            {
               _loc3_ = op_li32(_loc2_) /*Alchemy*/;
               _loc3_ = op_li8(_loc3_ + 6) /*Alchemy*/;
               if(_loc3_ == 0)
               {
                  _loc3_ = op_li32(_loc4_ + 20) /*Alchemy*/;
                  if(_loc3_ == _loc1_)
                  {
                     _loc3_ = op_li32(_loc4_ + 24) /*Alchemy*/;
                  }
                  if(_loc3_ == _loc1_)
                  {
                     _loc2_ = op_li32(_loc2_) /*Alchemy*/;
                     _loc2_ = op_li32(_loc2_ + 16) /*Alchemy*/;
                     _loc3_ = op_li32(_loc1_ + 12) /*Alchemy*/;
                     _loc2_ = op_li32(_loc2_ + 12) /*Alchemy*/;
                     _loc2_ = _loc3_ - _loc2_;
                     _loc2_ = _loc2_ >> 2;
                     _loc2_ = _loc2_ + -1;
                  }
                  else
                  {
                     _loc2_ = op_li32(_loc2_) /*Alchemy*/;
                     _loc2_ = op_li32(_loc2_ + 16) /*Alchemy*/;
                     _loc3_ = op_li32(_loc1_ + 12) /*Alchemy*/;
                     _loc2_ = op_li32(_loc2_ + 12) /*Alchemy*/;
                     _loc2_ = _loc3_ - _loc2_;
                     _loc2_ = _loc2_ >> 2;
                     _loc2_ = _loc2_ + -1;
                  }
               }
               _loc3_ = op_li32(_loc6_ + 24) /*Alchemy*/;
               _loc6_ = op_li32(_loc6_ + 56) /*Alchemy*/;
               FSM_findlocal.esp = FSM_findlocal.esp - 16;
               FSM_findlocal.esp = FSM_findlocal.esp - 4;
               FSM_findlocal.start();
               _loc2_ = FSM_findlocal.eax;
               FSM_findlocal.esp = FSM_findlocal.esp + 16;
               if(_loc2_ == 0)
               {
               }
               FSM_findlocal.eax = _loc2_;
               FSM_findlocal.esp = FSM_findlocal.ebp;
               FSM_findlocal.ebp = op_li32(FSM_findlocal.esp) /*Alchemy*/;
               FSM_findlocal.esp = FSM_findlocal.esp + 4;
               FSM_findlocal.esp = FSM_findlocal.esp + 4;
               return;
            }
            if(_loc3_ != 6)
            {
               _loc2_ = -1;
               _loc3_ = op_li32(_loc6_ + 24) /*Alchemy*/;
               _loc6_ = op_li32(_loc6_ + 56) /*Alchemy*/;
               FSM_findlocal.esp = FSM_findlocal.esp - 16;
               FSM_findlocal.esp = FSM_findlocal.esp - 4;
               FSM_findlocal.start();
               _loc2_ = FSM_findlocal.eax;
               FSM_findlocal.esp = FSM_findlocal.esp + 16;
               if(_loc2_ == 0)
               {
               }
               FSM_findlocal.eax = _loc2_;
               FSM_findlocal.esp = FSM_findlocal.ebp;
               FSM_findlocal.ebp = op_li32(FSM_findlocal.esp) /*Alchemy*/;
               FSM_findlocal.esp = FSM_findlocal.esp + 4;
               FSM_findlocal.esp = FSM_findlocal.esp + 4;
               return;
            }
            _loc2_ = -1;
            _loc3_ = op_li32(_loc6_ + 24) /*Alchemy*/;
            _loc6_ = op_li32(_loc6_ + 56) /*Alchemy*/;
            FSM_findlocal.esp = FSM_findlocal.esp - 16;
            FSM_findlocal.esp = FSM_findlocal.esp - 4;
            FSM_findlocal.start();
            _loc2_ = FSM_findlocal.eax;
            FSM_findlocal.esp = FSM_findlocal.esp + 16;
            if(_loc2_ == 0)
            {
            }
            FSM_findlocal.eax = _loc2_;
            FSM_findlocal.esp = FSM_findlocal.ebp;
            FSM_findlocal.ebp = op_li32(FSM_findlocal.esp) /*Alchemy*/;
            FSM_findlocal.esp = FSM_findlocal.esp + 4;
            FSM_findlocal.esp = FSM_findlocal.esp + 4;
            return;
         }
         _loc2_ = op_li32(_loc4_ + 20) /*Alchemy*/;
         if(_loc2_ == _loc1_)
         {
            _loc2_ = _loc4_ + 8;
         }
         else
         {
            _loc2_ = _loc1_ + 28;
         }
         _loc3_ = FSM_findlocal;
         _loc2_ = op_li32(_loc2_) /*Alchemy*/;
         _loc1_ = op_li32(_loc1_) /*Alchemy*/;
         _loc2_ = _loc2_ - _loc1_;
         _loc2_ = _loc2_ / 12;
         _loc2_ = _loc2_ >= _loc5_?1:0;
         _loc1_ = _loc5_ > 0?1:0;
         _loc2_ = _loc2_ & _loc1_;
         _loc2_ = _loc2_ & 1;
         _loc2_ = _loc2_ != 0?_loc3_:0;
         FSM_findlocal.eax = _loc2_;
         FSM_findlocal.esp = FSM_findlocal.ebp;
         FSM_findlocal.ebp = op_li32(FSM_findlocal.esp) /*Alchemy*/;
         FSM_findlocal.esp = FSM_findlocal.esp + 4;
         FSM_findlocal.esp = FSM_findlocal.esp + 4;
      }
   }
}
