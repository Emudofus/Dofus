package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.Selection;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
    import com.ankamagames.atouin.messages.CellOverMessage;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
    import com.ankamagames.atouin.messages.CellClickMessage;
    import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.atouin.types.GraphicCell;
    import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.atouin.renderers.ZoneDARenderer;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.jerakine.types.zones.Cross;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.dofus.network.messages.game.context.ShowCellRequestMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.types.positions.MapPoint;

    public class FightPointCellFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightPointCellFrame));
        private static const TARGET_COLOR:Color = new Color(16548386);
        private static const SELECTION_TARGET:String = "SpellCastTarget";

        private var _targetSelection:Selection;


        public function get priority():int
        {
            return (Priority.HIGHEST);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:KeyboardKeyUpMessage;
            var _local_3:CellOverMessage;
            var _local_4:EntityMouseOverMessage;
            var _local_5:CellClickMessage;
            var _local_6:EntityClickMessage;
            switch (true)
            {
                case (msg is KeyboardKeyUpMessage):
                    _local_2 = (msg as KeyboardKeyUpMessage);
                    if (_local_2.keyboardEvent.keyCode == 27)
                    {
                        this.cancelShow();
                        return (true);
                    };
                    return (false);
                case (msg is CellOverMessage):
                    _local_3 = (msg as CellOverMessage);
                    this.refreshTarget(_local_3.cellId);
                    return (true);
                case (msg is EntityMouseOverMessage):
                    _local_4 = (msg as EntityMouseOverMessage);
                    this.refreshTarget(_local_4.entity.position.cellId);
                    return (true);
                case (msg is MouseClickMessage):
                    if (((!((MouseClickMessage(msg).target is GraphicCell))) && (!((MouseClickMessage(msg).target is TiphonSprite)))))
                    {
                        this.cancelShow();
                    };
                    return (true);
                case (msg is CellClickMessage):
                    _local_5 = (msg as CellClickMessage);
                    this.showCell(_local_5.cellId);
                    return (true);
                case (msg is EntityClickMessage):
                    _local_6 = (msg as EntityClickMessage);
                    this.showCell(_local_6.entity.position.cellId);
                    return (true);
                case (msg is AdjacentMapClickMessage):
                    this.cancelShow();
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        private function refreshTarget(target:uint):void
        {
            if (this.isValidCell(target))
            {
                if (!(this._targetSelection))
                {
                    this._targetSelection = new Selection();
                    this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
                    this._targetSelection.color = TARGET_COLOR;
                    this._targetSelection.zone = new Cross(0, 0, DataMapProvider.getInstance());
                    SelectionManager.getInstance().addSelection(this._targetSelection, SELECTION_TARGET);
                };
                SelectionManager.getInstance().update(SELECTION_TARGET, target);
            }
            else
            {
                this.removeTarget();
            };
        }

        private function removeTarget():void
        {
            var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
            if (s)
            {
                s.remove();
                this._targetSelection = null;
            };
        }

        private function showCell(cell:uint):void
        {
            var scrmsg:ShowCellRequestMessage;
            if (this.isValidCell(cell))
            {
                scrmsg = new ShowCellRequestMessage();
                scrmsg.initShowCellRequestMessage(cell);
                ConnectionsHandler.getConnection().send(scrmsg);
            };
            this.cancelShow();
        }

        private function cancelShow():void
        {
            this.removeTarget();
            KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
            Kernel.getWorker().removeFrame(this);
        }

        private function isValidCell(cell:uint):Boolean
        {
            return (DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(cell).x, MapPoint.fromCellId(cell).y, true));
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.frames

