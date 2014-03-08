package cmodule.lua_wrapper
{
   public final class FSM_load_aux extends Machine
   {
      
      public function FSM_load_aux() {
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
         var _loc8_:* = NaN;
         FSM_load_aux.esp = FSM_load_aux.esp - 4;
         FSM_load_aux.ebp = FSM_load_aux.esp;
         FSM_load_aux.esp = FSM_load_aux.esp - 0;
         _loc1_ = op_li32(FSM_load_aux.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_load_aux.ebp + 12) /*Alchemy*/;
         if(_loc2_ != 0)
         {
            _loc2_ = 0;
            _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc2_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc2_ = _loc2_ + 12;
            FSM_load_aux.esp = FSM_load_aux.esp - 8;
            _loc2_ = -2;
            FSM_load_aux.esp = FSM_load_aux.esp - 4;
            FSM_load_aux.start();
            _loc2_ = FSM_load_aux.eax;
            FSM_load_aux.esp = FSM_load_aux.esp + 8;
            _loc3_ = op_li32(_loc1_ + 8) /*Alchemy*/;
            _loc1_ = _loc1_ + 8;
            _loc4_ = _loc3_;
            if(uint(_loc3_) > uint(_loc2_))
            {
               _loc5_ = 0;
               while(true)
               {
                  _loc6_ = _loc5_ ^ -1;
                  _loc6_ = _loc6_ * 12;
                  _loc6_ = _loc4_ + _loc6_;
                  _loc8_ = op_lf64(_loc6_) /*Alchemy*/;
                  _loc7_ = op_li32(_loc6_ + 8) /*Alchemy*/;
                  _loc3_ = _loc3_ + -12;
                  _loc5_ = _loc5_ + 1;
                  if(uint(_loc6_) > uint(_loc2_))
                  {
                     continue;
                  }
                  break;
               }
            }
            if(uint(_loc3_) > uint(_loc2_))
            {
               _loc3_ = 2;
               _loc1_ = op_li32(_loc1_) /*Alchemy*/;
               _loc8_ = op_lf64(_loc1_) /*Alchemy*/;
               _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               FSM_load_aux.eax = _loc3_;
            }
            else
            {
               _loc3_ = 2;
               _loc1_ = op_li32(_loc1_) /*Alchemy*/;
               _loc8_ = op_lf64(_loc1_) /*Alchemy*/;
               _loc1_ = op_li32(_loc1_ + 8) /*Alchemy*/;
               FSM_load_aux.eax = _loc3_;
            }
         }
         else
         {
            _loc1_ = 1;
            FSM_load_aux.eax = _loc1_;
         }
         if(_loc2_ != 0)
         {
            FSM_load_aux.esp = FSM_load_aux.ebp;
            FSM_load_aux.ebp = op_li32(FSM_load_aux.esp) /*Alchemy*/;
            FSM_load_aux.esp = FSM_load_aux.esp + 4;
            FSM_load_aux.esp = FSM_load_aux.esp + 4;
            return;
         }
         FSM_load_aux.esp = FSM_load_aux.ebp;
         FSM_load_aux.ebp = op_li32(FSM_load_aux.esp) /*Alchemy*/;
         FSM_load_aux.esp = FSM_load_aux.esp + 4;
         FSM_load_aux.esp = FSM_load_aux.esp + 4;
      }
   }
}
