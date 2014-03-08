package cmodule.lua_wrapper
{
   public final class FSM___rshift_D2A extends Machine
   {
      
      public function FSM___rshift_D2A() {
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
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         FSM___rshift_D2A.esp = FSM___rshift_D2A.esp - 4;
         FSM___rshift_D2A.ebp = FSM___rshift_D2A.esp;
         FSM___rshift_D2A.esp = FSM___rshift_D2A.esp - 0;
         _loc1_ = op_li32(FSM___rshift_D2A.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM___rshift_D2A.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(_loc1_ + 16) /*Alchemy*/;
         _loc4_ = _loc1_ + 16;
         _loc5_ = _loc2_ >> 5;
         _loc6_ = _loc1_ + 20;
         _loc7_ = _loc1_;
         if(_loc3_ <= _loc5_)
         {
            _loc2_ = _loc6_;
         }
         else
         {
            _loc2_ = _loc2_ & 31;
            if(_loc2_ == 0)
            {
               if(_loc5_ < _loc3_)
               {
                  _loc2_ = 0;
                  _loc8_ = _loc5_ << 2;
                  _loc7_ = _loc7_ + 20;
                  while(true)
                  {
                     _loc9_ = _loc8_ + _loc7_;
                     _loc9_ = op_li32(_loc9_) /*Alchemy*/;
                     _loc7_ = _loc7_ + 4;
                     _loc2_ = _loc2_ + 1;
                     _loc9_ = _loc5_ + _loc2_;
                     if(_loc9_ < _loc3_)
                     {
                        continue;
                     }
                     break;
                  }
                  _loc2_ = _loc2_ << 2;
                  _loc2_ = _loc1_ + _loc2_;
                  _loc2_ = _loc2_ + 20;
               }
               else
               {
                  _loc2_ = _loc6_;
               }
               if(_loc5_ < _loc3_)
               {
               }
            }
            else
            {
               _loc8_ = _loc5_ << 2;
               _loc8_ = _loc1_ + _loc8_;
               _loc8_ = op_li32(_loc8_ + 20) /*Alchemy*/;
               _loc8_ = _loc8_ >>> _loc2_;
               _loc9_ = 32 - _loc2_;
               _loc10_ = _loc5_ + 1;
               if(_loc10_ >= _loc3_)
               {
                  _loc2_ = _loc6_;
                  _loc7_ = _loc8_;
               }
               else
               {
                  _loc10_ = 0;
                  _loc11_ = _loc5_ << 2;
                  _loc5_ = _loc5_ + 1;
                  while(true)
                  {
                     _loc12_ = _loc11_ + _loc7_;
                     _loc13_ = op_li32(_loc12_ + 24) /*Alchemy*/;
                     _loc13_ = _loc13_ << _loc9_;
                     _loc8_ = _loc13_ | _loc8_;
                     _loc8_ = op_li32(_loc12_ + 24) /*Alchemy*/;
                     _loc7_ = _loc7_ + 4;
                     _loc10_ = _loc10_ + 1;
                     _loc8_ = _loc8_ >>> _loc2_;
                     _loc12_ = _loc5_ + _loc10_;
                     if(_loc12_ < _loc3_)
                     {
                        continue;
                     }
                     break;
                  }
                  _loc2_ = _loc10_ << 2;
                  _loc2_ = _loc1_ + _loc2_;
                  _loc2_ = _loc2_ + 20;
                  _loc7_ = _loc8_;
               }
               if(_loc10_ >= _loc3_)
               {
                  _loc3_ = _loc7_;
                  if(_loc3_ != 0)
                  {
                     _loc2_ = _loc2_ + 4;
                  }
               }
               else
               {
                  _loc3_ = _loc7_;
                  if(_loc3_ != 0)
                  {
                     _loc2_ = _loc2_ + 4;
                  }
               }
            }
         }
         _loc1_ = _loc1_ + 20;
         _loc1_ = _loc2_ - _loc1_;
         _loc2_ = _loc1_ >> 2;
         if(uint(_loc1_) <= uint(3))
         {
            _loc1_ = 0;
         }
         if(uint(_loc1_) <= uint(3))
         {
            FSM___rshift_D2A.esp = FSM___rshift_D2A.ebp;
            FSM___rshift_D2A.ebp = op_li32(FSM___rshift_D2A.esp) /*Alchemy*/;
            FSM___rshift_D2A.esp = FSM___rshift_D2A.esp + 4;
            FSM___rshift_D2A.esp = FSM___rshift_D2A.esp + 4;
            return;
         }
         FSM___rshift_D2A.esp = FSM___rshift_D2A.ebp;
         FSM___rshift_D2A.ebp = op_li32(FSM___rshift_D2A.esp) /*Alchemy*/;
         FSM___rshift_D2A.esp = FSM___rshift_D2A.esp + 4;
         FSM___rshift_D2A.esp = FSM___rshift_D2A.esp + 4;
      }
   }
}
