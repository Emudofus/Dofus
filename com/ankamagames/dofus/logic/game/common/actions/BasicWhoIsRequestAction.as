package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class BasicWhoIsRequestAction extends Object implements Action
   {
         

      public function BasicWhoIsRequestAction() {
         super();
      }

      public static function create(playerName:String) : BasicWhoIsRequestAction {
         var a:BasicWhoIsRequestAction = new BasicWhoIsRequestAction();
         a.playerName=playerName;
         return a;
      }

      public var playerName:String;
   }

}