package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   
   public class ChangeMapBehavior extends AbstractBehavior
   {
      
      public function ChangeMapBehavior() {
         super();
         type = STOP;
      }
      
      override public function processInputMessage(pMsgToProcess:Message, pMode:String) : Boolean {
         var cellId:uint = 0;
         if((pendingMessage == null) && (pMsgToProcess is AdjacentMapClickMessage))
         {
            pendingMessage = pMsgToProcess;
            cellId = (pendingMessage as AdjacentMapClickMessage).cellId;
            position = MapPoint.fromCellId(cellId);
            if(CellUtil.isLeftCol(cellId))
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_LEFT");
            }
            else
            {
               if(CellUtil.isRightCol(cellId))
               {
                  sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_RIGHT");
               }
               else
               {
                  if(CellUtil.isBottomRow(cellId))
                  {
                     sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_BOTTOM");
                  }
                  else
                  {
                     sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_TOP");
                  }
               }
            }
            return true;
         }
         return false;
      }
      
      override public function processOutputMessage(pMsgToProcess:Message, pMode:String) : Boolean {
         return false;
      }
      
      override public function copy() : AbstractBehavior {
         var cp:ChangeMapBehavior = new ChangeMapBehavior();
         cp.pendingMessage = this.pendingMessage;
         cp.position = this.position;
         cp.sprite = this.sprite;
         return cp;
      }
   }
}
