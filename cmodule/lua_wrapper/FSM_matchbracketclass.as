package cmodule.lua_wrapper
{
   public final class FSM_matchbracketclass extends Machine
   {
      
      public function FSM_matchbracketclass() {
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
         FSM_matchbracketclass.esp = FSM_matchbracketclass.esp - 4;
         FSM_matchbracketclass.ebp = FSM_matchbracketclass.esp;
         FSM_matchbracketclass.esp = FSM_matchbracketclass.esp - 0;
         _loc1_ = op_li32(FSM_matchbracketclass.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM_matchbracketclass.ebp + 8) /*Alchemy*/;
         _loc3_ = op_li32(FSM_matchbracketclass.ebp + 16) /*Alchemy*/;
         _loc4_ = op_li8(_loc1_ + 1) /*Alchemy*/;
         _loc5_ = _loc1_ + 1;
         if(_loc4_ != 94)
         {
            _loc5_ = 1;
            while(true)
            {
               _loc4_ = _loc5_;
               _loc6_ = _loc1_ + 1;
               if(uint(_loc6_) >= uint(_loc3_))
               {
                  _loc1_ = _loc4_;
                  _loc4_ = _loc1_;
                  _loc4_ = _loc4_ == 0?1:0;
                  _loc4_ = _loc4_ & 1;
                  break;
               }
               _loc5_ = _loc1_;
               _loc1_ = _loc6_;
            }
            FSM_matchbracketclass.eax = _loc4_;
            FSM_matchbracketclass.esp = FSM_matchbracketclass.ebp;
            FSM_matchbracketclass.ebp = op_li32(FSM_matchbracketclass.esp) /*Alchemy*/;
            FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 4;
            FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 4;
            return;
         }
         _loc1_ = _loc1_ + 2;
         if(uint(_loc1_) >= uint(_loc3_))
         {
            _loc1_ = 0;
            _loc4_ = _loc1_;
            _loc4_ = _loc4_ == 0?1:0;
            _loc4_ = _loc4_ & 1;
         }
         else
         {
            _loc4_ = 0;
         }
         FSM_matchbracketclass.eax = _loc4_;
         FSM_matchbracketclass.esp = FSM_matchbracketclass.ebp;
         FSM_matchbracketclass.ebp = op_li32(FSM_matchbracketclass.esp) /*Alchemy*/;
         FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 4;
         FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 4;
         return;
         while(true)
         {
            _loc6_ = op_li8(_loc1_) /*Alchemy*/;
            _loc7_ = op_li8(_loc5_ + 2) /*Alchemy*/;
            _loc8_ = _loc5_ + 2;
            if(_loc6_ == 37)
            {
               FSM_matchbracketclass.esp = FSM_matchbracketclass.esp - 8;
               _loc1_ = _loc7_ & 255;
               FSM_matchbracketclass.esp = FSM_matchbracketclass.esp - 4;
               FSM_matchbracketclass.start();
               _loc1_ = FSM_matchbracketclass.eax;
               FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 8;
               if(_loc1_ == 0)
               {
                  _loc1_ = _loc8_;
                  _loc5_ = _loc4_;
                  _loc4_ = _loc5_;
                  _loc6_ = _loc1_ + 1;
                  if(uint(_loc6_) >= uint(_loc3_))
                  {
                     _loc1_ = _loc4_;
                     _loc4_ = _loc1_;
                     _loc4_ = _loc4_ == 0?1:0;
                     _loc4_ = _loc4_ & 1;
                  }
                  else
                  {
                     _loc5_ = _loc1_;
                     _loc1_ = _loc6_;
                     continue;
                  }
               }
            }
            else
            {
               _loc7_ = _loc7_ & 255;
               if(_loc7_ == 45)
               {
                  _loc7_ = _loc5_ + 3;
                  if(uint(_loc7_) < uint(_loc3_))
                  {
                     _loc1_ = op_li8(_loc5_ + 1) /*Alchemy*/;
                     if(_loc1_ <= _loc2_)
                     {
                        _loc1_ = op_li8(_loc7_) /*Alchemy*/;
                        if(_loc1_ >= _loc2_)
                        {
                        }
                     }
                     _loc1_ = _loc7_;
                     _loc5_ = _loc4_;
                     _loc4_ = _loc5_;
                     _loc6_ = _loc1_ + 1;
                     if(uint(_loc6_) >= uint(_loc3_))
                     {
                        _loc1_ = _loc4_;
                        _loc4_ = _loc1_;
                        _loc4_ = _loc4_ == 0?1:0;
                        _loc4_ = _loc4_ & 1;
                     }
                     else
                     {
                        _loc5_ = _loc1_;
                        _loc1_ = _loc6_;
                        continue;
                     }
                  }
               }
               _loc5_ = _loc6_ & 255;
               if(_loc5_ != _loc2_)
               {
                  _loc5_ = _loc4_;
                  _loc4_ = _loc5_;
                  _loc6_ = _loc1_ + 1;
                  if(uint(_loc6_) >= uint(_loc3_))
                  {
                     _loc1_ = _loc4_;
                     _loc4_ = _loc1_;
                     _loc4_ = _loc4_ == 0?1:0;
                     _loc4_ = _loc4_ & 1;
                  }
                  else
                  {
                     _loc5_ = _loc1_;
                     _loc1_ = _loc6_;
                     continue;
                  }
               }
            }
            if(_loc6_ == 37)
            {
               FSM_matchbracketclass.eax = _loc4_;
               FSM_matchbracketclass.esp = FSM_matchbracketclass.ebp;
               FSM_matchbracketclass.ebp = op_li32(FSM_matchbracketclass.esp) /*Alchemy*/;
               FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 4;
               FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 4;
               return;
            }
            FSM_matchbracketclass.eax = _loc4_;
            FSM_matchbracketclass.esp = FSM_matchbracketclass.ebp;
            FSM_matchbracketclass.ebp = op_li32(FSM_matchbracketclass.esp) /*Alchemy*/;
            FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 4;
            FSM_matchbracketclass.esp = FSM_matchbracketclass.esp + 4;
            return;
         }
      }
   }
}
