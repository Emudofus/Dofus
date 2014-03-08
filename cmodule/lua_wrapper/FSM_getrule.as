package cmodule.lua_wrapper
{
   public final class FSM_getrule extends Machine
   {
      
      public function FSM_getrule() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM_getrule.esp = FSM_getrule.esp - 4;
         FSM_getrule.ebp = FSM_getrule.esp;
         FSM_getrule.esp = FSM_getrule.esp - 0;
         _loc1_ = op_li32(FSM_getrule.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li8(_loc1_) /*Alchemy*/;
         _loc3_ = op_li32(FSM_getrule.ebp + 12) /*Alchemy*/;
         if(_loc2_ != 77)
         {
            _loc4_ = _loc2_ & 255;
            if(_loc4_ == 74)
            {
               _loc2_ = 0;
               FSM_getrule.esp = FSM_getrule.esp - 16;
               _loc2_ = 365;
               _loc4_ = _loc3_ + 4;
               _loc1_ = _loc1_ + 1;
               _loc5_ = 1;
               FSM_getrule.esp = FSM_getrule.esp - 4;
               FSM_getrule.start();
               _loc1_ = FSM_getrule.eax;
               FSM_getrule.esp = FSM_getrule.esp + 16;
               if(_loc1_ != 0)
               {
                  _loc2_ = op_li8(_loc1_) /*Alchemy*/;
                  if(_loc2_ == 47)
                  {
                     FSM_getrule.esp = FSM_getrule.esp - 8;
                     _loc3_ = _loc3_ + 16;
                     _loc1_ = _loc1_ + 1;
                     FSM_getrule.esp = FSM_getrule.esp - 4;
                     FSM_getrule.start();
                     _loc1_ = FSM_getrule.eax;
                     FSM_getrule.esp = FSM_getrule.esp + 8;
                  }
                  else
                  {
                     _loc2_ = 7200;
                  }
                  if(_loc2_ == 47)
                  {
                  }
               }
               FSM_getrule.eax = _loc1_;
               FSM_getrule.esp = FSM_getrule.ebp;
               FSM_getrule.ebp = op_li32(FSM_getrule.esp) /*Alchemy*/;
               FSM_getrule.esp = FSM_getrule.esp + 4;
               FSM_getrule.esp = FSM_getrule.esp + 4;
               return;
            }
            _loc2_ = _loc2_ << 24;
            _loc2_ = _loc2_ >> 24;
            _loc2_ = _loc2_ + -48;
            if(uint(_loc2_) <= uint(9))
            {
               _loc2_ = 1;
               FSM_getrule.esp = FSM_getrule.esp - 16;
               _loc2_ = 365;
               _loc4_ = 0;
               _loc5_ = _loc3_ + 4;
               FSM_getrule.esp = FSM_getrule.esp - 4;
               FSM_getrule.start();
               _loc1_ = FSM_getrule.eax;
               FSM_getrule.esp = FSM_getrule.esp + 16;
               if(_loc1_ != 0)
               {
                  _loc2_ = op_li8(_loc1_) /*Alchemy*/;
                  if(_loc2_ == 47)
                  {
                     FSM_getrule.esp = FSM_getrule.esp - 8;
                     _loc3_ = _loc3_ + 16;
                     _loc1_ = _loc1_ + 1;
                     FSM_getrule.esp = FSM_getrule.esp - 4;
                     FSM_getrule.start();
                     _loc1_ = FSM_getrule.eax;
                     FSM_getrule.esp = FSM_getrule.esp + 8;
                  }
                  else
                  {
                     _loc2_ = 7200;
                  }
                  if(_loc2_ == 47)
                  {
                  }
               }
               FSM_getrule.eax = _loc1_;
               FSM_getrule.esp = FSM_getrule.ebp;
               FSM_getrule.ebp = op_li32(FSM_getrule.esp) /*Alchemy*/;
               FSM_getrule.esp = FSM_getrule.esp + 4;
               FSM_getrule.esp = FSM_getrule.esp + 4;
               return;
            }
            if(uint(_loc2_) <= uint(9))
            {
            }
            if(_loc4_ == 74)
            {
            }
         }
         else
         {
            _loc2_ = 2;
            FSM_getrule.esp = FSM_getrule.esp - 16;
            _loc2_ = _loc3_ + 12;
            _loc4_ = 12;
            _loc1_ = _loc1_ + 1;
            _loc5_ = 1;
            FSM_getrule.esp = FSM_getrule.esp - 4;
            FSM_getrule.start();
            _loc1_ = FSM_getrule.eax;
            FSM_getrule.esp = FSM_getrule.esp + 16;
            if(_loc1_ != 0)
            {
               _loc2_ = op_li8(_loc1_) /*Alchemy*/;
               if(_loc2_ == 46)
               {
                  _loc2_ = 5;
                  FSM_getrule.esp = FSM_getrule.esp - 16;
                  _loc4_ = _loc3_ + 8;
                  _loc1_ = _loc1_ + 1;
                  _loc5_ = 1;
                  FSM_getrule.esp = FSM_getrule.esp - 4;
                  FSM_getrule.start();
                  _loc1_ = FSM_getrule.eax;
                  FSM_getrule.esp = FSM_getrule.esp + 16;
                  if(_loc1_ != 0)
                  {
                     _loc2_ = op_li8(_loc1_) /*Alchemy*/;
                     if(_loc2_ == 46)
                     {
                        _loc2_ = 6;
                        FSM_getrule.esp = FSM_getrule.esp - 16;
                        _loc4_ = 0;
                        _loc5_ = _loc3_ + 4;
                        _loc1_ = _loc1_ + 1;
                        FSM_getrule.esp = FSM_getrule.esp - 4;
                        FSM_getrule.start();
                        _loc1_ = FSM_getrule.eax;
                        FSM_getrule.esp = FSM_getrule.esp + 16;
                        if(_loc1_ != 0)
                        {
                           _loc2_ = op_li8(_loc1_) /*Alchemy*/;
                           if(_loc2_ == 47)
                           {
                              FSM_getrule.esp = FSM_getrule.esp - 8;
                              _loc3_ = _loc3_ + 16;
                              _loc1_ = _loc1_ + 1;
                              FSM_getrule.esp = FSM_getrule.esp - 4;
                              FSM_getrule.start();
                              _loc1_ = FSM_getrule.eax;
                              FSM_getrule.esp = FSM_getrule.esp + 8;
                           }
                           else
                           {
                              _loc2_ = 7200;
                           }
                           if(_loc2_ == 47)
                           {
                           }
                        }
                        FSM_getrule.eax = _loc1_;
                        FSM_getrule.esp = FSM_getrule.ebp;
                        FSM_getrule.ebp = op_li32(FSM_getrule.esp) /*Alchemy*/;
                        FSM_getrule.esp = FSM_getrule.esp + 4;
                        FSM_getrule.esp = FSM_getrule.esp + 4;
                        return;
                     }
                     if(_loc2_ == 46)
                     {
                     }
                  }
               }
               if(_loc2_ == 46)
               {
               }
            }
         }
         if(_loc2_ != 77)
         {
            _loc1_ = 0;
            FSM_getrule.eax = _loc1_;
            FSM_getrule.esp = FSM_getrule.ebp;
            FSM_getrule.ebp = op_li32(FSM_getrule.esp) /*Alchemy*/;
            FSM_getrule.esp = FSM_getrule.esp + 4;
            FSM_getrule.esp = FSM_getrule.esp + 4;
            return;
         }
         _loc1_ = 0;
         FSM_getrule.eax = _loc1_;
         FSM_getrule.esp = FSM_getrule.ebp;
         FSM_getrule.ebp = op_li32(FSM_getrule.esp) /*Alchemy*/;
         FSM_getrule.esp = FSM_getrule.esp + 4;
         FSM_getrule.esp = FSM_getrule.esp + 4;
      }
   }
}
