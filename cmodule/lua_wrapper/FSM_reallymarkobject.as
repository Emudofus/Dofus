package cmodule.lua_wrapper
{
   public final class FSM_reallymarkobject extends Machine
   {
      
      public function FSM_reallymarkobject() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         FSM_reallymarkobject.esp = FSM_reallymarkobject.esp - 4;
         FSM_reallymarkobject.ebp = FSM_reallymarkobject.esp;
         FSM_reallymarkobject.esp = FSM_reallymarkobject.esp - 0;
         _loc1_ = op_li32(FSM_reallymarkobject.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(FSM_reallymarkobject.ebp + 12) /*Alchemy*/;
         while(true)
         {
            _loc3_ = op_li8(_loc2_ + 5) /*Alchemy*/;
            _loc3_ = _loc3_ & -4;
            _loc4_ = op_li8(_loc2_ + 4) /*Alchemy*/;
            _loc5_ = _loc2_ + 5;
            if(_loc4_ <= 7)
            {
               if(_loc4_ != 5)
               {
                  if(_loc4_ != 6)
                  {
                     if(_loc4_ == 7)
                     {
                        _loc4_ = op_li32(_loc2_ + 8) /*Alchemy*/;
                        _loc3_ = _loc3_ | 4;
                        if(_loc4_ != 0)
                        {
                           _loc5_ = op_li8(_loc4_ + 5) /*Alchemy*/;
                           _loc5_ = _loc5_ & 3;
                           if(_loc5_ != 0)
                           {
                              FSM_reallymarkobject.esp = FSM_reallymarkobject.esp - 8;
                              FSM_reallymarkobject.esp = FSM_reallymarkobject.esp - 4;
                              FSM_reallymarkobject.start();
                              FSM_reallymarkobject.esp = FSM_reallymarkobject.esp + 8;
                           }
                           if(_loc5_ != 0)
                           {
                           }
                        }
                        _loc2_ = op_li32(_loc2_ + 12) /*Alchemy*/;
                        _loc5_ = op_li8(_loc2_ + 5) /*Alchemy*/;
                        _loc5_ = _loc5_ & 3;
                        if(_loc5_ != 0)
                        {
                           continue;
                        }
                     }
                     if(_loc4_ != 7)
                     {
                     }
                  }
                  else
                  {
                     _loc3_ = op_li32(_loc1_ + 36) /*Alchemy*/;
                     break;
                  }
               }
               else
               {
                  _loc3_ = op_li32(_loc1_ + 36) /*Alchemy*/;
                  break;
               }
            }
            else
            {
               if(_loc4_ != 8)
               {
                  if(_loc4_ != 9)
                  {
                     if(_loc4_ == 10)
                     {
                        _loc3_ = op_li32(_loc2_ + 8) /*Alchemy*/;
                        _loc4_ = op_li32(_loc3_ + 8) /*Alchemy*/;
                        _loc6_ = _loc2_ + 8;
                        if(_loc4_ >= 4)
                        {
                           _loc3_ = op_li32(_loc3_) /*Alchemy*/;
                           _loc4_ = op_li8(_loc3_ + 5) /*Alchemy*/;
                           _loc4_ = _loc4_ & 3;
                           if(_loc4_ != 0)
                           {
                              FSM_reallymarkobject.esp = FSM_reallymarkobject.esp - 8;
                              FSM_reallymarkobject.esp = FSM_reallymarkobject.esp - 4;
                              FSM_reallymarkobject.start();
                              FSM_reallymarkobject.esp = FSM_reallymarkobject.esp + 8;
                           }
                           if(_loc4_ != 0)
                           {
                           }
                        }
                        _loc1_ = op_li32(_loc6_) /*Alchemy*/;
                        _loc2_ = _loc2_ + 12;
                        if(_loc1_ == _loc2_)
                        {
                           _loc1_ = op_li8(_loc5_) /*Alchemy*/;
                           _loc1_ = _loc1_ | 4;
                        }
                        if(_loc1_ == _loc2_)
                        {
                        }
                     }
                  }
                  else
                  {
                     _loc3_ = op_li32(_loc1_ + 36) /*Alchemy*/;
                     break;
                  }
               }
               else
               {
                  _loc3_ = op_li32(_loc1_ + 36) /*Alchemy*/;
                  break;
               }
            }
            FSM_reallymarkobject.esp = FSM_reallymarkobject.ebp;
            FSM_reallymarkobject.ebp = op_li32(FSM_reallymarkobject.esp) /*Alchemy*/;
            FSM_reallymarkobject.esp = FSM_reallymarkobject.esp + 4;
            FSM_reallymarkobject.esp = FSM_reallymarkobject.esp + 4;
            return;
         }
         FSM_reallymarkobject.esp = FSM_reallymarkobject.ebp;
         FSM_reallymarkobject.ebp = op_li32(FSM_reallymarkobject.esp) /*Alchemy*/;
         FSM_reallymarkobject.esp = FSM_reallymarkobject.esp + 4;
         FSM_reallymarkobject.esp = FSM_reallymarkobject.esp + 4;
      }
   }
}
