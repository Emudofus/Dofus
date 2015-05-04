package com.ankamagames.dofus.misc.utils.errormanager
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.targets.TemporaryBufferTarget;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import flash.events.KeyboardEvent;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import flash.ui.Keyboard;
   import com.ankamagames.jerakine.types.events.ErrorReportedEvent;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   import com.ankamagames.dofus.misc.utils.DebugTarget;
   import flash.events.Event;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.logger.targets.LimitedBufferTarget;
   import com.ankamagames.jerakine.utils.system.SystemPopupUI;
   import flash.utils.getTimer;
   import flash.system.System;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.logger.LogEvent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import flash.system.Capabilities;
   import flash.desktop.NativeApplication;
   import com.ankamagames.dofus.misc.BuildTypeParser;
   import com.ankamagames.jerakine.logger.TextLogEvent;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.jerakine.messages.Frame;
   
   public class DofusErrorHandler extends Object
   {
      
      public function DofusErrorHandler(param1:Boolean = true)
      {
         super();
         if(param1)
         {
            this.activeManually();
            this.initData();
         }
         _self = this;
      }
      
      public static var maxStackTracelength:uint = 1000;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusErrorHandler));
      
      private static const MANUAL_BUG_REPORT_TXT:String = "Manual bug report";
      
      private static var _logBuffer:TemporaryBufferTarget;
      
      private static var _lastError:uint;
      
      private static var _manualActivation:CustomSharedObject = CustomSharedObject.getLocal("BugReport");
      
      private static var _self:DofusErrorHandler;
      
      public static function get manualActivation() : Boolean
      {
         return (_manualActivation.data) && (_manualActivation.data.force);
      }
      
      public static function set manualActivation(param1:Boolean) : void
      {
         if(!_manualActivation.data)
         {
            _manualActivation.data = {};
         }
         _manualActivation.data.force = param1;
         _manualActivation.flush();
      }
      
      public static function get debugFileExists() : Boolean
      {
         return (File.applicationDirectory.resolvePath("debug").exists) || (File.applicationDirectory.resolvePath("debug.txt").exists);
      }
      
      public static function activateDebugMode() : void
      {
         _self.activeManually();
      }
      
      private var _localSaveReport:Boolean = false;
      
      private var _distantSaveReport:Boolean = false;
      
      private var _sendErrorToWebservice:Boolean = false;
      
      public function activeManually() : void
      {
         if((File.applicationDirectory.resolvePath("debug").exists) || (File.applicationDirectory.resolvePath("debug.txt").exists) || (_manualActivation.data) && (_manualActivation.data.force))
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
      }
      
      private function removeDebugFile() : void
      {
         var debugFile:File = null;
         try
         {
            debugFile = this.getDebugFile();
            if((debugFile) && (debugFile.exists))
            {
               debugFile.deleteFile();
            }
         }
         catch(e:Error)
         {
            _log.info("Impossible de supprimer le fichier de debug : " + e.message);
         }
      }
      
      private function initData() : void
      {
         switch(BuildInfos.BUILD_TYPE)
         {
            case BuildTypeEnum.RELEASE:
               break;
            case BuildTypeEnum.BETA:
            case BuildTypeEnum.ALPHA:
               this._localSaveReport = true;
               this.activeDebugMode();
               if(AirScanner.isStreamingVersion())
               {
                  this.activeShortcut();
               }
               this.activeGlobalExceptionCatch(false);
               this.activeWebService();
               break;
            case BuildTypeEnum.TESTING:
            case BuildTypeEnum.EXPERIMENTAL:
            case BuildTypeEnum.INTERNAL:
               this.activeSOS();
               this.activeLogBuffer();
               this.activeDebugMode();
               this.activeShortcut();
               this.activeGlobalExceptionCatch(true);
               this.activeWebService();
               this._localSaveReport = true;
               this._distantSaveReport = true;
               break;
            default:
               this.activeSOS();
               this.activeLogBuffer();
               this.activeDebugMode();
               this.activeShortcut();
               if(AirScanner.isStreamingVersion())
               {
                  this.activeGlobalExceptionCatch(true);
               }
               this._localSaveReport = true;
               this._distantSaveReport = true;
         }
         this.createEmptyLog4As();
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(SystemManager.getSingleton().os == OperatingSystem.MAC_OS)
         {
            if(param1.keyCode == Keyboard.F1)
            {
               this.onError(new ErrorReportedEvent(null,MANUAL_BUG_REPORT_TXT));
            }
         }
         else if(param1.keyCode == Keyboard.F11)
         {
            this.onError(new ErrorReportedEvent(null,MANUAL_BUG_REPORT_TXT));
         }
         
      }
      
      public function activeDebugMode() : void
      {
         var debugFile:File = null;
         var fs:FileStream = null;
         try
         {
            debugFile = this.getDebugFile();
            debugFile = new File(debugFile.nativePath);
            fs = new FileStream();
            fs.open(debugFile,FileMode.WRITE);
            fs.writeUTF("");
            fs.close();
         }
         catch(e:Error)
         {
            _log.error("Impossible de créer le fichier debug \nErreur:\n" + e.message);
         }
      }
      
      private function getDebugFile() : File
      {
         var _loc1_:File = null;
         switch(this.getOs())
         {
            case OperatingSystem.MAC_OS:
               _loc1_ = File.applicationDirectory.resolvePath("../Resources/META-INF/AIR/debug");
               break;
            case OperatingSystem.WINDOWS:
               _loc1_ = File.applicationDirectory.resolvePath("META-INF/AIR/debug");
               break;
            default:
               return null;
         }
         return new File(_loc1_.nativePath);
      }
      
      public function activeSOS() : void
      {
         var _loc2_:FileStream = null;
         var _loc1_:File = new File(File.applicationDirectory.resolvePath("log4as.xml").nativePath);
         if(!_loc1_.exists)
         {
            _loc2_ = new FileStream();
            _loc2_.open(_loc1_,FileMode.WRITE);
            _loc2_.writeUTFBytes(<logging>
					<targets>
						<target module="com.ankamagames.jerakine.logger.targets.SOSTarget"/>
					</targets>
				</logging>);
            _loc2_.close();
         }
         Log.addTarget(new DebugTarget());
      }
      
      public function createEmptyLog4As() : void
      {
         var sosFile:File = null;
         var fs:FileStream = null;
         sosFile = new File(File.applicationDirectory.resolvePath("log4as.xml").nativePath);
         if(!sosFile.exists)
         {
            try
            {
               fs = new FileStream();
               fs.open(sosFile,FileMode.WRITE);
               fs.writeUTFBytes(<logging>
							<targets>
							</targets>
						</logging>);
               fs.close();
            }
            catch(e:Error)
            {
               _log.error("Cannot create " + sosFile.nativePath + " : " + e.message);
            }
         }
      }
      
      public function activeLogBuffer() : void
      {
         if(!_logBuffer)
         {
            _logBuffer = new TemporaryBufferTarget();
         }
         Log.addTarget(_logBuffer);
      }
      
      public function activeShortcut(param1:Event = null) : void
      {
         if(Dofus.getInstance().stage)
         {
            Dofus.getInstance().stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
         else
         {
            Dofus.getInstance().addEventListener(Event.ADDED_TO_STAGE,this.activeShortcut);
         }
      }
      
      public function activeGlobalExceptionCatch(param1:Boolean) : void
      {
         _log.info("Catch des exceptions activés");
         ErrorManager.catchError = true;
         _log.info("Affichage des popups: " + param1);
         ErrorManager.showPopup = param1;
         ErrorManager.eventDispatcher.addEventListener(ErrorReportedEvent.ERROR,this.onError);
      }
      
      public function activeWebService() : void
      {
         this._sendErrorToWebservice = true;
         if(WebServiceDataHandler.buffer == null)
         {
            WebServiceDataHandler.buffer = new LimitedBufferTarget(50);
            Log.addTarget(WebServiceDataHandler.buffer);
         }
      }
      
      private function onError(param1:ErrorReportedEvent) : void
      {
         var error:Error = null;
         var report:ErrorReport = null;
         var stackTrace:String = null;
         var realStacktrace:String = null;
         var tmp:Array = null;
         var line:String = null;
         var exception:DataExceptionModel = null;
         var buttons:Array = null;
         var popup:SystemPopupUI = null;
         var e:ErrorReportedEvent = param1;
         var txt:String = e.text;
         error = e.error;
         if(error)
         {
            if(txt.length)
            {
               txt = txt + "\n\n";
            }
            stackTrace = "";
            realStacktrace = error.getStackTrace();
            tmp = realStacktrace.split("\n");
            for each(line in tmp)
            {
               if(line.indexOf("ErrorManager") == -1 || line.indexOf("addError") == -1)
               {
                  stackTrace = stackTrace + ((stackTrace.length?"\n":"") + line);
               }
            }
            txt = txt + stackTrace.substr(0,maxStackTracelength);
            if(stackTrace.length > maxStackTracelength)
            {
               txt = txt + " ...";
            }
         }
         var reportInfo:Object = this.getReportInfo(error,e.text);
         if(reportInfo != null)
         {
            report = new ErrorReport(reportInfo,_logBuffer);
         }
         _lastError = getTimer();
         if(this._sendErrorToWebservice)
         {
            exception = WebServiceDataHandler.getInstance().createNewException(reportInfo,e.errorType);
            if(exception != null)
            {
               WebServiceDataHandler.getInstance().saveException(exception);
            }
         }
         if(e.showPopup)
         {
            buttons = [];
            popup = new SystemPopupUI("exception" + Math.random());
            popup.width = 1000;
            popup.centerContent = false;
            popup.title = "Information";
            popup.content = txt;
            buttons.push({"label":"Skip"});
            if(error)
            {
               buttons.push({
                  "label":"Copy to clipboard",
                  "callback":function():void
                  {
                     System.setClipboard(e.text + "\n\n" + error.getStackTrace());
                  }
               });
            }
            if(this._localSaveReport)
            {
               buttons.push({
                  "label":"Save report",
                  "callback":function():void
                  {
                     report.saveReport();
                  }
               });
            }
            if(this._distantSaveReport)
            {
               buttons.push({
                  "label":"Send report",
                  "callback":function():void
                  {
                     report.sendReport();
                  }
               });
            }
            popup.buttons = buttons;
            popup.show();
         }
      }
      
      public function getReportInfo(param1:Error, param2:String) : Object
      {
         var date:Date = null;
         var o:Object = null;
         var userNameData:Array = null;
         var currentMap:WorldPointWrapper = null;
         var obstacles:Array = null;
         var entities:Array = null;
         var los:Array = null;
         var cellId:uint = 0;
         var mp:MapPoint = null;
         var entityInfoProvider:Object = null;
         var htmlBuffer:String = null;
         var logs:Array = null;
         var log:LogEvent = null;
         var screenshot:BitmapData = null;
         var m:Matrix = null;
         var fighterBuffer:String = null;
         var fighters:Vector.<int> = null;
         var fighterId:int = 0;
         var fighterInfos:FighterInformations = null;
         var entitiesOnCell:Array = null;
         var entity:IEntity = null;
         var entityInfo:GameContextActorInformations = null;
         var entityInfoData:Array = null;
         var entityInfoDataStr:String = null;
         var key:String = null;
         var rpFrame:RoleplayEntitiesFrame = null;
         var interactiveElements:Vector.<InteractiveElement> = null;
         var ie:InteractiveElement = null;
         var ieInfoData:Array = null;
         var iePos:MapPoint = null;
         var ieInfoDataStr:String = null;
         var keyIe:String = null;
         var error:Error = param1;
         var txt:String = param2;
         try
         {
            date = new Date();
            o = new Object();
            o.flashVersion = Capabilities.version;
            if(AirScanner.hasAir())
            {
               o.flashVersion = o.flashVersion + (" (AIR " + NativeApplication.nativeApplication.runtimeVersion + ")");
            }
            o.os = Capabilities.os;
            o.time = date.hours + ":" + date.minutes + ":" + date.seconds;
            o.date = date.date + "/" + (date.month + 1) + "/" + date.fullYear;
            o.buildType = BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE);
            if(AirScanner.isStreamingVersion())
            {
               o.buildType = o.buildType + " STREAMING";
            }
            else
            {
               o.appPath = File.applicationDirectory.nativePath;
            }
            o.buildVersion = BuildInfos.BUILD_VERSION;
            if(_logBuffer)
            {
               htmlBuffer = "";
               logs = _logBuffer.getBuffer();
               for each(log in logs)
               {
                  if(log is TextLogEvent && log.level > 0)
                  {
                     htmlBuffer = htmlBuffer + ("\t\t\t<li class=\"l_" + log.level + "\">" + log.formattedTimestamp + "| " + log.message + "</li>\n");
                  }
               }
               o.logSos = htmlBuffer;
            }
            o.errorMsg = txt;
            if(error)
            {
               o.stacktrace = error.getStackTrace();
            }
            userNameData = File.documentsDirectory.nativePath.split(File.separator);
            switch(SystemManager.getSingleton().os)
            {
               case OperatingSystem.WINDOWS:
                  o.user = userNameData[2];
                  break;
               case OperatingSystem.LINUX:
                  o.user = userNameData[2];
                  break;
               case OperatingSystem.MAC_OS:
                  o.user = userNameData[2];
                  break;
            }
            o.multicompte = !InterClientManager.getInstance().isAlone;
            if(getTimer() - _lastError > 500)
            {
               screenshot = new BitmapData(640,512,false);
               m = new Matrix();
               m.scale(0.5,0.5);
               screenshot.draw(StageShareManager.stage,m,null,null,null,true);
               o.screenshot = screenshot;
               o.mouseX = StageShareManager.mouseX;
               o.mouseY = StageShareManager.mouseY;
            }
            if(!PlayerManager.getInstance().server)
            {
               return o;
            }
            if(PlayerManager.getInstance().nickname)
            {
               o.account = PlayerManager.getInstance().nickname + " (id: " + PlayerManager.getInstance().accountId + ")";
            }
            o.accountId = PlayerManager.getInstance().accountId;
            o.serverId = PlayerManager.getInstance().server.id;
            o.server = PlayerManager.getInstance().server.name + " (id: " + PlayerManager.getInstance().server.id + ")";
            if(!PlayedCharacterManager.getInstance().infos)
            {
               return o;
            }
            o.character = PlayedCharacterManager.getInstance().infos.name + " (id: " + PlayedCharacterManager.getInstance().id + ")";
            o.characterId = PlayedCharacterManager.getInstance().id;
            currentMap = PlayedCharacterManager.getInstance().currentMap;
            if(!currentMap)
            {
               return o;
            }
            o.mapId = currentMap.mapId + " (" + currentMap.x + "/" + currentMap.y + ")";
            o.look = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook).toString();
            o.idMap = currentMap.mapId;
            obstacles = [];
            entities = [];
            los = [];
            o.wasFighting = !(this.getFightFrame() == null);
            if(o.wasFighting)
            {
               fighterBuffer = "";
               fighters = this.getFightFrame().battleFrame.fightersList;
               for each(fighterId in fighters)
               {
                  fighterInfos = new FighterInformations(fighterId);
                  fighterBuffer = fighterBuffer + ("<li><b>" + this.getFightFrame().getFighterName(fighterId) + "</b>, id: " + fighterId + ", lvl: " + this.getFightFrame().getFighterLevel(fighterId) + ", team: " + fighterInfos.team + ", vie: " + fighterInfos.lifePoints + ", pa:" + fighterInfos.actionPoints + ", pm:" + fighterInfos.movementPoints + ", cell:" + FightEntitiesFrame.getCurrentInstance().getEntityInfos(fighterId).disposition.cellId + "</li>");
               }
               o.fighterList = fighterBuffer;
               o.currentPlayer = this.getFightFrame().getFighterName(this.getFightFrame().battleFrame.currentPlayerId);
            }
            if(!o.wasFighting)
            {
               entityInfoProvider = Kernel.getWorker().getFrame(RoleplayEntitiesFrame);
            }
            else
            {
               entityInfoProvider = this.getFightFrame();
            }
            cellId = 0;
            while(cellId < AtouinConstants.MAP_CELLS_COUNT)
            {
               mp = MapPoint.fromCellId(cellId);
               obstacles.push(DataMapProvider.getInstance().pointMov(mp.x,mp.y,true)?1:0);
               los.push(DataMapProvider.getInstance().pointLos(mp.x,mp.y,true)?1:0);
               entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(mp.cellId);
               if((entityInfoProvider) && (entitiesOnCell.length))
               {
                  for each(entity in entitiesOnCell)
                  {
                     entityInfo = entityInfoProvider.getEntityInfos(entity.id);
                     entityInfoData = DescribeTypeCache.getVariables(entityInfo,true);
                     entityInfoDataStr = "{cell:" + cellId + ",className:\'" + getQualifiedClassName(entityInfo).split("::").pop() + "\'";
                     for each(key in entityInfoData)
                     {
                        if(entityInfo[key] is int || entityInfo[key] is uint || entityInfo[key] is Number || entityInfo[key] is Boolean || entityInfo[key] is String)
                        {
                           entityInfoDataStr = entityInfoDataStr + ("," + key + ":\"" + entityInfo[key] + "\"");
                        }
                     }
                     entities.push(entityInfoDataStr + "}");
                  }
               }
               cellId++;
            }
            if(!o.wasFighting)
            {
               rpFrame = entityInfoProvider as RoleplayEntitiesFrame;
               if(rpFrame)
               {
                  interactiveElements = rpFrame.interactiveElements;
                  for each(ie in interactiveElements)
                  {
                     ieInfoData = DescribeTypeCache.getVariables(ie,true);
                     iePos = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
                     ieInfoDataStr = "{cell:" + iePos.cellId + ",className:\'" + getQualifiedClassName(ie).split("::").pop() + "\'";
                     for each(keyIe in ieInfoData)
                     {
                        if(ie[keyIe] is int || ie[keyIe] is uint || ie[keyIe] is Number || ie[keyIe] is Boolean || ie[keyIe] is String)
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
         catch(e:Error)
         {
            if(txt != MANUAL_BUG_REPORT_TXT)
            {
               _log.error("Error during the creation of a bug report... " + e.message + "\nInitial error :" + (error?error.message:txt));
            }
            else
            {
               _log.info("Manual bug report has been created");
            }
         }
         return o;
      }
      
      private function getFightFrame() : FightContextFrame
      {
         var _loc1_:Frame = Kernel.getWorker().getFrame(FightContextFrame);
         return _loc1_ as FightContextFrame;
      }
      
      public function get localSaveReport() : Boolean
      {
         return this._localSaveReport;
      }
      
      public function get distantSaveReport() : Boolean
      {
         return this._distantSaveReport;
      }
      
      public function get sendErrorToWebservice() : Boolean
      {
         return this._sendErrorToWebservice;
      }
      
      private function getOs() : String
      {
         var _loc1_:String = Capabilities.os;
         if(_loc1_ == OperatingSystem.LINUX)
         {
            return OperatingSystem.LINUX;
         }
         if(_loc1_.substr(0,OperatingSystem.MAC_OS.length) == OperatingSystem.MAC_OS)
         {
            return OperatingSystem.MAC_OS;
         }
         if(_loc1_.substr(0,OperatingSystem.WINDOWS.length) == OperatingSystem.WINDOWS)
         {
            return OperatingSystem.WINDOWS;
         }
         return null;
      }
   }
}
