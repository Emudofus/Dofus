package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DownloadPartAction extends Object implements Action
   {
      
      public function DownloadPartAction() {
         super();
      }
      
      public static function create(id:String) : DownloadPartAction {
         var a:DownloadPartAction = new DownloadPartAction();
         a.id = id;
         return a;
      }
      
      public var id:String;
   }
}
