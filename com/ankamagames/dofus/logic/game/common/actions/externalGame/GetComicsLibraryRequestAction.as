package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GetComicsLibraryRequestAction extends Object implements Action
   {
      
      public function GetComicsLibraryRequestAction()
      {
         super();
      }
      
      public static function create(param1:String) : GetComicsLibraryRequestAction
      {
         var _loc2_:GetComicsLibraryRequestAction = new GetComicsLibraryRequestAction();
         _loc2_.accountId = param1;
         return _loc2_;
      }
      
      public var accountId:String;
   }
}
