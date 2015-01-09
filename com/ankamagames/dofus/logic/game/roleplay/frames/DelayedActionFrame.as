package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.delay.GameRolePlayDelayedActionMessage;
    import com.ankamagames.dofus.logic.game.roleplay.messages.DelayedActionMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.delay.GameRolePlayDelayedActionFinishedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.delay.GameRolePlayDelayedObjectUseMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
    import com.ankamagames.dofus.network.enums.DelayedActionTypeEnum;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.internalDatacenter.communication.DelayedActionItem;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.berilia.types.tooltip.Tooltip;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.types.LocationEnum;

    public class DelayedActionFrame implements Frame 
    {

        private static const TOOLTIP_NAME:String = "delayedItemUse";

        protected var _log:Logger;
        private var _delayedActionEntities:Dictionary;

        public function DelayedActionFrame()
        {
            this._log = Log.getLogger(getQualifiedClassName(DelayedActionFrame));
            this._delayedActionEntities = new Dictionary();
            super();
        }

        public function get priority():int
        {
            return (Priority.HIGH);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            this.removeAll();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:GameRolePlayDelayedActionMessage;
            var _local_3:DelayedActionMessage;
            var _local_4:GameRolePlayDelayedActionFinishedMessage;
            var _local_5:GameRolePlayDelayedObjectUseMessage;
            switch (true)
            {
                case (msg is CurrentMapMessage):
                    this.removeAll();
                    break;
                case (msg is GameContextRemoveElementMessage):
                    this.removeEntity(GameContextRemoveElementMessage(msg).id);
                    break;
                case (msg is GameRolePlayDelayedActionMessage):
                    _local_2 = (msg as GameRolePlayDelayedActionMessage);
                    switch (_local_2.delayTypeId)
                    {
                        case DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE:
                            _local_5 = (msg as GameRolePlayDelayedObjectUseMessage);
                            this.showItemUse(_local_5.delayedCharacterId, _local_5.objectGID, _local_2.delayEndTime);
                            break;
                    };
                    return (true);
                case (msg is DelayedActionMessage):
                    _local_3 = (msg as DelayedActionMessage);
                    this.showItemUse(_local_3.playerId, _local_3.itemId, _local_3.endTime);
                    return (true);
                case (msg is GameRolePlayDelayedActionFinishedMessage):
                    _local_4 = (msg as GameRolePlayDelayedActionFinishedMessage);
                    this.removeEntity(_local_4.delayedCharacterId);
                    return (true);
            };
            return (false);
        }

        public function showItemUse(playerId:int, itemId:uint, endTime:Number):void
        {
            var delay:Number;
            var w:DelayedActionItem;
            var absBounds:IRectangle;
            var delayTooltip:Tooltip;
            if (DofusEntities.getEntity(playerId))
            {
                delay = (endTime - TimeManager.getInstance().getUtcTimestamp());
                w = new DelayedActionItem(playerId, DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE, itemId, delay);
                absBounds = (DofusEntities.getEntity(playerId) as IDisplayable).absoluteBounds;
                delayTooltip = TooltipManager.show(w, absBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, (TOOLTIP_NAME + playerId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, {"endTime":delay}, null, false, -1);
                delayTooltip.mustBeHidden = false;
                this._delayedActionEntities[playerId] = (TOOLTIP_NAME + playerId);
            };
        }

        private function removeEntity(id:int):void
        {
            if (this._delayedActionEntities[id])
            {
                TooltipManager.hide(this._delayedActionEntities[id]);
                delete this._delayedActionEntities[id];
            };
        }

        private function removeAll():void
        {
            var id:*;
            for (id in this._delayedActionEntities)
            {
                this.removeEntity(id);
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.frames

