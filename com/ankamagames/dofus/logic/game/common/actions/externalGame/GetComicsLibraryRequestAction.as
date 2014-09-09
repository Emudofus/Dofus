package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GetComicsLibraryRequestAction extends Object implements Action
   {
      
      public function GetComicsLibraryRequestAction() {
         super();
      }
      
      public static function create(pAccountId:String) : GetComicsLibraryRequestAction {
         var gclra:GetComicsLibraryRequestAction = new GetComicsLibraryRequestAction();
         gclra.accountId = pAccountId;
         return gclra;
      }
      
      public var accountId:String;
   }
}
