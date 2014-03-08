package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.delay.GameRolePlayDelayedActionMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.DelayedActionMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.delay.GameRolePlayDelayedActionFinishedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.delay.GameRolePlayDelayedObjectUseMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
   import com.ankamagames.dofus.network.enums.DelayedActionTypeEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.internalDatacenter.communication.DelayedActionItem;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DelayedActionFrame extends Object implements Frame
   {
      
      public function DelayedActionFrame() {
         this._log = Log.getLogger(getQualifiedClassName(DelayedActionFrame));
         this._delayedActionEntities = new Dictionary();
         super();
      }
      
      private static const TOOLTIP_NAME:String = "delayedItemUse";
      
      protected var _log:Logger;
      
      private var _delayedActionEntities:Dictionary;
      
      public function get priority() : int {
         return Priority.HIGH;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         this.removeAll();
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var grpdaMsg:GameRolePlayDelayedActionMessage = null;
         var dam:DelayedActionMessage = null;
         var grpdafMsg:GameRolePlayDelayedActionFinishedMessage = null;
         var grdoum:GameRolePlayDelayedObjectUseMessage = null;
         switch(true)
         {
            case msg is CurrentMapMessage:
               this.removeAll();
               break;
            case msg is GameContextRemoveElementMessage:
               this.removeEntity(GameContextRemoveElementMessage(msg).id);
               break;
            case msg is GameRolePlayDelayedActionMessage:
               grpdaMsg = msg as GameRolePlayDelayedActionMessage;
               switch(grpdaMsg.delayTypeId)
               {
                  case DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE:
                     grdoum = msg as GameRolePlayDelayedObjectUseMessage;
                     this.showItemUse(grdoum.delayedCharacterId,grdoum.objectGID,grpdaMsg.delayEndTime);
                     break;
               }
               return true;
            case msg is DelayedActionMessage:
               dam = msg as DelayedActionMessage;
               this.showItemUse(dam.playerId,dam.itemId,dam.endTime);
               return true;
            case msg is GameRolePlayDelayedActionFinishedMessage:
               grpdafMsg = msg as GameRolePlayDelayedActionFinishedMessage;
               this.removeEntity(grpdafMsg.delayedCharacterId);
               return true;
         }
         return false;
      }
      
      public function showItemUse(playerId:int, itemId:uint, endTime:Number) : void {
         var delay:* = NaN;
         var w:DelayedActionItem = null;
         var absBounds:IRectangle = null;
         var delayTooltip:Tooltip = null;
         if(DofusEntities.getEntity(playerId))
         {
            delay = endTime - TimeManager.getInstance().getUtcTimestamp();
            w = new DelayedActionItem(playerId,DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE,itemId,delay);
            absBounds = (DofusEntities.getEntity(playerId) as IDisplayable).absoluteBounds;
            delayTooltip = TooltipManager.show(w,absBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,TOOLTIP_NAME + playerId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,{"endTime":delay},null,false,-1);
            delayTooltip.mustBeHidden = false;
            this._delayedActionEntities[playerId] = TOOLTIP_NAME + playerId;
         }
      }
      
      private function removeEntity(id:int) : void {
         if(this._delayedActionEntities[id])
         {
            TooltipManager.hide(this._delayedActionEntities[id]);
            delete this._delayedActionEntities[[id]];
         }
      }
      
      private function removeAll() : void {
         var id:* = undefined;
         for (id in this._delayedActionEntities)
         {
            this.removeEntity(id);
         }
      }
   }
}
