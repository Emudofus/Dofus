package cmodule.lua_wrapper
{
   public final class FSM_dorounding extends Machine
   {
      
      public function FSM_dorounding() {
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
         var _loc8_:* = 0;
         FSM_dorounding.esp = FSM_dorounding.esp - 4;
         FSM_dorounding.ebp = FSM_dorounding.esp;
         FSM_dorounding.esp = FSM_dorounding.esp - 0;
         _loc1_ = op_li32(FSM_dorounding.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_dorounding.ebp + 12) /*Alchemy*/;
         _loc3_ = _loc1_ + _loc2_;
         _loc3_ = op_li8(_loc3_) /*Alchemy*/;
         _loc4_ = op_li32(FSM_dorounding.ebp + 16) /*Alchemy*/;
         _loc5_ = _loc3_ << 24;
         _loc6_ = _loc1_;
         _loc5_ = _loc5_ >> 24;
         if(_loc5_ <= 8)
         {
            _loc3_ = _loc3_ & 255;
            if(_loc3_ == 8)
            {
               _loc3_ = _loc2_ + _loc1_;
               _loc3_ = op_li8(_loc3_ + -1) /*Alchemy*/;
               _loc3_ = _loc3_ & 1;
               if(_loc3_ != 0)
               {
               }
            }
            FSM_dorounding.esp = FSM_dorounding.ebp;
            FSM_dorounding.ebp = op_li32(FSM_dorounding.esp) /*Alchemy*/;
            FSM_dorounding.esp = FSM_dorounding.esp + 4;
            FSM_dorounding.esp = FSM_dorounding.esp + 4;
            return;
         }
         _loc3_ = _loc2_ + -1;
         _loc5_ = _loc1_ + _loc3_;
         _loc7_ = op_li8(_loc5_) /*Alchemy*/;
         if(_loc7_ != 15)
         {
            _loc1_ = _loc5_;
            _loc4_ = _loc1_;
            _loc6_ = op_li8(_loc4_) /*Alchemy*/;
            _loc6_ = _loc6_ + 1;
         }
         else
         {
            _loc5_ = 0;
            _loc2_ = _loc6_ + _loc2_;
            _loc2_ = _loc2_ + -1;
            while(true)
            {
               _loc6_ = _loc2_;
               if(_loc3_ != _loc5_)
               {
                  _loc7_ = op_li8(_loc6_) /*Alchemy*/;
                  _loc8_ = _loc5_ ^ -1;
                  _loc7_ = _loc7_ + 1;
                  _loc8_ = _loc3_ + _loc8_;
                  _loc6_ = _loc1_ + _loc8_;
                  _loc7_ = op_li8(_loc6_) /*Alchemy*/;
                  _loc2_ = _loc2_ + -1;
                  _loc5_ = _loc5_ + 1;
                  if(_loc7_ != 15)
                  {
                     _loc1_ = _loc6_;
                     _loc4_ = _loc1_;
                     _loc6_ = op_li8(_loc4_) /*Alchemy*/;
                     _loc6_ = _loc6_ + 1;
                     break;
                  }
                  continue;
               }
               _loc1_ = 1;
               _loc1_ = op_li32(_loc4_) /*Alchemy*/;
               _loc1_ = _loc1_ + 4;
               break;
            }
         }
         if(_loc7_ != 15)
         {
            FSM_dorounding.esp = FSM_dorounding.ebp;
            FSM_dorounding.ebp = op_li32(FSM_dorounding.esp) /*Alchemy*/;
            FSM_dorounding.esp = FSM_dorounding.esp + 4;
            FSM_dorounding.esp = FSM_dorounding.esp + 4;
            return;
         }
         FSM_dorounding.esp = FSM_dorounding.ebp;
         FSM_dorounding.ebp = op_li32(FSM_dorounding.esp) /*Alchemy*/;
         FSM_dorounding.esp = FSM_dorounding.esp + 4;
         FSM_dorounding.esp = FSM_dorounding.esp + 4;
      }
   }
}
