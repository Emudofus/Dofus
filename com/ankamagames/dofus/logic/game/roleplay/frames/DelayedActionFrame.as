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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GameRolePlayDelayedActionMessage = null;
         var _loc3_:DelayedActionMessage = null;
         var _loc4_:GameRolePlayDelayedActionFinishedMessage = null;
         var _loc5_:GameRolePlayDelayedObjectUseMessage = null;
         switch(true)
         {
            case param1 is CurrentMapMessage:
               this.removeAll();
               break;
            case param1 is GameContextRemoveElementMessage:
               this.removeEntity(GameContextRemoveElementMessage(param1).id);
               break;
            case param1 is GameRolePlayDelayedActionMessage:
               _loc2_ = param1 as GameRolePlayDelayedActionMessage;
               switch(_loc2_.delayTypeId)
               {
                  case DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE:
                     _loc5_ = param1 as GameRolePlayDelayedObjectUseMessage;
                     this.showItemUse(_loc5_.delayedCharacterId,_loc5_.objectGID,_loc2_.delayEndTime);
                     break;
               }
               return true;
            case param1 is DelayedActionMessage:
               _loc3_ = param1 as DelayedActionMessage;
               this.showItemUse(_loc3_.playerId,_loc3_.itemId,_loc3_.endTime);
               return true;
            case param1 is GameRolePlayDelayedActionFinishedMessage:
               _loc4_ = param1 as GameRolePlayDelayedActionFinishedMessage;
               this.removeEntity(_loc4_.delayedCharacterId);
               return true;
         }
         return false;
      }
      
      public function showItemUse(param1:int, param2:uint, param3:Number) : void {
         var _loc4_:* = NaN;
         var _loc5_:DelayedActionItem = null;
         var _loc6_:IRectangle = null;
         var _loc7_:Tooltip = null;
         if(DofusEntities.getEntity(param1))
         {
            _loc4_ = param3 - TimeManager.getInstance().getUtcTimestamp();
            _loc5_ = new DelayedActionItem(param1,DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE,param2,_loc4_);
            _loc6_ = (DofusEntities.getEntity(param1) as IDisplayable).absoluteBounds;
            _loc7_ = TooltipManager.show(_loc5_,_loc6_,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,TOOLTIP_NAME + param1,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,{"endTime":_loc4_},null,false,-1);
            _loc7_.mustBeHidden = false;
            this._delayedActionEntities[param1] = TOOLTIP_NAME + param1;
         }
      }
      
      private function removeEntity(param1:int) : void {
         if(this._delayedActionEntities[param1])
         {
            TooltipManager.hide(this._delayedActionEntities[param1]);
            delete this._delayedActionEntities[[param1]];
         }
      }
      
      private function removeAll() : void {
         var _loc1_:* = undefined;
         for (_loc1_ in this._delayedActionEntities)
         {
            this.removeEntity(_loc1_);
         }
      }
   }
}
