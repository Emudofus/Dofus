package cmodule.lua_wrapper
{
   public final class FSM_patchtestreg395396 extends Machine
   {
      
      public function FSM_patchtestreg395396() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM_patchtestreg395396.esp = FSM_patchtestreg395396.esp - 4;
         FSM_patchtestreg395396.ebp = FSM_patchtestreg395396.esp;
         FSM_patchtestreg395396.esp = FSM_patchtestreg395396.esp - 0;
         _loc1_ = op_li32(FSM_patchtestreg395396.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM_patchtestreg395396.ebp + 8) /*Alchemy*/;
         _loc3_ = _loc1_ << 2;
         _loc4_ = op_li32(FSM_patchtestreg395396.ebp + 16) /*Alchemy*/;
         _loc3_ = _loc2_ + _loc3_;
         if(_loc1_ <= 0)
         {
            _loc1_ = _loc3_;
         }
         else
         {
            _loc5_ = FSM_patchtestreg395396;
            _loc1_ = _loc1_ << 2;
            _loc1_ = _loc1_ + _loc2_;
            _loc2_ = op_li32(_loc1_ + -4) /*Alchemy*/;
            _loc2_ = _loc2_ & 63;
            _loc2_ = _loc5_ + _loc2_;
            _loc2_ = op_li8(_loc2_) /*Alchemy*/;
            _loc2_ = _loc2_ << 24;
            _loc2_ = _loc2_ >> 24;
            _loc1_ = _loc1_ + -4;
            _loc1_ = _loc2_ > -1?_loc3_:_loc1_;
         }
         _loc2_ = op_li32(_loc1_) /*Alchemy*/;
         _loc3_ = _loc2_ & 63;
         if(_loc3_ == 27)
         {
            if(_loc4_ != 255)
            {
               _loc3_ = _loc2_ >>> 23;
               if(_loc3_ != _loc4_)
               {
                  _loc3_ = 1;
                  _loc4_ = _loc4_ << 6;
                  _loc4_ = _loc4_ & 16320;
                  _loc2_ = _loc2_ & -16321;
                  _loc2_ = _loc2_ | _loc4_;
               }
               FSM_patchtestreg395396.eax = _loc3_;
            }
            if(_loc4_ != 255)
            {
               _loc3_ = 1;
               _loc4_ = _loc2_ | 26;
               _loc2_ = _loc2_ >>> 17;
               _loc4_ = _loc4_ & 8372250;
               _loc2_ = _loc2_ & 32704;
               _loc2_ = _loc4_ | _loc2_;
               FSM_patchtestreg395396.eax = _loc3_;
            }
            else
            {
               _loc3_ = 1;
               _loc4_ = _loc2_ | 26;
               _loc2_ = _loc2_ >>> 17;
               _loc4_ = _loc4_ & 8372250;
               _loc2_ = _loc2_ & 32704;
               _loc2_ = _loc4_ | _loc2_;
               FSM_patchtestreg395396.eax = _loc3_;
            }
         }
         else
         {
            _loc1_ = 0;
            FSM_patchtestreg395396.eax = _loc1_;
         }
         FSM_patchtestreg395396.esp = FSM_patchtestreg395396.ebp;
         FSM_patchtestreg395396.ebp = op_li32(FSM_patchtestreg395396.esp) /*Alchemy*/;
         FSM_patchtestreg395396.esp = FSM_patchtestreg395396.esp + 4;
         FSM_patchtestreg395396.esp = FSM_patchtestreg395396.esp + 4;
      }
   }
}
