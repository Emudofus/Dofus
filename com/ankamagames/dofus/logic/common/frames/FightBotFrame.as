package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.messages.authorized.*;
    import com.ankamagames.dofus.network.messages.common.basic.*;
    import com.ankamagames.dofus.network.messages.game.actions.fight.*;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class FightBotFrame extends Object implements Frame
    {
        private var _frameFightListRequest:Boolean;
        private var _fightCount:uint;
        private var _mapPos:Array;
        private var _enabled:Boolean;
        private var _rollOverTimer:Timer;
        private var _actionTimer:Timer;
        private var _inFight:Boolean;
        private var _lastElemOver:Sprite;
        private var _lastEntityOver:IInteractive;
        private var _wait:Boolean;
        private var _turnPlayed:uint;
        private var _myTurn:Boolean;
        private var _turnAction:Array;
        private static var _self:FightBotFrame;

        public function FightBotFrame()
        {
            this._rollOverTimer = new Timer(2000);
            this._actionTimer = new Timer(5000);
            this._turnAction = [];
            if (_self)
            {
                throw new SingletonError();
            }
            this.initRight();
            this._actionTimer.addEventListener(TimerEvent.TIMER, this.onAction);
            this._rollOverTimer.addEventListener(TimerEvent.TIMER, this.randomOver);
            return;
        }// end function

        public function pushed() : Boolean
        {
            this._enabled = true;
            this.fakeActivity();
            this._myTurn = false;
            this._actionTimer.start();
            this._rollOverTimer.start();
            this._mapPos = MapPosition.getMapPositions();
            var _loc_1:* = new MapFightCountMessage();
            _loc_1.initMapFightCountMessage(1);
            this.process(_loc_1);
            return true;
        }// end function

        public function pulled() : Boolean
        {
            this._rollOverTimer.stop();
            this._actionTimer.stop();
            this._enabled = false;
            return true;
        }// end function

        public function get priority() : int
        {
            return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
        }// end function

        public function get fightCount() : uint
        {
            return this._fightCount;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            switch(true)
            {
                case param1 is GameFightJoinMessage:
                {
                    var _loc_4:* = this;
                    var _loc_5:* = this._fightCount + 1;
                    _loc_4._fightCount = _loc_5;
                    this._inFight = true;
                    break;
                }
                case param1 is GameFightEndMessage:
                {
                    this._inFight = false;
                    break;
                }
                case param1 is MapComplementaryInformationsDataMessage:
                {
                    this._wait = false;
                    break;
                }
                case param1 is MapsLoadingStartedMessage:
                {
                    this._wait = true;
                    break;
                }
                case param1 is GameFightShowFighterMessage:
                {
                    this.sendAdminCmd("givelife *");
                    this.sendAdminCmd("giveenergy *");
                    this._turnPlayed = 0;
                    this._myTurn = false;
                    _loc_2 = new GameFightReadyMessage();
                    _loc_2.initGameFightReadyMessage(true);
                    ConnectionsHandler.getConnection().send(_loc_2);
                    break;
                }
                case param1 is GameFightTurnStartMessage:
                {
                    _loc_3 = param1 as GameFightTurnStartMessage;
                    this._turnAction = [];
                    if (_loc_3.id == PlayedCharacterManager.getInstance().id)
                    {
                        this._myTurn = true;
                        var _loc_4:* = this;
                        var _loc_5:* = this._turnPlayed + 1;
                        _loc_4._turnPlayed = _loc_5;
                        if (this._turnPlayed > 2)
                        {
                            this.castSpell(411, true);
                        }
                        else
                        {
                            this.addTurnAction(this.fightRandomMove, []);
                            this.addTurnAction(this.castSpell, [173, false]);
                            this.addTurnAction(this.castSpell, [173, false]);
                            this.addTurnAction(this.castSpell, [173, false]);
                            this.addTurnAction(this.turnEnd, []);
                            this.nextTurnAction();
                        }
                    }
                    else
                    {
                        this._myTurn = false;
                    }
                    break;
                }
                case param1 is SequenceEndMessage:
                {
                    this.nextTurnAction();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function initRight() : void
        {
            this.sendAdminCmd("adminaway");
            this.sendAdminCmd("givelevel * 200");
            this.sendAdminCmd("givespell * 173 6");
            this.sendAdminCmd("givespell * 411 6");
            this.sendAdminCmd("dring po=63,vita=8000,pa=100,agi=150 true");
            return;
        }// end function

        private function sendAdminCmd(param1:String) : void
        {
            var _loc_2:* = new AdminQuietCommandMessage();
            _loc_2.initAdminQuietCommandMessage(param1);
            ConnectionsHandler.getConnection().send(_loc_2);
            return;
        }// end function

        private function onAction(event:Event) : void
        {
            if (Math.random() < 0.9)
            {
                this.randomWalk();
            }
            else
            {
                this.randomMove();
            }
            return;
        }// end function

        private function nextTurnAction() : void
        {
            var _loc_1:* = null;
            if (this._turnAction.length)
            {
                _loc_1 = this._turnAction.shift();
                _loc_1.fct.apply(this, _loc_1.args);
            }
            return;
        }// end function

        private function addTurnAction(param1:Function, param2:Array) : void
        {
            this._turnAction.push({fct:param1, args:param2});
            return;
        }// end function

        private function turnEnd() : void
        {
            var _loc_1:* = new GameFightTurnFinishMessage();
            _loc_1.initGameFightTurnFinishMessage();
            ConnectionsHandler.getConnection().send(_loc_1);
            return;
        }// end function

        private function join(param1:String) : void
        {
            if (this._inFight || this._wait)
            {
                return;
            }
            var _loc_2:* = new AdminQuietCommandMessage();
            _loc_2.initAdminQuietCommandMessage("join " + param1);
            ConnectionsHandler.getConnection().send(_loc_2);
            this._actionTimer.reset();
            this._actionTimer.start();
            return;
        }// end function

        private function randomMove() : void
        {
            if (this._inFight || this._wait)
            {
                return;
            }
            var _loc_1:* = this._mapPos[int(Math.random() * this._mapPos.length)];
            var _loc_2:* = new AdminQuietCommandMessage();
            _loc_2.initAdminQuietCommandMessage("moveto " + _loc_1.id);
            ConnectionsHandler.getConnection().send(_loc_2);
            this._actionTimer.reset();
            this._actionTimer.start();
            return;
        }// end function

        private function fakeActivity() : void
        {
            if (!this._enabled)
            {
                return;
            }
            setTimeout(this.fakeActivity, 1000 * 60 * 5);
            var _loc_1:* = new BasicPingMessage();
            _loc_1.initBasicPingMessage(false);
            ConnectionsHandler.getConnection().send(_loc_1);
            return;
        }// end function

        private function randomWalk() : void
        {
            var _loc_3:* = undefined;
            var _loc_5:* = null;
            if (this._inFight || this._wait)
            {
                return;
            }
            var _loc_1:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if (!_loc_1)
            {
                return;
            }
            var _loc_2:* = [];
            for each (_loc_3 in _loc_1.getEntitiesDictionnary())
            {
                
                if (_loc_3 is GameRolePlayGroupMonsterInformations)
                {
                    _loc_5 = DofusEntities.getEntity(GameRolePlayGroupMonsterInformations(_loc_3).contextualId);
                    _loc_2.push(MapPoint.fromCellId(_loc_5.position.cellId));
                }
            }
            if (!_loc_2 || !_loc_2.length)
            {
                return;
            }
            var _loc_4:* = new CellClickMessage();
            new CellClickMessage().cell = _loc_2[Math.floor(_loc_2.length * Math.random())];
            _loc_4.cellId = _loc_4.cell.cellId;
            _loc_4.id = MapDisplayManager.getInstance().currentMapPoint.mapId;
            Kernel.getWorker().process(_loc_4);
            return;
        }// end function

        private function fightRandomMove() : void
        {
            var _loc_1:* = new FightReachableCellsMaker(FightEntitiesFrame.getCurrentInstance().getEntityInfos(PlayedCharacterManager.getInstance().id) as GameFightFighterInformations);
            if (!_loc_1.reachableCells.length)
            {
                this.nextTurnAction();
                return;
            }
            var _loc_2:* = new CellClickMessage();
            _loc_2.cell = MapPoint.fromCellId(_loc_1.reachableCells[Math.floor(_loc_1.reachableCells.length * Math.random())]);
            _loc_2.cellId = _loc_2.cell.cellId;
            _loc_2.id = MapDisplayManager.getInstance().currentMapPoint.mapId;
            Kernel.getWorker().process(_loc_2);
            return;
        }// end function

        private function randomOver(... args) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_7:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (this._wait)
            {
                return;
            }
            args = [];
            for each (_loc_3 in EntitiesManager.getInstance().entities)
            {
                
                if (_loc_3 is IInteractive)
                {
                    args.push(_loc_3);
                }
            }
            _loc_4 = args[Math.floor(args.length * Math.random())];
            if (!_loc_4)
            {
                return;
            }
            if (this._lastEntityOver)
            {
                _loc_10 = new EntityMouseOutMessage(this._lastEntityOver);
                Kernel.getWorker().process(_loc_10);
            }
            this._lastEntityOver = _loc_4;
            var _loc_5:* = new EntityMouseOverMessage(_loc_4);
            Kernel.getWorker().process(_loc_5);
            var _loc_6:* = [];
            for each (_loc_7 in Berilia.getInstance().uiList)
            {
                
                for each (_loc_11 in _loc_7.getElements())
                {
                    
                    if (_loc_11.mouseChildren || _loc_11.mouseEnabled)
                    {
                        _loc_6.push(_loc_11);
                    }
                }
            }
            if (!_loc_6.length)
            {
                return;
            }
            if (this._lastElemOver)
            {
                _loc_12 = new MouseOutMessage(this._lastElemOver, new MouseEvent(MouseEvent.MOUSE_OUT));
                Kernel.getWorker().process(_loc_12);
            }
            var _loc_8:* = _loc_6[Math.floor(_loc_6.length * Math.random())];
            var _loc_9:* = new MouseOverMessage(_loc_8, new MouseEvent(MouseEvent.MOUSE_OVER));
            Kernel.getWorker().process(_loc_9);
            this._lastElemOver = _loc_8;
            return;
        }// end function

        private function castSpell(param1:uint, param2:Boolean) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_3:* = new GameActionFightCastRequestMessage();
            if (param2)
            {
                _loc_4 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(PlayedCharacterManager.getInstance().id).disposition.cellId;
            }
            else
            {
                _loc_5 = [];
                for each (_loc_6 in FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary())
                {
                    
                    if (_loc_6.contextualId < 0 && _loc_6 is GameFightMonsterInformations)
                    {
                        _loc_7 = _loc_6 as GameFightMonsterInformations;
                        if (_loc_7.alive)
                        {
                            _loc_5.push(_loc_6.disposition.cellId);
                        }
                    }
                }
                _loc_4 = _loc_5[Math.floor(_loc_5.length * Math.random())];
            }
            _loc_3.initGameActionFightCastRequestMessage(param1, _loc_4);
            ConnectionsHandler.getConnection().send(_loc_3);
            return;
        }// end function

        public static function getInstance() : FightBotFrame
        {
            if (!_self)
            {
                _self = new FightBotFrame;
            }
            return _self;
        }// end function

    }
}
