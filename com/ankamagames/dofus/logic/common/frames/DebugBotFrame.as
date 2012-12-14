package com.ankamagames.dofus.logic.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.authorized.*;
    import com.ankamagames.dofus.network.messages.common.basic.*;
    import com.ankamagames.dofus.network.messages.game.chat.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class DebugBotFrame extends Object implements Frame
    {
        private var _frameFightListRequest:Boolean;
        private var _fightCount:uint;
        private var _mapPos:Array;
        private var _enabled:Boolean;
        private var _rollOverTimer:Timer;
        private var _actionTimer:Timer;
        private var _chatTimer:Timer;
        private var _inFight:Boolean;
        private var _lastElemOver:Sprite;
        private var _lastEntityOver:IInteractive;
        private var _wait:Boolean;
        private var _changeMap:Boolean = true;
        private var ttSentence:int = 0;
        private var limit:int = 100;
        private static var _self:DebugBotFrame;

        public function DebugBotFrame()
        {
            this._rollOverTimer = new Timer(2000);
            this._actionTimer = new Timer(5000);
            if (_self)
            {
                throw new SingletonError();
            }
            this.initRight();
            this._actionTimer.addEventListener(TimerEvent.TIMER, this.onAction);
            this._rollOverTimer.addEventListener(TimerEvent.TIMER, this.randomOver);
            return;
        }// end function

        public function enableChatMessagesBot(param1:Boolean, param2:int = 500) : void
        {
            if (param1)
            {
                this._changeMap = false;
                this._chatTimer = new Timer(param2);
                this._chatTimer.addEventListener(TimerEvent.TIMER, this.sendChatMessage);
            }
            else if (this._chatTimer)
            {
                this._changeMap = true;
                this._chatTimer.removeEventListener(TimerEvent.TIMER, this.sendChatMessage);
            }
            return;
        }// end function

        public function pushed() : Boolean
        {
            this._enabled = true;
            this.fakeActivity();
            this._actionTimer.start();
            this._rollOverTimer.start();
            if (this._chatTimer)
            {
                this._chatTimer.start();
            }
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
            if (this._chatTimer)
            {
                this._chatTimer.stop();
            }
            this._enabled = false;
            return true;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function get fightCount() : uint
        {
            return this._fightCount;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            switch(true)
            {
                case param1 is MapFightCountMessage:
                {
                    _loc_2 = param1 as MapFightCountMessage;
                    if (_loc_2.fightCount)
                    {
                        _loc_8 = new MapRunningFightListRequestMessage();
                        _loc_8.initMapRunningFightListRequestMessage();
                        ConnectionsHandler.getConnection().send(_loc_8);
                        this._frameFightListRequest = true;
                    }
                    break;
                }
                case param1 is MapRunningFightListMessage:
                {
                    if (!this._frameFightListRequest)
                    {
                        break;
                    }
                    this._frameFightListRequest = false;
                    _loc_3 = param1 as MapRunningFightListMessage;
                    for each (_loc_9 in _loc_3.fights)
                    {
                        
                        if (_loc_9.fightTeams.length > _loc_5)
                        {
                            _loc_5 = _loc_9.fightTeams.length;
                            _loc_4 = _loc_9.fightId;
                        }
                    }
                    if (this._wait || Math.random() < 0.6)
                    {
                        return true;
                    }
                    _loc_6 = new GameFightJoinRequestMessage();
                    _loc_6.initGameFightJoinRequestMessage(0, _loc_4);
                    ConnectionsHandler.getConnection().send(_loc_6);
                    this._actionTimer.reset();
                    this._actionTimer.start();
                    return true;
                }
                case param1 is GameFightJoinMessage:
                {
                    var _loc_10:* = this;
                    var _loc_11:* = this._fightCount + 1;
                    _loc_10._fightCount = _loc_11;
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
                case param1 is ChatServerMessage:
                {
                    _loc_7 = param1 as ChatServerMessage;
                    if (_loc_7.channel == ChatChannelsMultiEnum.CHANNEL_SALES || _loc_7.channel == ChatChannelsMultiEnum.CHANNEL_SEEK && Math.random() > 0.95)
                    {
                        this.join(_loc_7.senderName);
                    }
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
            var _loc_1:* = new AdminQuietCommandMessage();
            _loc_1.initAdminQuietCommandMessage("adminaway");
            ConnectionsHandler.getConnection().send(_loc_1);
            _loc_1.initAdminQuietCommandMessage("god");
            ConnectionsHandler.getConnection().send(_loc_1);
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
            if (this._inFight || this._wait || !this._changeMap)
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
            var _loc_2:* = null;
            var _loc_4:* = null;
            if (this._inFight || this._wait)
            {
                return;
            }
            var _loc_1:* = [];
            for each (_loc_2 in MapDisplayManager.getInstance().getDataMapContainer().getCell())
            {
                
                _loc_4 = MapPoint.fromCellId(_loc_2.id);
                if (DataMapProvider.getInstance().pointMov(_loc_4.x, _loc_4.y))
                {
                    _loc_1.push(_loc_4);
                }
            }
            if (!_loc_1)
            {
                return;
            }
            var _loc_3:* = new CellClickMessage();
            _loc_3.cell = _loc_1[Math.floor(_loc_1.length * Math.random())];
            _loc_3.cellId = _loc_3.cell.cellId;
            _loc_3.id = MapDisplayManager.getInstance().currentMapPoint.mapId;
            Kernel.getWorker().process(_loc_3);
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
                _loc_12 = GenericPool.get(MouseOutMessage, this._lastElemOver, new MouseEvent(MouseEvent.MOUSE_OUT));
                Kernel.getWorker().process(_loc_12);
            }
            var _loc_8:* = _loc_6[Math.floor(_loc_6.length * Math.random())];
            var _loc_9:* = GenericPool.get(MouseOverMessage, _loc_8, new MouseEvent(MouseEvent.MOUSE_OVER));
            Kernel.getWorker().process(_loc_9);
            this._lastElemOver = _loc_8;
            return;
        }// end function

        private function sendChatMessage(event:TimerEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = Math.random() * 16777215;
            var _loc_3:* = new Vector.<String>;
            _loc_3[0] = "Test html: salut <span style=\"color:#" + (Math.random() * 16777215).toString(8) + "\">je suis la</span> et la";
            _loc_3[1] = "i\'m batman";
            _loc_3[2] = HtmlManager.addLink("i\'m a link now, awesome !!", "");
            _loc_3[3] = ":( sd :p :) fdg dfg f";
            _loc_3[4] = "je suis <u>underlineeeeeee</u> et moi <b>BOLD</b>" + "\nEt un retour a la ligne, un !!";
            _loc_3[5] = "*test de texte italic via la commande*";
            var _loc_4:* = _loc_3[Math.floor(Math.random() * _loc_3.length)];
            var _loc_7:* = this;
            var _loc_8:* = this.ttSentence + 1;
            _loc_7.ttSentence = _loc_8;
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_4, ChatActivableChannelsEnum.CHANNEL_GLOBAL);
            if (this.ttSentence > (this.limit + 1))
            {
                var _loc_7:* = this;
                var _loc_8:* = this.ttSentence - 1;
                _loc_7.ttSentence = _loc_8;
                _loc_5 = 0;
                _loc_6 = 1;
                KernelEventsManager.getInstance().processCallback(ChatHookList.NewMessage, _loc_5, _loc_6);
            }
            return;
        }// end function

        public static function getInstance() : DebugBotFrame
        {
            if (!_self)
            {
                _self = new DebugBotFrame;
            }
            return _self;
        }// end function

    }
}
