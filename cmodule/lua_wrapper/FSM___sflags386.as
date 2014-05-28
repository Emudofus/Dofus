package cmodule.lua_wrapper
{
   public final class FSM___sflags386 extends Machine
   {
      
      public function FSM___sflags386() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         FSM___sflags386.esp = FSM___sflags386.esp - 4;
         FSM___sflags386.ebp = FSM___sflags386.esp;
         FSM___sflags386.esp = FSM___sflags386.esp - 0;
         _loc1_ = op_sxi_8(op_li8(FSM___sflags386.ebp + 12) /*Alchemy*/) /*Alchemy*/;
         _loc2_ = op_sxi_8(op_li8(FSM___sflags386.ebp + 16) /*Alchemy*/) /*Alchemy*/;
         _loc3_ = op_li32(FSM___sflags386.ebp + 20) /*Alchemy*/;
         _loc4_ = op_sxi_8(op_li8(FSM___sflags386.ebp + 8) /*Alchemy*/) /*Alchemy*/;
         if(_loc4_ != 97)
         {
            if(_loc4_ != 114)
            {
               if(_loc4_ == 119)
               {
                  _loc4_ = _loc1_ & 255;
                  if(_loc4_ != 43)
                  {
                     _loc4_ = 8;
                     _loc5_ = 1536;
                     _loc6_ = 1;
                     _loc1_ = _loc1_ & 255;
                     if(_loc1_ == 98)
                     {
                        _loc1_ = _loc2_ & 255;
                        if(_loc1_ == 43)
                        {
                           _loc1_ = _loc5_;
                        }
                     }
                     _loc1_ = _loc5_ | _loc6_;
                     FSM___sflags386.eax = _loc4_;
                  }
                  else
                  {
                     _loc1_ = 1536;
                  }
                  if(_loc4_ != 43)
                  {
                  }
               }
               else
               {
                  _loc1_ = 22;
                  _loc1_ = 0;
                  FSM___sflags386.eax = _loc1_;
               }
               if(_loc4_ == 119)
               {
                  FSM___sflags386.esp = FSM___sflags386.ebp;
                  FSM___sflags386.ebp = op_li32(FSM___sflags386.esp) /*Alchemy*/;
                  FSM___sflags386.esp = FSM___sflags386.esp + 4;
                  FSM___sflags386.esp = FSM___sflags386.esp + 4;
                  return;
               }
               FSM___sflags386.esp = FSM___sflags386.ebp;
               FSM___sflags386.ebp = op_li32(FSM___sflags386.esp) /*Alchemy*/;
               FSM___sflags386.esp = FSM___sflags386.esp + 4;
               FSM___sflags386.esp = FSM___sflags386.esp + 4;
               return;
            }
            _loc4_ = _loc1_ & 255;
            if(_loc4_ != 43)
            {
               _loc4_ = 4;
               _loc5_ = 0;
               _loc6_ = _loc5_;
               _loc1_ = _loc1_ & 255;
               if(_loc1_ == 98)
               {
                  _loc1_ = _loc2_ & 255;
                  if(_loc1_ == 43)
                  {
                     _loc1_ = _loc5_;
                  }
                  FSM___sflags386.esp = FSM___sflags386.ebp;
                  FSM___sflags386.ebp = op_li32(FSM___sflags386.esp) /*Alchemy*/;
                  FSM___sflags386.esp = FSM___sflags386.esp + 4;
                  FSM___sflags386.esp = FSM___sflags386.esp + 4;
                  return;
               }
               _loc1_ = _loc5_ | _loc6_;
               FSM___sflags386.eax = _loc4_;
               FSM___sflags386.esp = FSM___sflags386.ebp;
               FSM___sflags386.ebp = op_li32(FSM___sflags386.esp) /*Alchemy*/;
               FSM___sflags386.esp = FSM___sflags386.esp + 4;
               FSM___sflags386.esp = FSM___sflags386.esp + 4;
               return;
            }
            _loc1_ = 0;
            if(_loc4_ != 43)
            {
            }
         }
         else
         {
            _loc4_ = _loc1_ & 255;
            if(_loc4_ != 43)
            {
               _loc4_ = 8;
               _loc5_ = 520;
               _loc6_ = 1;
               _loc1_ = _loc1_ & 255;
               if(_loc1_ == 98)
               {
                  _loc1_ = _loc2_ & 255;
                  if(_loc1_ == 43)
                  {
                     _loc1_ = _loc5_;
                  }
                  FSM___sflags386.esp = FSM___sflags386.ebp;
                  FSM___sflags386.ebp = op_li32(FSM___sflags386.esp) /*Alchemy*/;
                  FSM___sflags386.esp = FSM___sflags386.esp + 4;
                  FSM___sflags386.esp = FSM___sflags386.esp + 4;
                  return;
               }
               _loc1_ = _loc5_ | _loc6_;
               FSM___sflags386.eax = _loc4_;
               FSM___sflags386.esp = FSM___sflags386.ebp;
               FSM___sflags386.ebp = op_li32(FSM___sflags386.esp) /*Alchemy*/;
               FSM___sflags386.esp = FSM___sflags386.esp + 4;
               FSM___sflags386.esp = FSM___sflags386.esp + 4;
               return;
            }
            _loc1_ = 520;
            if(_loc4_ != 43)
            {
            }
         }
         _loc4_ = _loc1_;
         _loc5_ = 16;
         _loc4_ = _loc4_ | 2;
         FSM___sflags386.eax = _loc5_;
         FSM___sflags386.esp = FSM___sflags386.ebp;
         FSM___sflags386.ebp = op_li32(FSM___sflags386.esp) /*Alchemy*/;
         FSM___sflags386.esp = FSM___sflags386.esp + 4;
         FSM___sflags386.esp = FSM___sflags386.esp + 4;
      }
   }
}
