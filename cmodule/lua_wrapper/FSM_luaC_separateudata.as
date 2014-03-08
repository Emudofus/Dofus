package cmodule.lua_wrapper
{
   public final class FSM_luaC_separateudata extends Machine
   {
      
      public function FSM_luaC_separateudata() {
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
         FSM_luaC_separateudata.esp = FSM_luaC_separateudata.esp - 4;
         FSM_luaC_separateudata.ebp = FSM_luaC_separateudata.esp;
         FSM_luaC_separateudata.esp = FSM_luaC_separateudata.esp - 0;
         _loc1_ = op_li32(FSM_luaC_separateudata.ebp + 8) /*Alchemy*/;
         _loc2_ = op_li32(_loc1_ + 16) /*Alchemy*/;
         _loc3_ = op_li32(_loc2_ + 104) /*Alchemy*/;
         _loc4_ = op_li32(_loc3_) /*Alchemy*/;
         _loc1_ = _loc1_ + 16;
         _loc5_ = op_li32(FSM_luaC_separateudata.ebp + 12) /*Alchemy*/;
         if(_loc4_ == 0)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc6_ = 0;
            _loc2_ = _loc2_ + 48;
            while(true)
            {
               _loc7_ = op_li8(_loc4_ + 5) /*Alchemy*/;
               _loc7_ = _loc7_ & 3;
               _loc7_ = _loc7_ | _loc5_;
               if(_loc7_ != 0)
               {
                  _loc7_ = op_li8(_loc4_ + 5) /*Alchemy*/;
                  _loc8_ = _loc4_ + 5;
                  _loc9_ = _loc4_;
                  _loc7_ = _loc7_ & 8;
                  if(_loc7_ == 0)
                  {
                     _loc7_ = op_li32(_loc9_ + 8) /*Alchemy*/;
                     if(_loc7_ != 0)
                     {
                        _loc10_ = op_li8(_loc7_ + 6) /*Alchemy*/;
                        _loc10_ = _loc10_ & 4;
                        if(_loc10_ == 0)
                        {
                           _loc10_ = 2;
                           _loc11_ = op_li32(_loc1_) /*Alchemy*/;
                           _loc11_ = op_li32(_loc11_ + 176) /*Alchemy*/;
                           FSM_luaC_separateudata.esp = FSM_luaC_separateudata.esp - 12;
                           FSM_luaC_separateudata.esp = FSM_luaC_separateudata.esp - 4;
                           FSM_luaC_separateudata.start();
                           _loc7_ = FSM_luaC_separateudata.eax;
                           FSM_luaC_separateudata.esp = FSM_luaC_separateudata.esp + 12;
                           if(_loc7_ != 0)
                           {
                              _loc7_ = op_li8(_loc8_) /*Alchemy*/;
                              _loc9_ = op_li32(_loc9_ + 16) /*Alchemy*/;
                              _loc7_ = _loc7_ | 8;
                              _loc7_ = op_li32(_loc4_) /*Alchemy*/;
                              _loc6_ = _loc6_ + _loc9_;
                              _loc7_ = op_li32(_loc2_) /*Alchemy*/;
                              _loc6_ = _loc6_ + 20;
                              _loc8_ = _loc4_;
                              if(_loc7_ == 0)
                              {
                                 _loc4_ = _loc6_;
                              }
                              else
                              {
                                 _loc7_ = op_li32(_loc7_) /*Alchemy*/;
                                 _loc7_ = op_li32(_loc2_) /*Alchemy*/;
                                 _loc4_ = _loc6_;
                              }
                              if(_loc7_ == 0)
                              {
                              }
                           }
                           if(_loc7_ == 0)
                           {
                           }
                        }
                        if(_loc10_ == 0)
                        {
                        }
                     }
                     _loc3_ = op_li8(_loc8_) /*Alchemy*/;
                     _loc3_ = _loc3_ | 8;
                     _loc3_ = _loc4_;
                     _loc4_ = _loc6_;
                  }
                  if(_loc7_ != 0)
                  {
                     _loc7_ = op_li32(_loc3_) /*Alchemy*/;
                     if(_loc7_ != 0)
                     {
                        _loc6_ = _loc4_;
                        _loc4_ = _loc7_;
                        continue;
                     }
                     break;
                  }
                  _loc7_ = op_li32(_loc3_) /*Alchemy*/;
                  if(_loc7_ != 0)
                  {
                     _loc6_ = _loc4_;
                     _loc4_ = _loc7_;
                     continue;
                  }
                  break;
               }
               _loc3_ = _loc4_;
               _loc4_ = _loc6_;
               _loc7_ = op_li32(_loc3_) /*Alchemy*/;
               if(_loc7_ != 0)
               {
                  _loc6_ = _loc4_;
                  _loc4_ = _loc7_;
                  continue;
               }
               break;
            }
            _loc1_ = _loc4_;
         }
         FSM_luaC_separateudata.eax = _loc1_;
         FSM_luaC_separateudata.esp = FSM_luaC_separateudata.ebp;
         FSM_luaC_separateudata.ebp = op_li32(FSM_luaC_separateudata.esp) /*Alchemy*/;
         FSM_luaC_separateudata.esp = FSM_luaC_separateudata.esp + 4;
         FSM_luaC_separateudata.esp = FSM_luaC_separateudata.esp + 4;
      }
   }
}
