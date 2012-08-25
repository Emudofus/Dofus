package com.ankamagames.dofus.misc.utils.errormanager
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.internalDatacenter.fight.*;
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
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.graphics.codec.*;

    public class DofusErrorHandler extends Object
    {
        private var _saveReport:Boolean;
        private var _sendReport:Boolean;
        public static var maxStackTracelength:uint = 1000;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusErrorHandler));
        private static var _logBuffer:TemporaryBufferTarget;
        private static var _lastError:uint;
        private static var _htmlTemplate:Class = DofusErrorHandler__htmlTemplate;
        private static var ONLINE_REPORT_PLATEFORM:String = "http://utils.dofus.lan/bugs/";
        private static var ONLINE_REPORT_SERVICE:String = ONLINE_REPORT_PLATEFORM + "makeReport.php";
        private static var _manualActivation:CustomSharedObject = CustomSharedObject.getLocal("BugReport");

        public function DofusErrorHandler()
        {
            if (File.applicationDirectory.resolvePath("debug").exists || File.applicationDirectory.resolvePath("debug.txt").exists || _manualActivation.data && _manualActivation.data.force)
            {
                this.activeLogBuffer();
                this.activeDebugMode();
                this.activeShortcut();
                this.activeSOS();
                this.activeGlobalExceptionCatch();
                Log.exitIfNoConfigFile = false;
                this._saveReport = true;
            }
            switch(BuildInfos.BUILD_TYPE)
            {
                case BuildTypeEnum.RELEASE:
                {
                    break;
                }
                case BuildTypeEnum.BETA:
                case BuildTypeEnum.ALPHA:
                {
                    this._saveReport = true;
                    this.activeDebugMode();
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
                    this.activeGlobalExceptionCatch();
                    this._sendReport = true;
                    break;
                }
                default:
                {
                    this.activeSOS();
                    this.activeLogBuffer();
                    this.activeDebugMode();
                    this.activeShortcut();
                    this._sendReport = true;
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function activeDebugMode() : void
        {
            var debugFile:File;
            var fs:FileStream;
            try
            {
                debugFile = File.applicationDirectory.resolvePath("META-INF/AIR/debug");
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

        private function activeSOS() : void
        {
            var _loc_2:FileStream = null;
            var _loc_1:* = new File(File.applicationDirectory.resolvePath("log4as.xml").nativePath);
            if (!_loc_1.exists)
            {
                _loc_2 = new FileStream();
                _loc_2.open(_loc_1, FileMode.WRITE);
                _loc_2.writeUTFBytes(<logging>r
n	t	t	t	t	t	t<targets>r
n	t	t	t	t	t	t	t<target module=""com.ankamagames.jerakine.logger.targets.SOSTarget""/>r
n	t	t	t	t	t	t</targets>r
n	t	t	t	t	t</logging>")("<logging>
						<targets>
							<target module="com.ankamagames.jerakine.logger.targets.SOSTarget"/>
						</targets>
					</logging>);
                _loc_2.close();
            }
            Log.addTarget(new DebugTarget());
            return;
        }// end function

        private function activeLogBuffer() : void
        {
            if (!_logBuffer)
            {
                _logBuffer = new TemporaryBufferTarget();
            }
            Log.addTarget(_logBuffer);
            return;
        }// end function

        private function activeShortcut() : void
        {
            if (Dofus.getInstance().stage)
            {
                Dofus.getInstance().stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            }
            return;
        }// end function

        private function activeGlobalExceptionCatch() : void
        {
            ErrorManager.catchError = true;
            ErrorManager.eventDispatcher.addEventListener(ErrorReportedEvent.ERROR, this.onError);
            return;
        }// end function

        private function makeHtmlRepport(param1:Object) : String
        {
            var _loc_3:String = null;
            var _loc_4:JPEGEncoder = null;
            var _loc_2:* = new _htmlTemplate();
            if (param1.screenshot && param1.screenshot is BitmapData)
            {
                _loc_4 = new JPEGEncoder(80);
                param1.screenshot = Base64.encodeByteArray(_loc_4.encode(param1.screenshot));
            }
            for (_loc_3 in param1)
            {
                
                _loc_2 = _loc_2.replace("{{" + _loc_3 + "}}", param1[_loc_3]);
            }
            _lastError = getTimer();
            return _loc_2;
        }// end function

        private function getReportInfo(param1:Error, param2:String) : Object
        {
            var date:Date;
            var o:Object;
            var userNameData:Array;
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
                o.date = new Date();
                o.time = date.hours + ":" + date.minutes + ":" + date.seconds;
                o.date = date.date + "/" + (date.month + 1) + "/" + date.fullYear;
                o.buildType = BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE);
                o.buildVersion = BuildInfos.BUILD_VERSION;
                if (_logBuffer)
                {
                    htmlBuffer;
                    logs = _logBuffer.getBuffer();
                    var _loc_4:int = 0;
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
                if (!PlayedCharacterManager.getInstance().currentMap)
                {
                    return o;
                }
                o.mapId = PlayedCharacterManager.getInstance().currentMap.mapId + " (" + PlayedCharacterManager.getInstance().currentMap.x + "/" + PlayedCharacterManager.getInstance().currentMap.y + ")";
                o.look = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook).toString();
                obstacles;
                entities;
                los;
                o.wasFighting = this.getFightFrame() != null;
                if (o.wasFighting)
                {
                    fighterBuffer;
                    fighters = this.getFightFrame().battleFrame.fightersList;
                    var _loc_4:int = 0;
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
                    entityInfoProvider = Kernel.getWorker().getFrame(FightEntitiesFrame);
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
                        var _loc_4:int = 0;
                        var _loc_5:* = entitiesOnCell;
                        while (_loc_5 in _loc_4)
                        {
                            
                            entity = _loc_5[_loc_4];
                            entityInfo = entityInfoProvider.getEntityInfos(entity.id);
                            entityInfoData = DescribeTypeCache.getVariables(entityInfo, true);
                            entityInfoDataStr = "{cell:" + cellId + ",className:\'" + getQualifiedClassName(entityInfo).split("::").pop() + "\'";
                            var _loc_6:int = 0;
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
                        var _loc_4:int = 0;
                        var _loc_5:* = interactiveElements;
                        while (_loc_5 in _loc_4)
                        {
                            
                            ie = _loc_5[_loc_4];
                            ieInfoData = DescribeTypeCache.getVariables(ie, true);
                            iePos = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
                            ieInfoDataStr = "{cell:" + iePos.cellId + ",className:\'" + getQualifiedClassName(ie).split("::").pop() + "\'";
                            var _loc_6:int = 0;
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
            }
            return o;
        }// end function

        private function getFightFrame() : FightContextFrame
        {
            var _loc_1:* = Kernel.getWorker().getFrame(FightContextFrame);
            return _loc_1 as FightContextFrame;
        }// end function

        private function onError(event:ErrorReportedEvent) : void
        {
            var error:Error;
            var reportData:Object;
            var stackTrace:String;
            var tmp:Array;
            var line:String;
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
                tmp = error.getStackTrace().split("\n");
                var _loc_3:int = 0;
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
            reportData = this.getReportInfo(error, e.text);
            var buttons:Array;
            var popup:* = new SystemPopupUI("exception" + Math.random());
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
            if (this._saveReport)
            {
                buttons.push({label:"Save report", callback:function () : void
            {
                var _loc_1:* = File.desktopDirectory;
                var _loc_2:* = new Date();
                _loc_1.save(makeHtmlRepport(reportData), "dofus_bug_report_" + _loc_2.date + "-" + (_loc_2.month + 1) + "-" + _loc_2.fullYear + "_" + _loc_2.hours + "h" + _loc_2.minutes + "m" + _loc_2.seconds + "s.html");
                return;
            }// end function
            });
            }
            if (this._sendReport)
            {
                buttons.push({label:"Send report", callback:function () : void
            {
                var ur:* = new URLRequest(ONLINE_REPORT_SERVICE);
                ur.method = URLRequestMethod.POST;
                ur.data = new URLVariables();
                URLVariables(ur.data).userName = File.documentsDirectory.nativePath.split(File.separator)[2];
                URLVariables(ur.data).htmlContent = Base64.encode(makeHtmlRepport(reportData));
                var urlLoader:* = new URLLoader(ur);
                urlLoader.addEventListener(Event.COMPLETE, function (event:Event) : void
                {
                    var _loc_3:* = undefined;
                    var _loc_2:* = event.currentTarget.data;
                    if (_loc_2.charAt(0) == "0")
                    {
                        navigateToURL(new URLRequest(ONLINE_REPORT_PLATEFORM + _loc_2.substr(2)));
                    }
                    else
                    {
                        _loc_3 = new SystemPopupUI("exception" + Math.random());
                        _loc_3.width = 300;
                        _loc_3.centerContent = false;
                        _loc_3.title = "Error";
                        _loc_3.content = _loc_2.substr(2);
                        _loc_3.buttons = [{label:"OK", callback:trace}];
                        _loc_3.show();
                        if (!AirScanner.hasAir())
                        {
                            _loc_3.scaleX = 800 / 1280;
                            _loc_3.scaleY = 600 / 1024;
                        }
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            });
            }
            popup.buttons = buttons;
            popup.show();
            return;
        }// end function

        private function onKeyUp(event:KeyboardEvent) : void
        {
            if (event.keyCode == Keyboard.F11)
            {
                this.onError(new ErrorReportedEvent(null, "Manual bug report"));
            }
            return;
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
