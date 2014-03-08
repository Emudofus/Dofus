package cmodule.lua_wrapper
{
   public final class FSM_luaH_getn extends Machine
   {
      
      public function FSM_luaH_getn() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         FSM_luaH_getn.esp = FSM_luaH_getn.esp - 4;
         FSM_luaH_getn.ebp = FSM_luaH_getn.esp;
         FSM_luaH_getn.esp = FSM_luaH_getn.esp - 0;
         _loc1_ = op_li32(FSM_luaH_getn.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 28) /*Alchemy*/;
         if(_loc2_ != 0)
         {
            _loc3_ = op_li32(_loc1_ + 12) /*Alchemy*/;
            _loc4_ = _loc2_ * 12;
            _loc4_ = _loc4_ + _loc3_;
            _loc4_ = op_li32(_loc4_ + -4) /*Alchemy*/;
            if(_loc4_ == 0)
            {
               _loc1_ = 0;
               loop0:
               while(true)
               {
                  _loc4_ = _loc1_;
                  _loc1_ = _loc2_;
                  _loc2_ = _loc1_ - _loc4_;
                  if(uint(_loc2_) <= uint(1))
                  {
                     _loc1_ = _loc4_;
                     break;
                  }
                  _loc2_ = _loc4_;
                  while(true)
                  {
                     _loc4_ = _loc2_ + _loc1_;
                     _loc4_ = _loc4_ >>> 1;
                     _loc5_ = _loc4_ * 12;
                     _loc5_ = _loc5_ + _loc3_;
                     _loc5_ = op_li32(_loc5_ + -4) /*Alchemy*/;
                     if(_loc5_ == 0)
                     {
                        break;
                     }
                     _loc2_ = _loc1_ - _loc4_;
                     if(uint(_loc2_) <= uint(1))
                     {
                        _loc1_ = _loc4_;
                        break loop0;
                     }
                     _loc2_ = _loc4_;
                  }
                  _loc1_ = _loc2_;
                  _loc2_ = _loc4_;
               }
            }
            FSM_luaH_getn.eax = _loc1_;
            FSM_luaH_getn.esp = FSM_luaH_getn.ebp;
            FSM_luaH_getn.ebp = op_li32(FSM_luaH_getn.esp) /*Alchemy*/;
            FSM_luaH_getn.esp = FSM_luaH_getn.esp + 4;
            FSM_luaH_getn.esp = FSM_luaH_getn.esp + 4;
            return;
         }
         _loc3_ = FSM_luaH_getn;
         _loc4_ = op_li32(_loc1_ + 16) /*Alchemy*/;
         if(_loc4_ == _loc3_)
         {
            _loc1_ = _loc2_;
         }
         else
         {
            FSM_luaH_getn.esp = FSM_luaH_getn.esp - 8;
            _loc3_ = _loc2_ + 1;
            FSM_luaH_getn.esp = FSM_luaH_getn.esp - 4;
            FSM_luaH_getn.start();
            _loc4_ = FSM_luaH_getn.eax;
            FSM_luaH_getn.esp = FSM_luaH_getn.esp + 8;
            _loc4_ = op_li32(_loc4_ + 8) /*Alchemy*/;
            if(_loc4_ != 0)
            {
               _loc2_ = _loc3_;
               while(true)
               {
                  _loc3_ = _loc2_ << 1;
                  if(uint(_loc3_) <= uint(2147483645))
                  {
                     FSM_luaH_getn.esp = FSM_luaH_getn.esp - 8;
                     FSM_luaH_getn.esp = FSM_luaH_getn.esp - 4;
                     FSM_luaH_getn.start();
                     _loc4_ = FSM_luaH_getn.eax;
                     FSM_luaH_getn.esp = FSM_luaH_getn.esp + 8;
                     _loc4_ = op_li32(_loc4_ + 8) /*Alchemy*/;
                     if(_loc4_ != 0)
                     {
                        _loc2_ = _loc3_;
                        continue;
                     }
                  }
                  else
                  {
                     _loc2_ = 1;
                     FSM_luaH_getn.esp = FSM_luaH_getn.esp - 8;
                     FSM_luaH_getn.esp = FSM_luaH_getn.esp - 4;
                     FSM_luaH_getn.start();
                     _loc2_ = FSM_luaH_getn.eax;
                     FSM_luaH_getn.esp = FSM_luaH_getn.esp + 8;
                     _loc2_ = op_li32(_loc2_ + 8) /*Alchemy*/;
                     if(_loc2_ != 0)
                     {
                        _loc2_ = 0;
                        while(true)
                        {
                           FSM_luaH_getn.esp = FSM_luaH_getn.esp - 8;
                           _loc3_ = _loc2_ + 2;
                           FSM_luaH_getn.esp = FSM_luaH_getn.esp - 4;
                           FSM_luaH_getn.start();
                           _loc3_ = FSM_luaH_getn.eax;
                           FSM_luaH_getn.esp = FSM_luaH_getn.esp + 8;
                           _loc3_ = op_li32(_loc3_ + 8) /*Alchemy*/;
                           _loc2_ = _loc2_ + 1;
                           if(_loc3_ != 0)
                           {
                              continue;
                           }
                           break;
                        }
                        _loc1_ = _loc2_;
                     }
                     else
                     {
                        _loc2_ = 0;
                        _loc1_ = _loc2_;
                     }
                     if(_loc2_ != 0)
                     {
                     }
                  }
                  if(uint(_loc3_) <= uint(2147483645))
                  {
                  }
               }
            }
            while(true)
            {
               _loc4_ = _loc3_ - _loc2_;
               if(uint(_loc4_) <= uint(1))
               {
                  break;
               }
               _loc4_ = _loc2_ + _loc3_;
               FSM_luaH_getn.esp = FSM_luaH_getn.esp - 8;
               _loc4_ = _loc4_ >>> 1;
               FSM_luaH_getn.esp = FSM_luaH_getn.esp - 4;
               FSM_luaH_getn.start();
               _loc5_ = FSM_luaH_getn.eax;
               FSM_luaH_getn.esp = FSM_luaH_getn.esp + 8;
               _loc5_ = op_li32(_loc5_ + 8) /*Alchemy*/;
               if(_loc5_ != 0)
               {
                  _loc2_ = _loc4_;
               }
               else
               {
                  _loc3_ = _loc4_;
               }
            }
            _loc1_ = _loc2_;
         }
         if(_loc4_ == _loc3_)
         {
            FSM_luaH_getn.eax = _loc1_;
            FSM_luaH_getn.esp = FSM_luaH_getn.ebp;
            FSM_luaH_getn.ebp = op_li32(FSM_luaH_getn.esp) /*Alchemy*/;
            FSM_luaH_getn.esp = FSM_luaH_getn.esp + 4;
            FSM_luaH_getn.esp = FSM_luaH_getn.esp + 4;
            return;
         }
         FSM_luaH_getn.eax = _loc1_;
         FSM_luaH_getn.esp = FSM_luaH_getn.ebp;
         FSM_luaH_getn.ebp = op_li32(FSM_luaH_getn.esp) /*Alchemy*/;
         FSM_luaH_getn.esp = FSM_luaH_getn.esp + 4;
         FSM_luaH_getn.esp = FSM_luaH_getn.esp + 4;
      }
   }
}
