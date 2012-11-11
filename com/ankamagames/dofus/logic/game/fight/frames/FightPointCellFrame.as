package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.handlers.messages.keyboard.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import com.ankamagames.tiphon.display.*;
    import flash.utils.*;

    public class FightPointCellFrame extends Object implements Frame
    {
        private var _targetSelection:Selection;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FightPointCellFrame));
        private static const TARGET_COLOR:Color = new Color(16548386);
        private static const SELECTION_TARGET:String = "SpellCastTarget";

        public function FightPointCellFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            switch(true)
            {
                case param1 is KeyboardKeyUpMessage:
                {
                    _loc_2 = param1 as KeyboardKeyUpMessage;
                    if (_loc_2.keyboardEvent.keyCode == 27)
                    {
                        this.cancelShow();
                        return true;
                    }
                    return false;
                }
                case param1 is CellOverMessage:
                {
                    _loc_3 = param1 as CellOverMessage;
                    this.refreshTarget(_loc_3.cellId);
                    return true;
                }
                case param1 is EntityMouseOverMessage:
                {
                    _loc_4 = param1 as EntityMouseOverMessage;
                    this.refreshTarget(_loc_4.entity.position.cellId);
                    return true;
                }
                case param1 is MouseClickMessage:
                {
                    if (!(MouseClickMessage(param1).target is GraphicCell) && !(MouseClickMessage(param1).target is TiphonSprite))
                    {
                        this.cancelShow();
                    }
                    return true;
                }
                case param1 is CellClickMessage:
                {
                    _loc_5 = param1 as CellClickMessage;
                    this.showCell(_loc_5.cellId);
                    return true;
                }
                case param1 is EntityClickMessage:
                {
                    _loc_6 = param1 as EntityClickMessage;
                    this.showCell(_loc_6.entity.position.cellId);
                    return true;
                }
                case param1 is AdjacentMapClickMessage:
                {
                    this.cancelShow();
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        private function refreshTarget(param1:uint) : void
        {
            if (this.isValidCell(param1))
            {
                if (!this._targetSelection)
                {
                    this._targetSelection = new Selection();
                    this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
                    this._targetSelection.color = TARGET_COLOR;
                    this._targetSelection.zone = new Cross(0, 0, DataMapProvider.getInstance());
                    SelectionManager.getInstance().addSelection(this._targetSelection, SELECTION_TARGET);
                }
                if (!PlayedCharacterManager.getInstance().isSpectator)
                {
                    this._targetSelection.zone.direction = MapPoint(DofusEntities.getEntity(PlayedCharacterManager.getInstance().id).position).advancedOrientationTo(MapPoint.fromCellId(param1));
                }
                SelectionManager.getInstance().update(SELECTION_TARGET, param1);
            }
            else
            {
                this.removeTarget();
            }
            return;
        }// end function

        private function removeTarget() : void
        {
            var _loc_1:* = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
            if (_loc_1)
            {
                _loc_1.remove();
                this._targetSelection = null;
            }
            return;
        }// end function

        private function showCell(param1:uint) : void
        {
            var _loc_2:* = null;
            if (this.isValidCell(param1))
            {
                _loc_2 = new ShowCellRequestMessage();
                _loc_2.initShowCellRequestMessage(param1);
                ConnectionsHandler.getConnection().send(_loc_2);
            }
            this.cancelShow();
            return;
        }// end function

        private function cancelShow() : void
        {
            this.removeTarget();
            KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
            Kernel.getWorker().removeFrame(this);
            return;
        }// end function

        private function isValidCell(param1:uint) : Boolean
        {
            return DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(param1).x, MapPoint.fromCellId(param1).y, true);
        }// end function

    }
}
