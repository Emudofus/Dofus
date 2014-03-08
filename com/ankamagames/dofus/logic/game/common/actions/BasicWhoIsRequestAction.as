package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BasicWhoIsRequestAction extends Object implements Action
   {
      
      public function BasicWhoIsRequestAction() {
         super();
      }
      
      public static function create(playerName:String, verbose:Boolean) : BasicWhoIsRequestAction {
         var a:BasicWhoIsRequestAction = new BasicWhoIsRequestAction();
         a.playerName = playerName;
         a.verbose = verbose;
         return a;
      }
      
      public var playerName:String;
      
      public var verbose:Boolean;
   }
}
