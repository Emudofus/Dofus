package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class ChangeMapBehavior extends AbstractBehavior
   {
      
      public function ChangeMapBehavior()
      {
         super();
         type = STOP;
      }
      
      public var forceWalk:Boolean;
      
      override public function processInputMessage(param1:Message, param2:String) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         if(pendingMessage == null && param1 is AdjacentMapClickMessage)
         {
            pendingMessage = param1;
            _loc3_ = (pendingMessage as AdjacentMapClickMessage).cellId;
            position = MapPoint.fromCellId(_loc3_);
            this.forceWalk = AirScanner.isStreamingVersion()?false:OptionManager.getOptionManager("dofus")["enableForceWalk"] == true && ((ShortcutsFrame.ctrlKeyDown) || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && (ShortcutsFrame.altKeyDown));
            _loc4_ = this.forceWalk?"_WALK":"";
            if(CellUtil.isLeftCol(_loc3_))
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_LEFT" + _loc4_);
            }
            else if(CellUtil.isRightCol(_loc3_))
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_RIGHT" + _loc4_);
            }
            else if(CellUtil.isBottomRow(_loc3_))
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_BOTTOM" + _loc4_);
            }
            else
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_TOP" + _loc4_);
            }
            
            
            return true;
         }
         return false;
      }
      
      override public function processOutputMessage(param1:Message, param2:String) : Boolean
      {
         return false;
      }
      
      override public function copy() : AbstractBehavior
      {
         var _loc1_:ChangeMapBehavior = new ChangeMapBehavior();
         _loc1_.pendingMessage = this.pendingMessage;
         _loc1_.position = this.position;
         _loc1_.sprite = this.sprite;
         _loc1_.forceWalk = this.forceWalk;
         return _loc1_;
      }
      
      override public function processMessageToWorker() : void
      {
         var _loc1_:RoleplayMovementFrame = Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
         _loc1_.forceNextMovementBehavior(this.forceWalk?AtouinConstants.MOVEMENT_WALK:AtouinConstants.MOVEMENT_NORMAL);
         super.processMessageToWorker();
      }
   }
}
