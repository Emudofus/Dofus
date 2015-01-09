package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
    import flash.display.Stage;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.dofus.network.messages.security.CheckFileRequestMessage;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;
    import com.ankamagames.dofus.network.messages.security.CheckFileMessage;
    import com.ankamagames.dofus.network.messages.game.approach.ServerOptionalFeaturesMessage;
    import com.ankamagames.dofus.network.messages.game.approach.ServerSettingsMessage;
    import com.ankamagames.dofus.network.messages.game.approach.ServerSessionConstantsMessage;
    import com.ankamagames.dofus.network.messages.game.basic.CurrentServerStatusUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.AccountHouseMessage;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
    import flash.filesystem.File;
    import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstant;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import by.blooddy.crypto.MD5;
    import flash.filesystem.FileMode;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstantInteger;
    import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstantLong;
    import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstantString;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.types.enums.Priority;

    public class MiscFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MiscFrame));
        private static const SERVER_CONST_TIME_BEFORE_DISCONNECTION:int = 1;
        private static const SERVER_CONST_KOH_DURATION:int = 2;
        private static const SERVER_CONST_KOH_WINNING_SCORE:int = 3;
        private static const SERVER_CONST_MINIMAL_TIME_BEFORE_KOH:int = 4;
        private static const SERVER_CONST_TIME_BEFORE_WEIGH_IN_KOH:int = 5;
        private static var _instance:MiscFrame;

        private var _optionalAuthorizedFeatures:Array;
        private var _serverSessionConstants:Dictionary;
        private var _accountHouses:Vector.<AccountHouseInformations>;
        private var _stage:Stage;
        private var _mouseOnStage:Boolean = true;
        private var _serverStatus:uint;


        public static function getInstance():MiscFrame
        {
            return (_instance);
        }


        public function isOptionalFeatureActive(id:uint):Boolean
        {
            if (((this._optionalAuthorizedFeatures) && ((this._optionalAuthorizedFeatures.indexOf(id) > -1))))
            {
                return (true);
            };
            return (false);
        }

        public function get accountHouses():Vector.<AccountHouseInformations>
        {
            return (this._accountHouses);
        }

        public function pushed():Boolean
        {
            _instance = this;
            this._serverSessionConstants = new Dictionary(true);
            this._stage = StageShareManager.stage;
            this._stage.addEventListener(Event.MOUSE_LEAVE, this.onMouseLeave);
            return (true);
        }

        public function pulled():Boolean
        {
            _instance = null;
            this._stage.removeEventListener(Event.MOUSE_LEAVE, this.onMouseLeave);
            if (!(this._mouseOnStage))
            {
                this._stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            };
            this._stage = null;
            return (true);
        }

        public function getServerSessionConstant(id:int):Object
        {
            return (this._serverSessionConstants[id]);
        }

        public function getServerStatus():uint
        {
            return (this._serverStatus);
        }

        public function process(msg:Message):Boolean
        {
            var mrcMsg:MouseRightClickMessage;
            var current:DisplayObject;
            var beriliaContainer:DisplayObjectContainer;
            var cfrmsg:CheckFileRequestMessage;
            var fileStream:FileStream;
            var fileByte:ByteArray;
            var value:String;
            var filenameHash:String;
            var cfmsg:CheckFileMessage;
            var sofmsg:ServerOptionalFeaturesMessage;
            var ssmsg:ServerSettingsMessage;
            var sscmsg:ServerSessionConstantsMessage;
            var cssum:CurrentServerStatusUpdateMessage;
            var ahm:AccountHouseMessage;
            var mwMsg:MouseWheelMessage;
            var currentW:DisplayObject;
            var stage:Stage;
            var beriliaContainerW:DisplayObjectContainer;
            var wheelUp:Boolean;
            var file:File;
            var featureId:int;
            var constant:ServerSessionConstant;
            switch (true)
            {
                case (msg is MouseRightClickMessage):
                    mrcMsg = (msg as MouseRightClickMessage);
                    current = mrcMsg.target;
                    beriliaContainer = Berilia.getInstance().docMain;
                    while (((!((current == stage))) && (current)))
                    {
                        if (beriliaContainer == current)
                        {
                            return (false);
                        };
                        current = current.parent;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.WorldRightClick);
                    return (true);
                case (msg is MouseWheelMessage):
                    if (this._mouseOnStage)
                    {
                        mwMsg = (msg as MouseWheelMessage);
                        currentW = mwMsg.target;
                        stage = StageShareManager.stage;
                        beriliaContainerW = Berilia.getInstance().docMain;
                        while (((!((currentW == stage))) && (currentW)))
                        {
                            if (beriliaContainerW == currentW)
                            {
                                return (false);
                            };
                            currentW = currentW.parent;
                        };
                        wheelUp = false;
                        if (mwMsg.mouseEvent.delta > 0)
                        {
                            wheelUp = true;
                        };
                        KernelEventsManager.getInstance().processCallback(HookList.WorldMouseWheel, wheelUp);
                        return (true);
                    };
                    return (false);
                case (msg is CheckFileRequestMessage):
                    cfrmsg = (msg as CheckFileRequestMessage);
                    fileStream = new FileStream();
                    fileByte = new ByteArray();
                    value = "";
                    filenameHash = MD5.hash(cfrmsg.filename);
                    try
                    {
                        file = File.applicationDirectory;
                        if (((!(file)) || (!(file.exists))))
                        {
                            value = "-1";
                        }
                        else
                        {
                            file = file.resolvePath(("./" + cfrmsg.filename));
                            fileStream.open(file, FileMode.READ);
                            fileStream.readBytes(fileByte);
                            fileStream.close();
                        };
                    }
                    catch(e:Error)
                    {
                        if (e)
                        {
                            _log.error(e.getStackTrace());
                            value = "-1";
                        };
                    }
                    finally
                    {
                        if (fileStream)
                        {
                            fileStream.close();
                        };
                    };
                    if (value == "")
                    {
                        if (cfrmsg.type == 0)
                        {
                            value = fileByte.length.toString();
                        }
                        else
                        {
                            if (cfrmsg.type == 1)
                            {
                                value = MD5.hash(fileByte.toString());
                            };
                        };
                    };
                    cfmsg = new CheckFileMessage();
                    cfmsg.initCheckFileMessage(filenameHash, cfrmsg.type, value);
                    ConnectionsHandler.getConnection().send(cfmsg);
                    return (true);
                case (msg is ServerOptionalFeaturesMessage):
                    sofmsg = (msg as ServerOptionalFeaturesMessage);
                    this._optionalAuthorizedFeatures = new Array();
                    for each (featureId in sofmsg.features)
                    {
                        this._optionalAuthorizedFeatures.push(featureId);
                    };
                    return (true);
                case (msg is ServerSettingsMessage):
                    ssmsg = (msg as ServerSettingsMessage);
                    PlayerManager.getInstance().serverCommunityId = ssmsg.community;
                    PlayerManager.getInstance().serverLang = ssmsg.lang;
                    PlayerManager.getInstance().serverGameType = ssmsg.gameType;
                    return (true);
                case (msg is ServerSessionConstantsMessage):
                    sscmsg = (msg as ServerSessionConstantsMessage);
                    this._serverSessionConstants = new Dictionary(true);
                    for each (constant in sscmsg.variables)
                    {
                        if ((constant is ServerSessionConstantInteger))
                        {
                            this._serverSessionConstants[constant.id] = (constant as ServerSessionConstantInteger).value;
                        }
                        else
                        {
                            if ((constant is ServerSessionConstantLong))
                            {
                                this._serverSessionConstants[constant.id] = (constant as ServerSessionConstantLong).value;
                            }
                            else
                            {
                                if ((constant is ServerSessionConstantString))
                                {
                                    this._serverSessionConstants[constant.id] = (constant as ServerSessionConstantString).value;
                                }
                                else
                                {
                                    this._serverSessionConstants[constant.id] = null;
                                };
                            };
                        };
                    };
                    return (true);
                case (msg is CurrentServerStatusUpdateMessage):
                    cssum = (msg as CurrentServerStatusUpdateMessage);
                    this._serverStatus = cssum.status;
                    KernelEventsManager.getInstance().processCallback(HookList.ServerStatusUpdate, this._serverStatus);
                    return (true);
                case (msg is AccountHouseMessage):
                    ahm = (msg as AccountHouseMessage);
                    this._accountHouses = ahm.houses;
                    KernelEventsManager.getInstance().processCallback(HookList.HouseInformations, ahm.houses);
                    return (true);
            };
            return (false);
        }

        public function get priority():int
        {
            return (Priority.LOW);
        }

        private function onMouseLeave(e:Event):void
        {
            this._mouseOnStage = false;
            this._stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        }

        private function onMouseMove(e:Event):void
        {
            this._mouseOnStage = true;
            this._stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        }


    }
}//package com.ankamagames.dofus.logic.common.frames

