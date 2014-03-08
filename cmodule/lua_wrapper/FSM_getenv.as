package cmodule.lua_wrapper
{
   public final class FSM_getenv extends Machine
   {
      
      public function FSM_getenv() {
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
         FSM_getenv.esp = FSM_getenv.esp - 4;
         FSM_getenv.ebp = FSM_getenv.esp;
         FSM_getenv.esp = FSM_getenv.esp - 0;
         _loc1_ = op_li32(FSM_getenv.ebp + 8) /*Alchemy*/;
         if(_loc1_ != 0)
         {
            _loc2_ = op_li32(FSM_getenv) /*Alchemy*/;
            _loc3_ = _loc2_;
            if(_loc2_ != 0)
            {
               _loc4_ = _loc1_;
               while(true)
               {
                  _loc5_ = op_li8(_loc4_) /*Alchemy*/;
                  _loc6_ = _loc4_;
                  if(_loc5_ != 0)
                  {
                     _loc5_ = _loc5_ & 255;
                     if(_loc5_ == 61)
                     {
                        break;
                     }
                     _loc4_ = _loc4_ + 1;
                     continue;
                  }
                  break;
               }
               _loc3_ = op_li32(_loc3_) /*Alchemy*/;
               if(_loc3_ != 0)
               {
                  _loc2_ = _loc2_ + 4;
                  _loc4_ = _loc6_ - _loc1_;
                  loop1:
                  while(true)
                  {
                     _loc5_ = 0;
                     _loc6_ = _loc2_;
                     while(true)
                     {
                        _loc8_ = _loc5_;
                        _loc5_ = _loc1_ + _loc8_;
                        _loc7_ = _loc3_ + _loc8_;
                        if(_loc4_ != _loc8_)
                        {
                           _loc7_ = op_li8(_loc7_) /*Alchemy*/;
                           if(_loc7_ != 0)
                           {
                              _loc5_ = op_li8(_loc5_) /*Alchemy*/;
                              _loc9_ = _loc8_ + 1;
                              _loc7_ = _loc7_ & 255;
                              if(_loc7_ == _loc5_)
                              {
                                 _loc5_ = _loc9_;
                                 continue;
                              }
                              _loc3_ = _loc3_ + _loc9_;
                              break;
                           }
                           _loc3_ = _loc3_ + _loc8_;
                           if(_loc4_ == _loc8_)
                           {
                              _loc5_ = op_li8(_loc3_) /*Alchemy*/;
                              _loc3_ = _loc3_ + 1;
                              if(_loc5_ == 61)
                              {
                                 _loc1_ = _loc3_;
                                 FSM_getenv.eax = _loc1_;
                                 FSM_getenv.esp = FSM_getenv.ebp;
                                 FSM_getenv.ebp = op_li32(FSM_getenv.esp) /*Alchemy*/;
                                 FSM_getenv.esp = FSM_getenv.esp + 4;
                                 FSM_getenv.esp = FSM_getenv.esp + 4;
                                 return;
                              }
                           }
                           _loc3_ = op_li32(_loc6_) /*Alchemy*/;
                           _loc2_ = _loc2_ + 4;
                           if(_loc3_ != 0)
                           {
                              continue loop1;
                           }
                           break loop1;
                        }
                        _loc3_ = _loc3_ + _loc8_;
                        break;
                     }
                     if(_loc4_ == _loc8_)
                     {
                        _loc5_ = op_li8(_loc3_) /*Alchemy*/;
                        _loc3_ = _loc3_ + 1;
                        if(_loc5_ == 61)
                        {
                           _loc1_ = _loc3_;
                           FSM_getenv.eax = _loc1_;
                           FSM_getenv.esp = FSM_getenv.ebp;
                           FSM_getenv.ebp = op_li32(FSM_getenv.esp) /*Alchemy*/;
                           FSM_getenv.esp = FSM_getenv.esp + 4;
                           FSM_getenv.esp = FSM_getenv.esp + 4;
                           return;
                        }
                     }
                     _loc3_ = op_li32(_loc6_) /*Alchemy*/;
                     _loc2_ = _loc2_ + 4;
                     if(_loc3_ != 0)
                     {
                        continue;
                     }
                     break;
                  }
               }
            }
         }
         _loc1_ = 0;
         FSM_getenv.eax = _loc1_;
         FSM_getenv.esp = FSM_getenv.ebp;
         FSM_getenv.ebp = op_li32(FSM_getenv.esp) /*Alchemy*/;
         FSM_getenv.esp = FSM_getenv.esp + 4;
         FSM_getenv.esp = FSM_getenv.esp + 4;
      }
   }
}
