package cmodule.lua_wrapper
{
   public final class FSM___collate_lookup extends Machine
   {
      
      public function FSM___collate_lookup() {
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
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         FSM___collate_lookup.esp = FSM___collate_lookup.esp - 4;
         FSM___collate_lookup.ebp = FSM___collate_lookup.esp;
         FSM___collate_lookup.esp = FSM___collate_lookup.esp - 0;
         _loc1_ = 1;
         _loc2_ = op_li32(FSM___collate_lookup.ebp + 12) /*Alchemy*/;
         _loc3_ = op_li32(FSM___collate_lookup.ebp + 20) /*Alchemy*/;
         _loc1_ = 0;
         _loc4_ = op_li32(FSM___collate_lookup.ebp + 16) /*Alchemy*/;
         _loc1_ = op_li32(FSM___collate_lookup) /*Alchemy*/;
         _loc5_ = op_li8(_loc1_) /*Alchemy*/;
         _loc6_ = op_li32(FSM___collate_lookup.ebp + 8) /*Alchemy*/;
         _loc7_ = _loc1_;
         _loc8_ = _loc6_;
         if(_loc5_ != 0)
         {
            _loc5_ = 0;
            _loc9_ = op_li8(_loc6_) /*Alchemy*/;
            loop0:
            while(true)
            {
               _loc10_ = op_li8(_loc1_) /*Alchemy*/;
               _loc11_ = _loc1_;
               _loc12_ = _loc9_ & 255;
               if(_loc12_ == _loc10_)
               {
                  _loc12_ = _loc10_ & 255;
                  if(_loc12_ != 0)
                  {
                     _loc12_ = _loc1_;
                     while(true)
                     {
                        _loc13_ = op_li8(_loc12_ + 1) /*Alchemy*/;
                        _loc12_ = _loc12_ + 1;
                        _loc14_ = _loc12_;
                        if(_loc13_ != 0)
                        {
                           _loc12_ = _loc14_;
                           continue;
                        }
                        break;
                     }
                  }
                  else
                  {
                     _loc12_ = _loc11_;
                  }
                  _loc13_ = _loc11_;
                  _loc14_ = _loc12_;
                  if(_loc12_ != _loc11_)
                  {
                     _loc12_ = 0;
                     _loc14_ = _loc14_ - _loc13_;
                     _loc14_ = _loc14_ + 1;
                     while(true)
                     {
                        _loc15_ = _loc1_ + _loc12_;
                        _loc16_ = _loc8_ + _loc12_;
                        _loc16_ = op_li8(_loc16_) /*Alchemy*/;
                        _loc15_ = op_li8(_loc15_) /*Alchemy*/;
                        if(_loc16_ == _loc15_)
                        {
                           _loc15_ = _loc16_ & 255;
                           if(_loc15_ != 0)
                           {
                              _loc14_ = _loc14_ + -1;
                              _loc12_ = _loc12_ + 1;
                              if(_loc14_ != 1)
                              {
                                 continue;
                              }
                              break loop0;
                           }
                           break loop0;
                           break loop0;
                        }
                     }
                     FSM___collate_lookup.esp = FSM___collate_lookup.ebp;
                     FSM___collate_lookup.ebp = op_li32(FSM___collate_lookup.esp) /*Alchemy*/;
                     FSM___collate_lookup.esp = FSM___collate_lookup.esp + 4;
                     FSM___collate_lookup.esp = FSM___collate_lookup.esp + 4;
                     return;
                  }
                  break;
                  if(_loc12_ != _loc11_)
                  {
                     break;
                  }
                  break;
               }
               _loc10_ = op_li8(_loc1_ + 20) /*Alchemy*/;
               _loc5_ = _loc5_ + 1;
               _loc1_ = _loc1_ + 20;
               if(_loc10_ != 0)
               {
                  continue;
               }
            }
            _loc1_ = _loc10_ & 255;
            if(_loc1_ != 0)
            {
               _loc1_ = 1;
               while(true)
               {
                  _loc6_ = _loc5_ * 20;
                  _loc6_ = _loc7_ + _loc6_;
                  _loc6_ = _loc6_ + _loc1_;
                  _loc8_ = op_li8(_loc6_) /*Alchemy*/;
                  _loc1_ = _loc1_ + 1;
                  if(_loc8_ != 0)
                  {
                     continue;
                  }
                  break;
               }
               _loc1_ = _loc6_;
            }
            else
            {
               _loc1_ = _loc11_;
            }
            _loc5_ = _loc5_ * 20;
            _loc1_ = _loc1_ - _loc13_;
            _loc1_ = _loc7_ + _loc5_;
            _loc5_ = op_li32(_loc1_ + 12) /*Alchemy*/;
            _loc1_ = op_li32(_loc1_ + 16) /*Alchemy*/;
            FSM___collate_lookup.esp = FSM___collate_lookup.ebp;
            FSM___collate_lookup.ebp = op_li32(FSM___collate_lookup.esp) /*Alchemy*/;
            FSM___collate_lookup.esp = FSM___collate_lookup.esp + 4;
            FSM___collate_lookup.esp = FSM___collate_lookup.esp + 4;
            return;
         }
         if(_loc5_ != 0)
         {
            _loc1_ = op_li8(_loc6_) /*Alchemy*/;
            _loc2_ = op_li32(FSM___collate_lookup) /*Alchemy*/;
            _loc1_ = _loc1_ << 3;
            _loc1_ = _loc2_ + _loc1_;
            _loc1_ = op_li32(_loc1_) /*Alchemy*/;
            _loc1_ = op_li8(_loc6_) /*Alchemy*/;
            _loc1_ = _loc1_ << 3;
            _loc1_ = _loc2_ + _loc1_;
            _loc1_ = op_li32(_loc1_ + 4) /*Alchemy*/;
            FSM___collate_lookup.esp = FSM___collate_lookup.ebp;
            FSM___collate_lookup.ebp = op_li32(FSM___collate_lookup.esp) /*Alchemy*/;
            FSM___collate_lookup.esp = FSM___collate_lookup.esp + 4;
            FSM___collate_lookup.esp = FSM___collate_lookup.esp + 4;
            return;
         }
         _loc1_ = op_li8(_loc6_) /*Alchemy*/;
         _loc2_ = op_li32(FSM___collate_lookup) /*Alchemy*/;
         _loc1_ = _loc1_ << 3;
         _loc1_ = _loc2_ + _loc1_;
         _loc1_ = op_li32(_loc1_) /*Alchemy*/;
         _loc1_ = op_li8(_loc6_) /*Alchemy*/;
         _loc1_ = _loc1_ << 3;
         _loc1_ = _loc2_ + _loc1_;
         _loc1_ = op_li32(_loc1_ + 4) /*Alchemy*/;
         FSM___collate_lookup.esp = FSM___collate_lookup.ebp;
         FSM___collate_lookup.ebp = op_li32(FSM___collate_lookup.esp) /*Alchemy*/;
         FSM___collate_lookup.esp = FSM___collate_lookup.esp + 4;
         FSM___collate_lookup.esp = FSM___collate_lookup.esp + 4;
      }
   }
}
