package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BasicWhoIsRequestAction extends Object implements Action
   {
      
      public function BasicWhoIsRequestAction() {
         super();
      }
      
      public static function create(param1:String, param2:Boolean) : BasicWhoIsRequestAction {
         var _loc3_:BasicWhoIsRequestAction = new BasicWhoIsRequestAction();
         _loc3_.playerName = param1;
         _loc3_.verbose = param2;
         return _loc3_;
      }
      
      public var playerName:String;
      
      public var verbose:Boolean;
   }
}
