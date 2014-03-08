package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseGuildShareAction extends Object implements Action
   {
      
      public function HouseGuildShareAction() {
         super();
      }
      
      public static function create(param1:Boolean, param2:int=0) : HouseGuildShareAction {
         var _loc3_:HouseGuildShareAction = new HouseGuildShareAction();
         _loc3_.enabled = param1;
         _loc3_.rights = param2;
         return _loc3_;
      }
      
      public var enabled:Boolean;
      
      public var rights:int;
   }
}
