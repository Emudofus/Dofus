package com.ankamagames.dofus.logic.game.fight.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.pathfinding.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class FightTurnFrame extends Object implements Frame
    {
        private var _movementSelection:Selection;
        private var _movementSelectionUnreachable:Selection;
        private var _isRequestingMovement:Boolean;
        private var _spellCastFrame:Frame;
        private var _finishingTurn:Boolean;
        private var _remindTurnTimeoutId:uint;
        private var _myTurn:Boolean;
        private var _turnDuration:uint;
        private var _lastCell:uint;
        private var _cursorData:LinkedCursorData = null;
        private var _tfAP:TextField;
        private var _tfMP:TextField;
        private var _cells:Vector.<uint>;
        private var _cellsUnreachable:Vector.<uint>;
        private static const TAKLED_CURSOR_NAME:String = "TackledCursor";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FightTurnFrame));
        public static const SELECTION_PATH:String = "FightMovementPath";
        public static const SELECTION_PATH_UNREACHABLE:String = "FightMovementPathUnreachable";
        private static const PATH_COLOR:Color = new Color(26112);
        private static const PATH_UNREACHABLE_COLOR:Color = new Color(6684672);
        private static const REMIND_TURN_DELAY:uint = 15000;

        public function FightTurnFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGH;
        }// end function

        public function get myTurn() : Boolean
        {
            return this._myTurn;
        }// end function

        public function set myTurn(param1:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = param1 != this._myTurn;
            var _loc_3:* = !this._myTurn;
            this._myTurn = param1;
            if (param1)
            {
                this.startRemindTurn();
            }
            else
            {
                this._isRequestingMovement = false;
                if (this._remindTurnTimeoutId != 0)
                {
                    clearTimeout(this._remindTurnTimeoutId);
                }
                this.removePath();
            }
            var _loc_4:* = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
            if (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame)
            {
                if (_loc_3)
                {
                    _loc_4.drawRange();
                }
                if (_loc_2)
                {
                    if (_loc_4)
                    {
                        if (FightContextFrame.timelineOverEntityId)
                        {
                            _loc_5 = DofusEntities.getEntity(FightContextFrame.timelineOverEntityId);
                            if (_loc_5)
                            {
                                FightContextFrame.currentCell = _loc_5.position.cellId;
                            }
                        }
                        _loc_4.refreshTarget(true);
                    }
                }
            }
            if (this._myTurn && !_loc_4)
            {
                this.drawPath();
            }
            return;
        }// end function

        public function set turnDuration(param1:uint) : void
        {
            this._turnDuration = param1;
            return;
        }// end function

        public function freePlayer() : void
        {
            this._isRequestingMovement = false;
            return;
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
            var _loc_7:* = null;
            switch(true)
            {
                case param1 is CellOverMessage:
                {
                    if (!this.myTurn)
                    {
                        return false;
                    }
                    if (Kernel.getWorker().getFrame(FightSpellCastFrame) != null)
                    {
                        return false;
                    }
                    _loc_2 = param1 as CellOverMessage;
                    this.drawPath(_loc_2.cell);
                    return false;
                }
                case param1 is GameFightSpellCastAction:
                {
                    _loc_3 = param1 as GameFightSpellCastAction;
                    if (this._spellCastFrame != null)
                    {
                        Kernel.getWorker().removeFrame(this._spellCastFrame);
                    }
                    this.removePath();
                    if (this._myTurn)
                    {
                        this.startRemindTurn();
                    }
                    _loc_4 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(PlayedCharacterManager.getInstance().id) as GameFightFighterInformations;
                    if (_loc_4 && _loc_4.alive)
                    {
                        var _loc_8:* = new FightSpellCastFrame(_loc_3.spellId);
                        this._spellCastFrame = new FightSpellCastFrame(_loc_3.spellId);
                        Kernel.getWorker().addFrame(_loc_8);
                    }
                    return true;
                }
                case param1 is CellClickMessage:
                {
                    if (!this.myTurn)
                    {
                        return false;
                    }
                    _loc_5 = param1 as CellClickMessage;
                    this.askMoveTo(_loc_5.cell);
                    return true;
                }
                case param1 is GameMapNoMovementMessage:
                {
                    if (!this.myTurn)
                    {
                        return false;
                    }
                    this._isRequestingMovement = false;
                    this.removePath();
                    return true;
                }
                case param1 is EntityMovementCompleteMessage:
                {
                    _loc_6 = param1 as EntityMovementCompleteMessage;
                    if (!this.myTurn)
                    {
                        return false;
                    }
                    if (_loc_6.entity.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        this._isRequestingMovement = false;
                        _loc_7 = Kernel.getWorker().getFrame(FightSpellCastFrame);
                        if (!_loc_7)
                        {
                            this.drawPath();
                        }
                        this.startRemindTurn();
                        if (this._finishingTurn)
                        {
                            this.finishTurn();
                        }
                    }
                    return true;
                }
                case param1 is GameFightTurnFinishAction:
                {
                    if (!this.myTurn)
                    {
                        return false;
                    }
                    if ((DofusEntities.getEntity(CurrentPlayedFighterManager.getInstance().currentFighterId) as IMovable).isMoving)
                    {
                        this._finishingTurn = true;
                    }
                    else
                    {
                        this.finishTurn();
                    }
                    return true;
                }
                case param1 is MapContainerRollOutMessage:
                {
                    this.removePath();
                    break;
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
            if (this._remindTurnTimeoutId != 0)
            {
                clearTimeout(this._remindTurnTimeoutId);
            }
            Atouin.getInstance().cellOverEnabled = false;
            this.removePath();
            Kernel.getWorker().removeFrame(this._spellCastFrame);
            return true;
        }// end function

        public function drawPath(param1:MapPoint = null) : void
        {
            var _loc_3:* = NaN;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            if (this._isRequestingMovement)
            {
                return;
            }
            if (!param1)
            {
                if (FightContextFrame.currentCell == -1)
                {
                    return;
                }
                param1 = MapPoint.fromCellId(FightContextFrame.currentCell);
            }
            var _loc_2:* = DofusEntities.getEntity(CurrentPlayedFighterManager.getInstance().currentFighterId);
            if (!_loc_2)
            {
                this.removePath();
                return;
            }
            var _loc_4:* = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
            var _loc_7:* = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().movementPointsCurrent;
            var _loc_8:* = _loc_4.actionPointsCurrent;
            if (IMovable(_loc_2).isMoving || _loc_2.position.distanceToCell(param1) > _loc_4.movementPointsCurrent)
            {
                this.removePath();
                return;
            }
            var _loc_9:* = Pathfinding.findPath(DataMapProvider.getInstance(), _loc_2.position, param1, false, false, null, null, true);
            if (Pathfinding.findPath(DataMapProvider.getInstance(), _loc_2.position, param1, false, false, null, null, true).path.length == 0 || _loc_9.path.length > _loc_4.movementPointsCurrent)
            {
                this.removePath();
                return;
            }
            this._cells = new Vector.<uint>;
            this._cellsUnreachable = new Vector.<uint>;
            var _loc_10:* = true;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            var _loc_14:* = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntityInfos(_loc_2.id) as GameFightFighterInformations;
            for each (_loc_15 in _loc_9.path)
            {
                
                if (_loc_10)
                {
                    _loc_10 = false;
                }
                else
                {
                    _loc_3 = TackleUtil.getTackle(_loc_14, _loc_12.step);
                    _loc_5 = _loc_5 + int((_loc_7 - _loc_11) * (1 - _loc_3) + 0.5);
                    if (_loc_5 < 0)
                    {
                        _loc_5 = 0;
                    }
                    _loc_6 = _loc_6 + int(_loc_8 * (1 - _loc_3) + 0.5);
                    if (_loc_6 < 0)
                    {
                        _loc_6 = 0;
                    }
                    _loc_7 = _loc_4.movementPointsCurrent - _loc_5;
                    _loc_8 = _loc_4.actionPointsCurrent - _loc_6;
                    if (_loc_11 < _loc_7)
                    {
                        this._cells.push(_loc_15.step.cellId);
                        _loc_11++;
                    }
                    else
                    {
                        this._cellsUnreachable.push(_loc_15.step.cellId);
                    }
                }
                _loc_12 = _loc_15;
            }
            _loc_3 = TackleUtil.getTackle(_loc_14, _loc_12.step);
            _loc_5 = _loc_5 + int((_loc_7 - _loc_11) * (1 - _loc_3) + 0.5);
            if (_loc_5 < 0)
            {
                _loc_5 = 0;
            }
            _loc_6 = _loc_6 + int(_loc_8 * (1 - _loc_3) + 0.5);
            if (_loc_6 < 0)
            {
                _loc_6 = 0;
            }
            _loc_7 = _loc_4.movementPointsCurrent - _loc_5;
            _loc_8 = _loc_4.actionPointsCurrent - _loc_6;
            if (_loc_11 < _loc_7)
            {
                this._cells.push(_loc_9.end.cellId);
            }
            else
            {
                this._cellsUnreachable.push(_loc_9.end.cellId);
            }
            if (this._movementSelection == null)
            {
                this._movementSelection = new Selection();
                this._movementSelection.renderer = new MovementZoneRenderer(Dofus.getInstance().options.showMovementDistance);
                this._movementSelection.color = PATH_COLOR;
                SelectionManager.getInstance().addSelection(this._movementSelection, SELECTION_PATH);
            }
            if (this._cellsUnreachable.length > 0)
            {
                if (this._movementSelectionUnreachable == null)
                {
                    this._movementSelectionUnreachable = new Selection();
                    this._movementSelectionUnreachable.renderer = new MovementZoneRenderer(Dofus.getInstance().options.showMovementDistance, (_loc_7 + 1));
                    this._movementSelectionUnreachable.color = PATH_UNREACHABLE_COLOR;
                    SelectionManager.getInstance().addSelection(this._movementSelectionUnreachable, SELECTION_PATH_UNREACHABLE);
                }
                this._movementSelectionUnreachable.zone = new Custom(this._cellsUnreachable);
                SelectionManager.getInstance().update(SELECTION_PATH_UNREACHABLE);
            }
            else
            {
                _loc_16 = SelectionManager.getInstance().getSelection(SELECTION_PATH_UNREACHABLE);
                if (_loc_16)
                {
                    _loc_16.remove();
                    this._movementSelectionUnreachable = null;
                }
            }
            if (_loc_5 > 0 || _loc_6 > 0)
            {
                if (!this._cursorData)
                {
                    _loc_17 = new Sprite();
                    this._tfAP = new TextField();
                    this._tfAP.selectable = false;
                    _loc_18 = new TextFormat(FontManager.getInstance().getRealFontName("Verdana"), 16, 255, true);
                    this._tfAP.defaultTextFormat = _loc_18;
                    this._tfAP.setTextFormat(_loc_18);
                    this._tfAP.text = "-" + _loc_6 + " " + I18n.getUiText("ui.common.ap");
                    if (EmbedFontManager.getInstance().isEmbed(_loc_18.font))
                    {
                        this._tfAP.embedFonts = true;
                    }
                    this._tfAP.width = this._tfAP.textWidth + 5;
                    this._tfAP.height = this._tfAP.textHeight;
                    _loc_17.addChild(this._tfAP);
                    this._tfMP = new TextField();
                    this._tfMP.selectable = false;
                    _loc_18 = new TextFormat(FontManager.getInstance().getRealFontName("Verdana"), 16, 26112, true);
                    this._tfMP.defaultTextFormat = _loc_18;
                    this._tfMP.setTextFormat(_loc_18);
                    this._tfMP.text = "-" + _loc_5 + " " + I18n.getUiText("ui.common.mp");
                    if (EmbedFontManager.getInstance().isEmbed(_loc_18.font))
                    {
                        this._tfMP.embedFonts = true;
                    }
                    this._tfMP.width = this._tfMP.textWidth + 5;
                    this._tfMP.height = this._tfMP.textHeight;
                    this._tfMP.y = this._tfAP.height;
                    _loc_17.addChild(this._tfMP);
                    _loc_19 = new GlowFilter(16777215, 1, 4, 4, 3, 1);
                    _loc_17.filters = [_loc_19];
                    this._cursorData = new LinkedCursorData();
                    this._cursorData.sprite = _loc_17;
                    this._cursorData.sprite.cacheAsBitmap = true;
                    this._cursorData.offset = new Point(14, 14);
                }
                if (_loc_6 > 0)
                {
                    this._tfAP.text = "-" + _loc_6 + " " + I18n.getUiText("ui.common.ap");
                    this._tfAP.width = this._tfAP.textWidth + 5;
                    this._tfAP.visible = true;
                    this._tfMP.y = this._tfAP.height;
                }
                else
                {
                    this._tfAP.visible = false;
                    this._tfMP.y = 0;
                }
                if (_loc_5 > 0)
                {
                    this._tfMP.text = "-" + _loc_5 + " " + I18n.getUiText("ui.common.mp");
                    this._tfMP.width = this._tfMP.textWidth + 5;
                    this._tfMP.visible = true;
                }
                else
                {
                    this._tfMP.visible = false;
                }
                LinkedCursorSpriteManager.getInstance().addItem(TAKLED_CURSOR_NAME, this._cursorData, true);
            }
            else if (LinkedCursorSpriteManager.getInstance().getItem(TAKLED_CURSOR_NAME))
            {
                LinkedCursorSpriteManager.getInstance().removeItem(TAKLED_CURSOR_NAME);
            }
            this._movementSelection.zone = new Custom(this._cells);
            SelectionManager.getInstance().update(SELECTION_PATH);
            return;
        }// end function

        private function removePath() : void
        {
            var _loc_1:* = SelectionManager.getInstance().getSelection(SELECTION_PATH);
            if (_loc_1)
            {
                _loc_1.remove();
                this._movementSelection = null;
            }
            _loc_1 = SelectionManager.getInstance().getSelection(SELECTION_PATH_UNREACHABLE);
            if (_loc_1)
            {
                _loc_1.remove();
                this._movementSelectionUnreachable = null;
            }
            if (LinkedCursorSpriteManager.getInstance().getItem(TAKLED_CURSOR_NAME))
            {
                LinkedCursorSpriteManager.getInstance().removeItem(TAKLED_CURSOR_NAME);
            }
            return;
        }// end function

        private function askMoveTo(param1:MapPoint) : Boolean
        {
            var _loc_8:* = 0;
            var _loc_12:* = null;
            if (this._isRequestingMovement)
            {
                return false;
            }
            this._isRequestingMovement = true;
            var _loc_2:* = DofusEntities.getEntity(CurrentPlayedFighterManager.getInstance().currentFighterId);
            if (!_loc_2)
            {
                _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                var _loc_14:* = false;
                this._isRequestingMovement = false;
                return _loc_14;
            }
            if (IMovable(_loc_2).isMoving)
            {
                var _loc_14:* = false;
                this._isRequestingMovement = false;
                return _loc_14;
            }
            var _loc_3:* = Pathfinding.findPath(DataMapProvider.getInstance(), _loc_2.position, param1, false, false, null, null, true);
            var _loc_4:* = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
            if (_loc_3.path.length == 0 || _loc_3.path.length > _loc_4.movementPointsCurrent)
            {
                var _loc_14:* = false;
                this._isRequestingMovement = false;
                return _loc_14;
            }
            var _loc_5:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            var _loc_6:* = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntityInfos(_loc_2.id) as GameFightFighterInformations;
            var _loc_7:* = TackleUtil.getTackle(_loc_6, _loc_2.position);
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = _loc_4.movementPointsCurrent;
            this._cells = new Vector.<uint>;
            for each (_loc_12 in _loc_3.path)
            {
                
                if (_loc_10)
                {
                    _loc_7 = TackleUtil.getTackle(_loc_6, _loc_10.step);
                    _loc_8 = _loc_8 + int((_loc_11 - _loc_9) * (1 - _loc_7) + 0.5);
                    if (_loc_8 < 0)
                    {
                        _loc_8 = 0;
                    }
                    _loc_11 = _loc_4.movementPointsCurrent - _loc_8;
                    if (_loc_9 < _loc_11)
                    {
                        this._cells.push(_loc_12.step.cellId);
                        _loc_9++;
                    }
                    else
                    {
                        this._cellsUnreachable.push(_loc_12.step.cellId);
                    }
                }
                _loc_10 = _loc_12;
            }
            if (_loc_11 < _loc_3.length)
            {
                _loc_3.end = _loc_3.getPointAtIndex(_loc_11).step;
                _loc_3.deletePoint(_loc_11, 0);
            }
            var _loc_13:* = new GameMapMovementRequestMessage();
            new GameMapMovementRequestMessage().initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(_loc_3), PlayedCharacterManager.getInstance().currentMap.mapId);
            ConnectionsHandler.getConnection().send(_loc_13);
            this.removePath();
            return true;
        }// end function

        private function finishTurn() : void
        {
            var _loc_1:* = new GameFightTurnFinishMessage();
            ConnectionsHandler.getConnection().send(_loc_1);
            this._finishingTurn = false;
            return;
        }// end function

        private function startRemindTurn() : void
        {
            if (!this._myTurn)
            {
                return;
            }
            if (this._turnDuration > 0 && Dofus.getInstance().options.remindTurn)
            {
                if (this._remindTurnTimeoutId != 0)
                {
                    clearTimeout(this._remindTurnTimeoutId);
                }
                this._remindTurnTimeoutId = setTimeout(this.remindTurn, REMIND_TURN_DELAY);
            }
            return;
        }// end function

        private function remindTurn() : void
        {
            var _loc_1:* = I18n.getUiText("ui.fight.inactivity");
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_1, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
            KernelEventsManager.getInstance().processCallback(FightHookList.RemindTurn);
            clearTimeout(this._remindTurnTimeoutId);
            this._remindTurnTimeoutId = 0;
            return;
        }// end function

    }
}
