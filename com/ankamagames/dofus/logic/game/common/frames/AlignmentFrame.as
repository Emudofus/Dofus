package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.SetEnablePVPRequestAction;
   import com.ankamagames.dofus.network.messages.game.pvp.SetEnablePVPRequestMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.AlignmentRankUpdateMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.AlignmentHookList;
   
   public class AlignmentFrame extends Object implements Frame
   {
      
      public function AlignmentFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentFrame));
      
      private var _alignmentRank:int = -1;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get playerRank() : int {
         return this._alignmentRank;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:SetEnablePVPRequestAction = null;
         var _loc3_:SetEnablePVPRequestMessage = null;
         var _loc4_:AlignmentRankUpdateMessage = null;
         switch(true)
         {
            case param1 is SetEnablePVPRequestAction:
               _loc2_ = param1 as SetEnablePVPRequestAction;
               _loc3_ = new SetEnablePVPRequestMessage();
               _loc3_.initSetEnablePVPRequestMessage(_loc2_.enable);
               ConnectionsHandler.getConnection().send(_loc3_);
               return true;
            case param1 is AlignmentRankUpdateMessage:
               _loc4_ = param1 as AlignmentRankUpdateMessage;
               this._alignmentRank = _loc4_.alignmentRank;
               if(_loc4_.verbose)
               {
                  KernelEventsManager.getInstance().processCallback(AlignmentHookList.AlignmentRankUpdate,_loc4_.alignmentRank);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
