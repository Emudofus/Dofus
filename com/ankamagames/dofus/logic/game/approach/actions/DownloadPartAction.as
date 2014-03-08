package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DownloadPartAction extends Object implements Action
   {
      
      public function DownloadPartAction() {
         super();
      }
      
      public static function create(param1:String) : DownloadPartAction {
         var _loc2_:DownloadPartAction = new DownloadPartAction();
         _loc2_.id = param1;
         return _loc2_;
      }
      
      public var id:String;
   }
}
