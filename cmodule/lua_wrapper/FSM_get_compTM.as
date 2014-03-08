package cmodule.lua_wrapper
{
   public final class FSM_get_compTM extends Machine
   {
      
      public function FSM_get_compTM() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
         FSM_get_compTM.ebp = FSM_get_compTM.esp;
         FSM_get_compTM.esp = FSM_get_compTM.esp - 0;
         _loc1_ = op_li32(FSM_get_compTM.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_get_compTM.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM_get_compTM.ebp + 16) /*Alchemy*/;
         if(_loc2_ != 0)
         {
            _loc4_ = op_li8(_loc2_ + 6) /*Alchemy*/;
            _loc4_ = _loc4_ & 16;
            if(_loc4_ == 0)
            {
               _loc4_ = 4;
               _loc5_ = op_li32(_loc1_ + 16) /*Alchemy*/;
               _loc5_ = op_li32(_loc5_ + 184) /*Alchemy*/;
               FSM_get_compTM.esp = FSM_get_compTM.esp - 12;
               FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
               FSM_get_compTM.start();
               _loc4_ = FSM_get_compTM.eax;
               FSM_get_compTM.esp = FSM_get_compTM.esp + 12;
            }
            if(_loc4_ == 0)
            {
               if(_loc4_ != 0)
               {
                  if(_loc2_ == _loc3_)
                  {
                     _loc1_ = _loc4_;
                  }
                  else
                  {
                     if(_loc3_ != 0)
                     {
                        _loc2_ = op_li8(_loc3_ + 6) /*Alchemy*/;
                        _loc2_ = _loc2_ & 16;
                        if(_loc2_ == 0)
                        {
                           _loc2_ = 4;
                           _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
                           _loc1_ = op_li32(_loc1_ + 184) /*Alchemy*/;
                           FSM_get_compTM.esp = FSM_get_compTM.esp - 12;
                           FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                           FSM_get_compTM.start();
                           _loc1_ = FSM_get_compTM.eax;
                           FSM_get_compTM.esp = FSM_get_compTM.esp + 12;
                        }
                        if(_loc2_ == 0)
                        {
                           if(_loc1_ != 0)
                           {
                              FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                              FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                              FSM_get_compTM.start();
                              _loc1_ = FSM_get_compTM.eax;
                              FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                              _loc1_ = _loc1_ == 0?0:_loc4_;
                           }
                           if(_loc1_ != 0)
                           {
                           }
                        }
                        else
                        {
                           if(_loc1_ != 0)
                           {
                              FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                              FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                              FSM_get_compTM.start();
                              _loc1_ = FSM_get_compTM.eax;
                              FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                              _loc1_ = _loc1_ == 0?0:_loc4_;
                           }
                           if(_loc1_ != 0)
                           {
                           }
                        }
                     }
                     _loc1_ = 0;
                     if(_loc1_ != 0)
                     {
                        FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                        FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                        FSM_get_compTM.start();
                        _loc1_ = FSM_get_compTM.eax;
                        FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                        _loc1_ = _loc1_ == 0?0:_loc4_;
                     }
                     if(_loc1_ != 0)
                     {
                     }
                  }
                  FSM_get_compTM.eax = _loc1_;
                  FSM_get_compTM.esp = FSM_get_compTM.ebp;
                  FSM_get_compTM.ebp = op_li32(FSM_get_compTM.esp) /*Alchemy*/;
                  FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
                  FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
                  return;
               }
               _loc1_ = 0;
               FSM_get_compTM.eax = _loc1_;
               FSM_get_compTM.esp = FSM_get_compTM.ebp;
               FSM_get_compTM.ebp = op_li32(FSM_get_compTM.esp) /*Alchemy*/;
               FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
               FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
               return;
            }
            if(_loc4_ != 0)
            {
               if(_loc2_ == _loc3_)
               {
                  _loc1_ = _loc4_;
               }
               else
               {
                  if(_loc3_ != 0)
                  {
                     _loc2_ = op_li8(_loc3_ + 6) /*Alchemy*/;
                     _loc2_ = _loc2_ & 16;
                     if(_loc2_ == 0)
                     {
                        _loc2_ = 4;
                        _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
                        _loc1_ = op_li32(_loc1_ + 184) /*Alchemy*/;
                        FSM_get_compTM.esp = FSM_get_compTM.esp - 12;
                        FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                        FSM_get_compTM.start();
                        _loc1_ = FSM_get_compTM.eax;
                        FSM_get_compTM.esp = FSM_get_compTM.esp + 12;
                     }
                     if(_loc2_ == 0)
                     {
                        if(_loc1_ != 0)
                        {
                           FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                           FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                           FSM_get_compTM.start();
                           _loc1_ = FSM_get_compTM.eax;
                           FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                           _loc1_ = _loc1_ == 0?0:_loc4_;
                        }
                        if(_loc1_ != 0)
                        {
                        }
                     }
                     else
                     {
                        if(_loc1_ != 0)
                        {
                           FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                           FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                           FSM_get_compTM.start();
                           _loc1_ = FSM_get_compTM.eax;
                           FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                           _loc1_ = _loc1_ == 0?0:_loc4_;
                        }
                        if(_loc1_ != 0)
                        {
                        }
                     }
                  }
                  _loc1_ = 0;
                  if(_loc1_ != 0)
                  {
                     FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                     FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                     FSM_get_compTM.start();
                     _loc1_ = FSM_get_compTM.eax;
                     FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                     _loc1_ = _loc1_ == 0?0:_loc4_;
                  }
                  if(_loc1_ != 0)
                  {
                  }
               }
               FSM_get_compTM.eax = _loc1_;
               FSM_get_compTM.esp = FSM_get_compTM.ebp;
               FSM_get_compTM.ebp = op_li32(FSM_get_compTM.esp) /*Alchemy*/;
               FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
               FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
               return;
            }
            _loc1_ = 0;
            FSM_get_compTM.eax = _loc1_;
            FSM_get_compTM.esp = FSM_get_compTM.ebp;
            FSM_get_compTM.ebp = op_li32(FSM_get_compTM.esp) /*Alchemy*/;
            FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
            FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
            return;
         }
         _loc4_ = 0;
         if(_loc4_ != 0)
         {
            if(_loc2_ == _loc3_)
            {
               _loc1_ = _loc4_;
            }
            else
            {
               if(_loc3_ != 0)
               {
                  _loc2_ = op_li8(_loc3_ + 6) /*Alchemy*/;
                  _loc2_ = _loc2_ & 16;
                  if(_loc2_ == 0)
                  {
                     _loc2_ = 4;
                     _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
                     _loc1_ = op_li32(_loc1_ + 184) /*Alchemy*/;
                     FSM_get_compTM.esp = FSM_get_compTM.esp - 12;
                     FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                     FSM_get_compTM.start();
                     _loc1_ = FSM_get_compTM.eax;
                     FSM_get_compTM.esp = FSM_get_compTM.esp + 12;
                  }
                  if(_loc2_ == 0)
                  {
                     if(_loc1_ != 0)
                     {
                        FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                        FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                        FSM_get_compTM.start();
                        _loc1_ = FSM_get_compTM.eax;
                        FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                        _loc1_ = _loc1_ == 0?0:_loc4_;
                     }
                     if(_loc1_ != 0)
                     {
                     }
                  }
                  else
                  {
                     if(_loc1_ != 0)
                     {
                        FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                        FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                        FSM_get_compTM.start();
                        _loc1_ = FSM_get_compTM.eax;
                        FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                        _loc1_ = _loc1_ == 0?0:_loc4_;
                     }
                     if(_loc1_ != 0)
                     {
                     }
                  }
               }
               _loc1_ = 0;
               if(_loc1_ != 0)
               {
                  FSM_get_compTM.esp = FSM_get_compTM.esp - 8;
                  FSM_get_compTM.esp = FSM_get_compTM.esp - 4;
                  FSM_get_compTM.start();
                  _loc1_ = FSM_get_compTM.eax;
                  FSM_get_compTM.esp = FSM_get_compTM.esp + 8;
                  _loc1_ = _loc1_ == 0?0:_loc4_;
               }
               if(_loc1_ != 0)
               {
               }
            }
            FSM_get_compTM.eax = _loc1_;
            FSM_get_compTM.esp = FSM_get_compTM.ebp;
            FSM_get_compTM.ebp = op_li32(FSM_get_compTM.esp) /*Alchemy*/;
            FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
            FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
            return;
         }
         _loc1_ = 0;
         FSM_get_compTM.eax = _loc1_;
         FSM_get_compTM.esp = FSM_get_compTM.ebp;
         FSM_get_compTM.ebp = op_li32(FSM_get_compTM.esp) /*Alchemy*/;
         FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
         FSM_get_compTM.esp = FSM_get_compTM.esp + 4;
      }
   }
}
