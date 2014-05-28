package cmodule.lua_wrapper
{
   public final class FSM___ucmpdi2 extends Machine
   {
      
      public function FSM___ucmpdi2() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM___ucmpdi2.esp = FSM___ucmpdi2.esp - 4;
         FSM___ucmpdi2.ebp = FSM___ucmpdi2.esp;
         FSM___ucmpdi2.esp = FSM___ucmpdi2.esp - 0;
         _loc1_ = op_li32(FSM___ucmpdi2.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM___ucmpdi2.ebp + 20) /*Alchemy*/;
         _loc3_ = op_li32(FSM___ucmpdi2.ebp + 8) /*Alchemy*/;
         _loc4_ = op_li32(FSM___ucmpdi2.ebp + 16) /*Alchemy*/;
         _loc5_ = _loc2_;
         _loc5_ = _loc1_;
         if(uint(_loc1_) >= uint(_loc2_))
         {
            if(uint(_loc1_) > uint(_loc2_))
            {
               _loc1_ = 2;
            }
            else
            {
               _loc1_ = _loc4_;
               _loc2_ = _loc3_;
               if(uint(_loc3_) >= uint(_loc4_))
               {
                  _loc1_ = uint(_loc2_) > uint(_loc1_)?2:1;
               }
            }
            FSM___ucmpdi2.eax = _loc1_;
            FSM___ucmpdi2.esp = FSM___ucmpdi2.ebp;
            FSM___ucmpdi2.ebp = op_li32(FSM___ucmpdi2.esp) /*Alchemy*/;
            FSM___ucmpdi2.esp = FSM___ucmpdi2.esp + 4;
            FSM___ucmpdi2.esp = FSM___ucmpdi2.esp + 4;
            return;
         }
         _loc1_ = 0;
         FSM___ucmpdi2.eax = _loc1_;
         FSM___ucmpdi2.esp = FSM___ucmpdi2.ebp;
         FSM___ucmpdi2.ebp = op_li32(FSM___ucmpdi2.esp) /*Alchemy*/;
         FSM___ucmpdi2.esp = FSM___ucmpdi2.esp + 4;
         FSM___ucmpdi2.esp = FSM___ucmpdi2.esp + 4;
      }
   }
}
