package cmodule.lua_wrapper
{
   public final class FSM___floatunsdidf extends Machine
   {
      
      public function FSM___floatunsdidf() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         FSM___floatunsdidf.esp = FSM___floatunsdidf.esp - 4;
         FSM___floatunsdidf.ebp = FSM___floatunsdidf.esp;
         FSM___floatunsdidf.esp = FSM___floatunsdidf.esp - 0;
         _loc1_ = op_li32(FSM___floatunsdidf.ebp + 12) /*Alchemy*/;
         _loc2_ = op_li32(FSM___floatunsdidf.ebp + 8) /*Alchemy*/;
         _loc3_ = Number(uint(_loc1_));
         _loc4_ = Number(uint(_loc2_));
         _loc3_ = _loc3_ * 4.29497E9;
         _loc3_ = _loc4_ + _loc3_;
         FSM___floatunsdidf.st0 = _loc3_;
         FSM___floatunsdidf.esp = FSM___floatunsdidf.ebp;
         FSM___floatunsdidf.ebp = op_li32(FSM___floatunsdidf.esp) /*Alchemy*/;
         FSM___floatunsdidf.esp = FSM___floatunsdidf.esp + 4;
         FSM___floatunsdidf.esp = FSM___floatunsdidf.esp + 4;
      }
   }
}
