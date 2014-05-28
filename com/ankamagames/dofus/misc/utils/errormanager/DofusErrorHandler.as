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
      
      public function DofusErrorHandler(pAutoInit:Boolean = true) {
         super();
         if(pAutoInit)
         {
            this.activeManually();
            this.initData();
         }
         _self = this;
      }
      
      public static var maxStackTracelength:uint = 1000;
      
      protected static const _log:Logger;
      
      private static var _logBuffer:TemporaryBufferTarget;
      
      private static var _lastError:uint;
      
      private static var _manualActivation:CustomSharedObject;
      
      private static var _self:DofusErrorHandler;
      
      public static function get manualActivation() : Boolean {
         return (_manualActivation.data) && (_manualActivation.data.force);
      }
      
      public static function set manualActivation(v:Boolean) : void {
         if(!_manualActivation.data)
         {
            _manualActivation.data = {};
         }
         _manualActivation.data.force = v;
         _manualActivation.flush();
      }
      
      public static function get debugFileExists() : Boolean {
         return (File.applicationDirectory.resolvePath("debug").exists) || (File.applicationDirectory.resolvePath("debug.txt").exists);
      }
      
      public static function activateDebugMode() : void {
         _self.activeManually();
      }
      
      private var _localSaveReport:Boolean = false;
      
      private var _distantSaveReport:Boolean = false;
      
      private var _sendErrorToWebservice:Boolean = false;
      
      public function activeManually() : void {
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
      
      private function removeDebugFile() : void {
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
      
      private function initData() : void {
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
      
      private function onKeyUp(e:KeyboardEvent) : void {
         if(SystemManager.getSingleton().os == OperatingSystem.MAC_OS)
         {
            if(e.keyCode == Keyboard.F1)
            {
               this.onError(new ErrorReportedEvent(null,"Manual bug report"));
            }
         }
         else if(e.keyCode == Keyboard.F11)
         {
            this.onError(new ErrorReportedEvent(null,"Manual bug report"));
         }
         
      }
      
      public function activeDebugMode() : void {
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
      
      private function getDebugFile() : File {
         var debugFile:File = null;
         switch(this.getOs())
         {
            case OperatingSystem.MAC_OS:
               debugFile = File.applicationDirectory.resolvePath("../Resources/META-INF/AIR/debug");
               break;
            case OperatingSystem.WINDOWS:
               debugFile = File.applicationDirectory.resolvePath("META-INF/AIR/debug");
               break;
            default:
               return null;
         }
         return new File(debugFile.nativePath);
      }
      
      public function activeSOS() : void {
         var fs:FileStream = null;
         var sosFile:File = new File(File.applicationDirectory.resolvePath("log4as.xml").nativePath);
         if(!sosFile.exists)
         {
            fs = new FileStream();
            fs.open(sosFile,FileMode.WRITE);
            fs.writeUTFBytes(<logging>
					<targets>
						<target module="com.ankamagames.jerakine.logger.targets.SOSTarget"/>
					</targets>
				</logging>);
            fs.close();
         }
         Log.addTarget(new DebugTarget());
      }
      
      public function createEmptyLog4As() : void {
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
      
      public function activeLogBuffer() : void {
         if(!_logBuffer)
         {
            _logBuffer = new TemporaryBufferTarget();
         }
         Log.addTarget(_logBuffer);
      }
      
      public function activeShortcut(e:Event = null) : void {
         if(Dofus.getInstance().stage)
         {
            Dofus.getInstance().stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
         else
         {
            Dofus.getInstance().addEventListener(Event.ADDED_TO_STAGE,this.activeShortcut);
         }
      }
      
      public function activeGlobalExceptionCatch(pShowPopup:Boolean) : void {
         _log.info("Catch des exceptions activés");
         ErrorManager.catchError = true;
         _log.info("Affichage des popups: " + pShowPopup);
         ErrorManager.showPopup = pShowPopup;
         ErrorManager.eventDispatcher.addEventListener(ErrorReportedEvent.ERROR,this.onError);
      }
      
      public function activeWebService() : void {
         this._sendErrorToWebservice = true;
         if(WebServiceDataHandler.buffer == null)
         {
            WebServiceDataHandler.buffer = new LimitedBufferTarget(50);
            Log.addTarget(WebServiceDataHandler.buffer);
         }
      }
      
      private function onError(e:ErrorReportedEvent) : void {
         var error:Error = null;
         var report:ErrorReport = null;
         var stackTrace:String = null;
         var realStacktrace:String = null;
         var tmp:Array = null;
         var line:String = null;
         var exception:DataExceptionModel = null;
         var buttons:Array = null;
         var popup:SystemPopupUI = null;
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
               if((line.indexOf("ErrorManager") == -1) || (line.indexOf("addError") == -1))
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
               buttons.push(
                  {
                     "label":"Copy to clipboard",
                     "callback":function():void
                     {
                        System.setClipboard(e.text + "\n\n" + error.getStackTrace());
                     }
                  });
            }
            if(this._localSaveReport)
            {
               buttons.push(
                  {
                     "label":"Save report",
                     "callback":function():void
                     {
                        report.saveReport();
                     }
                  });
            }
            if(this._distantSaveReport)
            {
               buttons.push(
                  {
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
      
      public function getReportInfo(error:Error, txt:String) : Object {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function getFightFrame() : FightContextFrame {
         var frame:Frame = Kernel.getWorker().getFrame(FightContextFrame);
         return frame as FightContextFrame;
      }
      
      public function get localSaveReport() : Boolean {
         return this._localSaveReport;
      }
      
      public function get distantSaveReport() : Boolean {
         return this._distantSaveReport;
      }
      
      public function get sendErrorToWebservice() : Boolean {
         return this._sendErrorToWebservice;
      }
      
      private function getOs() : String {
         var cos:String = Capabilities.os;
         if(cos == OperatingSystem.LINUX)
         {
            return OperatingSystem.LINUX;
         }
         if(cos.substr(0,OperatingSystem.MAC_OS.length) == OperatingSystem.MAC_OS)
         {
            return OperatingSystem.MAC_OS;
         }
         if(cos.substr(0,OperatingSystem.WINDOWS.length) == OperatingSystem.WINDOWS)
         {
            return OperatingSystem.WINDOWS;
         }
         return null;
      }
   }
}
