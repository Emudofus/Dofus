package com.ankamagames.dofus.misc.utils.errormanager
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.internalDatacenter.fight.*;
    import com.ankamagames.dofus.internalDatacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.interClient.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.enum.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.logger.targets.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;

    public class DofusErrorHandler extends Object
    {
        private var _localSaveReport:Boolean = false;
        private var _distantSaveReport:Boolean = false;
        private var _sendErrorToWebservice:Boolean = false;
        public static var maxStackTracelength:uint = 1000;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusErrorHandler));
        private static var _logBuffer:TemporaryBufferTarget;
        private static var _lastError:uint;
        private static var _manualActivation:CustomSharedObject = CustomSharedObject.getLocal("BugReport");

        public function DofusErrorHandler(param1:Boolean = true)
        {
            if (param1)
            {
                this.activeManually();
                this.initData();
            }
            return;
        }// end function

        private function activeManually() : void
        {
            if (File.applicationDirectory.resolvePath("debug").exists || File.applicationDirectory.resolvePath("debug.txt").exists || _manualActivation.data && _manualActivation.data.force)
            {
                this.activeLogBuffer();
                this.activeDebugMode();
                this.activeShortcut();
                this.activeSOS();
                Log.exitIfNoConfigFile = false;
                this._localSaveReport = true;
            }
            else
            {
                this.removeDebugFile();
            }
            return;
        }// end function

        private function removeDebugFile() : void
        {
            var debugFile:File;
            try
            {
                debugFile = this.getDebugFile();
                if (debugFile && debugFile.exists)
                {
                    debugFile.deleteFile();
                }
            }
            catch (e:Error)
            {
                _log.info("Impossible de supprimer le fichier de debug : " + e.message);
            }
            return;
        }// end function

        private function initData() : void
        {
            switch(BuildInfos.BUILD_TYPE)
            {
                case BuildTypeEnum.RELEASE:
                {
                    break;
                }
                case BuildTypeEnum.BETA:
                case BuildTypeEnum.ALPHA:
                {
                    this._localSaveReport = true;
                    this.activeDebugMode();
                    this.activeGlobalExceptionCatch(false);
                    this.activeWebService();
                    break;
                }
                case BuildTypeEnum.TESTING:
                case BuildTypeEnum.EXPERIMENTAL:
                case BuildTypeEnum.INTERNAL:
                {
                    this.activeSOS();
                    this.activeLogBuffer();
                    this.activeDebugMode();
                    this.activeShortcut();
                    this.activeGlobalExceptionCatch(true);
                    this.activeWebService();
                    this._distantSaveReport = true;
                    break;
                }
                default:
                {
                    this.activeSOS();
                    this.activeLogBuffer();
                    this.activeDebugMode();
                    this.activeShortcut();
                    if (AirScanner.isStreamingVersion())
                    {
                        this.activeGlobalExceptionCatch(true);
                    }
                    this._distantSaveReport = true;
                    break;
                    break;
                }
            }
            this.createEmptyLog4As();
            return;
        }// end function

        private function onKeyUp(event:KeyboardEvent) : void
        {
            if (SystemManager.getSingleton().os == OperatingSystem.MAC_OS)
            {
                if (event.keyCode == Keyboard.F1)
                {
                    this.onError(new ErrorReportedEvent(null, "Manual bug report"));
                }
            }
            else if (event.keyCode == Keyboard.F11)
            {
                this.onError(new ErrorReportedEvent(null, "Manual bug report"));
            }
            return;
        }// end function

        public function activeDebugMode() : void
        {
            var debugFile:File;
            var fs:FileStream;
            try
            {
                debugFile = this.getDebugFile();
                debugFile = new File(debugFile.nativePath);
                fs = new FileStream();
                fs.open(debugFile, FileMode.WRITE);
                fs.writeUTF("");
                fs.close();
            }
            catch (e:Error)
            {
                _log.error("Impossible de créer le fichier debug dans " + debugFile.nativePath + "\nErreur:\n" + e.message);
            }
            return;
        }// end function

        private function getDebugFile() : File
        {
            var _loc_1:* = null;
            switch(this.getOs())
            {
                case OperatingSystem.MAC_OS:
                {
                    _loc_1 = File.applicationDirectory.resolvePath("../Resources/META-INF/AIR/debug");
                    break;
                }
                case OperatingSystem.WINDOWS:
                {
                    _loc_1 = File.applicationDirectory.resolvePath("META-INF/AIR/debug");
                    break;
                }
                default:
                {
                    return null;
                    break;
                }
            }
            return new File(_loc_1.nativePath);
        }// end function

        public function activeSOS() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = new File(File.applicationDirectory.resolvePath("log4as.xml").nativePath);
            if (!_loc_1.exists)
            {
                _loc_2 = new FileStream();
                _loc_2.open(_loc_1, FileMode.WRITE);
                _loc_2.writeUTFBytes(<logging>r
n	t	t	t	t	t<targets>r
n	t	t	t	t	t	t<target module=""com.ankamagames.jerakine.logger.targets.SOSTarget""/>r
n	t	t	t	t	t</targets>r
n	t	t	t	t</logging>")("<logging>
					<targets>
						<target module="com.ankamagames.jerakine.logger.targets.SOSTarget"/>
					</targets>
				</logging>);
                _loc_2.close();
            }
            Log.addTarget(new DebugTarget());
            return;
        }// end function

        public function createEmptyLog4As() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = new File(File.applicationDirectory.resolvePath("log4as.xml").nativePath);
            if (!_loc_1.exists)
            {
                _loc_2 = new FileStream();
                _loc_2.open(_loc_1, FileMode.WRITE);
                _loc_2.writeUTFBytes(<logging>r
n	t	t	t	t	t	t<targets>r
n	t	t	t	t	t	t</targets>r
n	t	t	t	t	t</logging>")("<logging>
						<targets>
						</targets>
					</logging>);
                _loc_2.close();
            }
            return;
        }// end function

        public function activeLogBuffer() : void
        {
            if (!_logBuffer)
            {
                _logBuffer = new TemporaryBufferTarget();
            }
            Log.addTarget(_logBuffer);
            return;
        }// end function

        public function activeShortcut() : void
        {
            if (Dofus.getInstance().stage)
            {
                Dofus.getInstance().stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            }
            return;
        }// end function

        public function activeGlobalExceptionCatch(param1:Boolean) : void
        {
            _log.info("Catch des exceptions activés");
            ErrorManager.catchError = true;
            _log.info("Affichage des popups: " + param1);
            ErrorManager.showPopup = param1;
            ErrorManager.eventDispatcher.addEventListener(ErrorReportedEvent.ERROR, this.onError);
            return;
        }// end function

        public function activeWebService() : void
        {
            this._sendErrorToWebservice = true;
            if (WebServiceDataHandler.buffer == null)
            {
                WebServiceDataHandler.buffer = new LimitedBufferTarget(50);
                Log.addTarget(WebServiceDataHandler.buffer);
            }
            return;
        }// end function

        private function onError(event:ErrorReportedEvent) : void
        {
            var error:Error;
            var report:ErrorReport;
            var stackTrace:String;
            var realStacktrace:String;
            var tmp:Array;
            var line:String;
            var exception:DataExceptionModel;
            var buttons:Array;
            var popup:SystemPopupUI;
            var e:* = event;
            var txt:* = e.text;
            error = e.error;
            if (error)
            {
                if (txt.length)
                {
                    txt = txt + "\n\n";
                }
                stackTrace;
                realStacktrace = error.getStackTrace();
                tmp = realStacktrace.split("\n");
                var _loc_3:* = 0;
                var _loc_4:* = tmp;
                while (_loc_4 in _loc_3)
                {
                    
                    line = _loc_4[_loc_3];
                    if (line.indexOf("ErrorManager") == -1 || line.indexOf("addError") == -1)
                    {
                        stackTrace = stackTrace + ((stackTrace.length ? ("\n") : ("")) + line);
                    }
                }
                txt = txt + stackTrace.substr(0, maxStackTracelength);
                if (stackTrace.length > maxStackTracelength)
                {
                    txt = txt + " ...";
                }
            }
            var reportInfo:* = this.getReportInfo(error, e.text);
            if (reportInfo != null)
            {
                report = new ErrorReport(reportInfo, _logBuffer);
            }
            _lastError = getTimer();
            if (this._sendErrorToWebservice)
            {
                exception = WebServiceDataHandler.getInstance().createNewException(reportInfo, e.errorType);
                if (exception != null)
                {
                    WebServiceDataHandler.getInstance().saveException(exception);
                }
            }
            if (e.showPopup)
            {
                buttons;
                popup = new SystemPopupUI("exception" + Math.random());
                popup.width = 1000;
                popup.centerContent = false;
                popup.title = "Information";
                popup.content = txt;
                buttons.push({label:"Skip"});
                if (error)
                {
                    buttons.push({label:"Copy to clipboard", callback:function () : void
            {
                System.setClipboard(e.text + "\n\n" + error.getStackTrace());
                return;
            }// end function
            });
                }
                if (this._localSaveReport)
                {
                    buttons.push({label:"Save report", callback:function () : void
            {
                report.saveReport();
                return;
            }// end function
            });
                }
                if (this._distantSaveReport)
                {
                    buttons.push({label:"Send report", callback:function () : void
            {
                report.sendReport();
                return;
            }// end function
            });
                }
                popup.buttons = buttons;
                popup.show();
            }
            return;
        }// end function

        public function getReportInfo(param1:Error, param2:String) : Object
        {
            var date:Date;
            var o:Object;
            var userNameData:Array;
            var currentMap:WorldPointWrapper;
            var obstacles:Array;
            var entities:Array;
            var los:Array;
            var cellId:uint;
            var mp:MapPoint;
            var entityInfoProvider:Object;
            var htmlBuffer:String;
            var logs:Array;
            var log:LogEvent;
            var screenshot:BitmapData;
            var m:Matrix;
            var fighterBuffer:String;
            var fighters:Vector.<int>;
            var fighterId:int;
            var fighterInfos:FighterInformations;
            var entitiesOnCell:Array;
            var entity:IEntity;
            var entityInfo:GameContextActorInformations;
            var entityInfoData:Array;
            var entityInfoDataStr:String;
            var key:String;
            var rpFrame:RoleplayEntitiesFrame;
            var interactiveElements:Vector.<InteractiveElement>;
            var ie:InteractiveElement;
            var ieInfoData:Array;
            var iePos:MapPoint;
            var ieInfoDataStr:String;
            var keyIe:String;
            var error:* = param1;
            var txt:* = param2;
            try
            {
                date = new Date();
                o = new Object();
                o.flashVersion = Capabilities.version;
                o.os = Capabilities.os;
                o.time = date.hours + ":" + date.minutes + ":" + date.seconds;
                o.date = date.date + "/" + (date.month + 1) + "/" + date.fullYear;
                o.buildType = BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE);
                if (AirScanner.isStreamingVersion())
                {
                    o.buildType = o.buildType + " STREAMING";
                }
                o.buildVersion = BuildInfos.BUILD_VERSION;
                if (_logBuffer)
                {
                    htmlBuffer;
                    logs = _logBuffer.getBuffer();
                    var _loc_4:* = 0;
                    var _loc_5:* = logs;
                    while (_loc_5 in _loc_4)
                    {
                        
                        log = _loc_5[_loc_4];
                        if (log is TextLogEvent && log.level > 0)
                        {
                            htmlBuffer = htmlBuffer + ("\t\t\t<li class=\"l_" + log.level + "\">" + log.message + "</li>\n");
                        }
                    }
                    o.logSos = htmlBuffer;
                }
                o.errorMsg = txt;
                if (error)
                {
                    o.stacktrace = error.getStackTrace();
                }
                userNameData = File.documentsDirectory.nativePath.split(File.separator);
                switch(SystemManager.getSingleton().os)
                {
                    case OperatingSystem.WINDOWS:
                    {
                        o.user = userNameData[2];
                        break;
                    }
                    case OperatingSystem.LINUX:
                    {
                        o.user = userNameData[2];
                        break;
                    }
                    case OperatingSystem.MAC_OS:
                    {
                        o.user = userNameData[2];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                o.multicompte = !InterClientManager.getInstance().isAlone;
                if (getTimer() - _lastError > 500)
                {
                    screenshot = new BitmapData(640, 512, false);
                    m = new Matrix();
                    m.scale(0.5, 0.5);
                    screenshot.draw(StageShareManager.stage, m, null, null, null, true);
                    o.screenshot = screenshot;
                    o.mouseX = StageShareManager.mouseX;
                    o.mouseY = StageShareManager.mouseY;
                }
                if (PlayerManager.getInstance().nickname)
                {
                    o.account = PlayerManager.getInstance().nickname + " (id: " + PlayerManager.getInstance().accountId + ")";
                }
                o.accountId = PlayerManager.getInstance().accountId;
                o.serverId = PlayerManager.getInstance().server.id;
                if (!PlayerManager.getInstance().server)
                {
                    return o;
                }
                o.server = PlayerManager.getInstance().server.name + " (id: " + PlayerManager.getInstance().server.id + ")";
                if (!PlayedCharacterManager.getInstance().infos)
                {
                    return o;
                }
                o.character = PlayedCharacterManager.getInstance().infos.name + " (id: " + PlayedCharacterManager.getInstance().id + ")";
                o.characterId = PlayedCharacterManager.getInstance().id;
                currentMap = PlayedCharacterManager.getInstance().currentMap;
                if (currentMap == null)
                {
                    return o;
                }
                o.mapId = currentMap.mapId + " (" + currentMap.x + "/" + currentMap.y + ")";
                o.look = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook).toString();
                o.idMap = currentMap.mapId;
                obstacles;
                entities;
                los;
                o.wasFighting = this.getFightFrame() != null;
                if (o.wasFighting)
                {
                    fighterBuffer;
                    fighters = this.getFightFrame().battleFrame.fightersList;
                    var _loc_4:* = 0;
                    var _loc_5:* = fighters;
                    while (_loc_5 in _loc_4)
                    {
                        
                        fighterId = _loc_5[_loc_4];
                        fighterInfos = new FighterInformations(fighterId);
                        fighterBuffer = fighterBuffer + ("<li><b>" + this.getFightFrame().getFighterName(fighterId) + "</b>, id: " + fighterId + ", lvl: " + this.getFightFrame().getFighterLevel(fighterId) + ", team: " + fighterInfos.team + ", vie: " + fighterInfos.lifePoints + ", pa:" + fighterInfos.actionPoints + ", pm:" + fighterInfos.movementPoints + ", cell:" + FightEntitiesFrame.getCurrentInstance().getEntityInfos(fighterId).disposition.cellId + "</li>");
                    }
                    o.fighterList = fighterBuffer;
                    o.currentPlayer = this.getFightFrame().getFighterName(this.getFightFrame().battleFrame.currentPlayerId);
                }
                if (!o.wasFighting)
                {
                    entityInfoProvider = Kernel.getWorker().getFrame(RoleplayEntitiesFrame);
                }
                else
                {
                    entityInfoProvider = this.getFightFrame();
                }
                cellId;
                while (cellId < AtouinConstants.MAP_CELLS_COUNT)
                {
                    
                    mp = MapPoint.fromCellId(cellId);
                    obstacles.push(DataMapProvider.getInstance().pointMov(mp.x, mp.y, true) ? (1) : (0));
                    los.push(DataMapProvider.getInstance().pointLos(mp.x, mp.y, true) ? (1) : (0));
                    entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(mp.cellId);
                    if (entityInfoProvider && entitiesOnCell.length)
                    {
                        var _loc_4:* = 0;
                        var _loc_5:* = entitiesOnCell;
                        while (_loc_5 in _loc_4)
                        {
                            
                            entity = _loc_5[_loc_4];
                            entityInfo = entityInfoProvider.getEntityInfos(entity.id);
                            entityInfoData = DescribeTypeCache.getVariables(entityInfo, true);
                            entityInfoDataStr = "{cell:" + cellId + ",className:\'" + getQualifiedClassName(entityInfo).split("::").pop() + "\'";
                            var _loc_6:* = 0;
                            var _loc_7:* = entityInfoData;
                            while (_loc_7 in _loc_6)
                            {
                                
                                key = _loc_7[_loc_6];
                                if (entityInfo[key] is int || entityInfo[key] is uint || entityInfo[key] is Number || entityInfo[key] is Boolean || entityInfo[key] is String)
                                {
                                    entityInfoDataStr = entityInfoDataStr + ("," + key + ":\"" + entityInfo[key] + "\"");
                                }
                            }
                            entities.push(entityInfoDataStr + "}");
                        }
                    }
                    cellId = (cellId + 1);
                }
                if (!o.wasFighting)
                {
                    rpFrame = entityInfoProvider as RoleplayEntitiesFrame;
                    if (rpFrame)
                    {
                        interactiveElements = rpFrame.interactiveElements;
                        var _loc_4:* = 0;
                        var _loc_5:* = interactiveElements;
                        while (_loc_5 in _loc_4)
                        {
                            
                            ie = _loc_5[_loc_4];
                            ieInfoData = DescribeTypeCache.getVariables(ie, true);
                            iePos = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
                            ieInfoDataStr = "{cell:" + iePos.cellId + ",className:\'" + getQualifiedClassName(ie).split("::").pop() + "\'";
                            var _loc_6:* = 0;
                            var _loc_7:* = ieInfoData;
                            while (_loc_7 in _loc_6)
                            {
                                
                                keyIe = _loc_7[_loc_6];
                                if (ie[keyIe] is int || ie[keyIe] is uint || ie[keyIe] is Number || ie[keyIe] is Boolean || ie[keyIe] is String)
                                {
                                    ieInfoDataStr = ieInfoDataStr + ("," + keyIe + ":\"" + ie[keyIe] + "\"");
                                }
                            }
                            entities.push(ieInfoDataStr + "}");
                        }
                    }
                }
                o.obstacles = obstacles.join(",");
                o.entities = entities.join(",");
                o.los = los.join(",");
            }
            catch (e:Error)
            {
                _log.error("Error lors du rapport de bug...");
            }
            return o;
        }// end function

        private function getFightFrame() : FightContextFrame
        {
            var _loc_1:* = Kernel.getWorker().getFrame(FightContextFrame);
            return _loc_1 as FightContextFrame;
        }// end function

        public function get localSaveReport() : Boolean
        {
            return this._localSaveReport;
        }// end function

        public function get distantSaveReport() : Boolean
        {
            return this._distantSaveReport;
        }// end function

        public function get sendErrorToWebservice() : Boolean
        {
            return this._sendErrorToWebservice;
        }// end function

        private function getOs() : String
        {
            var _loc_1:* = Capabilities.os;
            if (_loc_1 == OperatingSystem.LINUX)
            {
                return OperatingSystem.LINUX;
            }
            if (_loc_1.substr(0, OperatingSystem.MAC_OS.length) == OperatingSystem.MAC_OS)
            {
                return OperatingSystem.MAC_OS;
            }
            if (_loc_1.substr(0, OperatingSystem.WINDOWS.length) == OperatingSystem.WINDOWS)
            {
                return OperatingSystem.WINDOWS;
            }
            return null;
        }// end function

        public static function get manualActivation() : Boolean
        {
            return _manualActivation.data && _manualActivation.data.force;
        }// end function

        public static function set manualActivation(param1:Boolean) : void
        {
            if (!_manualActivation.data)
            {
                _manualActivation.data = {};
            }
            _manualActivation.data.force = param1;
            _manualActivation.flush();
            return;
        }// end function

    }
}
