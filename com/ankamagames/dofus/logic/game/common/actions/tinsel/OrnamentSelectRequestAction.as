package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OrnamentSelectRequestAction extends Object implements Action
   {
      
      public function OrnamentSelectRequestAction() {
         super();
      }
      
      public static function create(param1:int) : OrnamentSelectRequestAction {
         var _loc2_:OrnamentSelectRequestAction = new OrnamentSelectRequestAction();
         _loc2_.ornamentId = param1;
         return _loc2_;
      }
      
      public var ornamentId:int;
   }
}
