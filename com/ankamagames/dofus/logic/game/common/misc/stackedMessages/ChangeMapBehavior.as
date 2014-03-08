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
      
      override public function processInputMessage(param1:Message, param2:String) : Boolean {
         var _loc3_:uint = 0;
         if(pendingMessage == null && param1 is AdjacentMapClickMessage)
         {
            pendingMessage = param1;
            _loc3_ = (pendingMessage as AdjacentMapClickMessage).cellId;
            position = MapPoint.fromCellId(_loc3_);
            if(CellUtil.isLeftCol(_loc3_))
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_LEFT");
            }
            else
            {
               if(CellUtil.isRightCol(_loc3_))
               {
                  sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_RIGHT");
               }
               else
               {
                  if(CellUtil.isBottomRow(_loc3_))
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
      
      override public function processOutputMessage(param1:Message, param2:String) : Boolean {
         return false;
      }
      
      override public function copy() : AbstractBehavior {
         var _loc1_:ChangeMapBehavior = new ChangeMapBehavior();
         _loc1_.pendingMessage = this.pendingMessage;
         _loc1_.position = this.position;
         _loc1_.sprite = this.sprite;
         return _loc1_;
      }
   }
}
