package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.utils.LoadingScreen;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.datacenter.misc.Tips;
   import flash.utils.getTimer;
   import flash.events.TimerEvent;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import flash.events.Event;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.berilia.types.messages.ModuleRessourceLoadFailedMessage;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.messages.ModuleLoadedMessage;
   import com.ankamagames.berilia.types.messages.ModuleExecErrorMessage;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.misc.utils.StatisticReportingManager;
   import com.ankamagames.berilia.types.messages.UiXmlParsedMessage;
   import com.ankamagames.berilia.types.messages.UiXmlParsedErrorMessage;
   import com.ankamagames.atouin.messages.MapRenderProgressMessage;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.types.messages.AllModulesLoadedMessage;
   import com.ankamagames.dofus.logic.connection.messages.GameStartingMessage;
   import com.ankamagames.dofus.network.messages.connection.ServersListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import flash.utils.setTimeout;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.connection.frames.GameStartingFrame;
   
   public class LoadingModuleFrame extends Object implements Frame
   {
      
      public function LoadingModuleFrame(param1:Boolean=false) {
         this._tips = [];
         this._tipsTimer = new Timer(20 * 1000);
         super();
         this._manageAuthentificationFrame = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LoadingModuleFrame));
      
      private var _manageAuthentificationFrame:Boolean;
      
      private var _loadingScreen:LoadingScreen;
      
      private var _lastXmlParsedPrc:Number = 0;
      
      private var _tips:Array;
      
      private var _tipsTimer:Timer;
      
      private var _showContinueButton:Boolean = false;
      
      private var _startTime:uint;
      
      private var _waitDone:Boolean;
      
      private var _progressRation:Number;
      
      public function get priority() : int {
         return Priority.HIGH;
      }
      
      public function pushed() : Boolean {
         var _loc1_:Tips = null;
         this._waitDone = false;
         this._startTime = getTimer();
         this._loadingScreen = new LoadingScreen(true);
         Dofus.getInstance().addChild(this._loadingScreen);
         for each (_loc1_ in Tips.getAllTips())
         {
            this._tips.push(_loc1_);
         }
         this._tipsTimer.addEventListener(TimerEvent.TIMER,this.changeTip);
         this._tipsTimer.start();
         this.changeTip(null);
         if(UiModuleManager.getInstance().unparsedXmlTotalCount == 0)
         {
            this._progressRation = 1 / 2;
         }
         else
         {
            this._progressRation = 1 / 3;
         }
         return true;
      }
      
      private function changeTip(param1:Event) : void {
         var _loc2_:Tips = this._tips[Math.floor(this._tips.length * Math.random())] as Tips;
         if(_loc2_)
         {
            this._loadingScreen.tip = _loc2_.description;
         }
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:* = false;
         var _loc3_:ModuleRessourceLoadFailedMessage = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:* = NaN;
         var _loc7_:UiModule = null;
         switch(true)
         {
            case param1 is ModuleLoadedMessage:
               this._loadingScreen.value = this._loadingScreen.value + 100 / UiModuleManager.getInstance().moduleCount * this._progressRation;
               _loc2_ = UiModuleManager.getInstance().getModule(ModuleLoadedMessage(param1).moduleName).trusted;
               this._loadingScreen.log(ModuleLoadedMessage(param1).moduleName + " script loaded " + (_loc2_?"":"UNTRUSTED module"),_loc2_?LoadingScreen.IMPORTANT:LoadingScreen.WARNING);
               return true;
            case param1 is ModuleExecErrorMessage:
               this._loadingScreen.value = this._loadingScreen.value + 100 / UiModuleManager.getInstance().moduleCount * this._progressRation;
               this._loadingScreen.log("Error while executing " + ModuleExecErrorMessage(param1).moduleName + "\'s main script :\n" + ModuleExecErrorMessage(param1).stackTrace,LoadingScreen.ERROR);
               this._showContinueButton = true;
               return true;
            case param1 is ModuleRessourceLoadFailedMessage:
               _loc3_ = param1 as ModuleRessourceLoadFailedMessage;
               this._loadingScreen.log("Module " + _loc3_.moduleName + " : Cannot load " + _loc3_.uri,_loc3_.isImportant?LoadingScreen.ERROR:LoadingScreen.WARNING);
               if(_loc3_.isImportant)
               {
                  this._showContinueButton = true;
               }
               return true;
            case param1 is AllModulesLoadedMessage:
               _loc4_ = "";
               _loc5_ = UiModuleManager.getInstance().getModules();
               for each (_loc7_ in _loc5_)
               {
                  if(!_loc7_.trusted)
                  {
                     _loc4_ = _loc4_ + (_loc7_.toString() + "\n");
                  }
               }
               if(_loc4_.length)
               {
                  _loc4_ = "PID:" + PlayerManager.getInstance().accountId + "\n" + _loc4_;
                  StatisticReportingManager.getInstance().report("customMod",_loc4_);
               }
               if(this._manageAuthentificationFrame)
               {
                  if(!this._showContinueButton)
                  {
                     this.launchGame();
                  }
                  else
                  {
                     this._showContinueButton = false;
                     this._loadingScreen.continueCallbak = this.launchGame;
                  }
                  return true;
               }
               if(this._showContinueButton)
               {
                  this._showContinueButton = false;
                  this._loadingScreen.continueCallbak = this.dispatchEnd;
                  return true;
               }
               break;
            case param1 is UiXmlParsedMessage:
               _loc6_ = 1 - UiModuleManager.getInstance().unparsedXmlCount / UiModuleManager.getInstance().unparsedXmlTotalCount;
               if(_loc6_ < this._lastXmlParsedPrc)
               {
                  break;
               }
               this._loadingScreen.log("Preparsing " + UiXmlParsedMessage(param1).url,LoadingScreen.INFO);
               this._loadingScreen.value = this._loadingScreen.value + (_loc6_ - this._lastXmlParsedPrc) * 100 * this._progressRation;
               this._lastXmlParsedPrc = _loc6_;
               return true;
            case param1 is UiXmlParsedErrorMessage:
               this._loadingScreen.log("Error while parsing  " + UiXmlParsedErrorMessage(param1).url + " : " + UiXmlParsedErrorMessage(param1).msg,LoadingScreen.ERROR);
               return true;
            case param1 is MapRenderProgressMessage:
               this._loadingScreen.value = this._loadingScreen.value + MapRenderProgressMessage(param1).percent * this._progressRation;
               return true;
            case param1 is GameStartingMessage:
               Kernel.getWorker().removeFrame(this);
               return true;
            case param1 is ServersListMessage:
            case param1 is MapComplementaryInformationsDataMessage:
               Kernel.getWorker().removeFrame(this);
               return false;
         }
         return false;
      }
      
      public function pulled() : Boolean {
         if(this._tipsTimer)
         {
            this._tipsTimer.removeEventListener(TimerEvent.TIMER,this.changeTip);
         }
         this._tipsTimer = null;
         if(this._loadingScreen)
         {
            this._loadingScreen.parent.removeChild(this._loadingScreen);
         }
         this._loadingScreen = null;
         return true;
      }
      
      private function dispatchEnd() : void {
         Kernel.getWorker().process(new AllModulesLoadedMessage());
      }
      
      private function launchGame() : void {
         if(getTimer() - this._startTime < 2000 && !this._waitDone)
         {
            setTimeout(this.launchGame,2000 - (getTimer() - this._startTime));
            this._waitDone = true;
            return;
         }
         this._manageAuthentificationFrame = false;
         Kernel.getWorker().addFrame(new AuthentificationFrame(AuthentificationManager.getInstance().loginValidationAction == null));
         Kernel.getWorker().addFrame(new QueueFrame());
         Kernel.getWorker().addFrame(new GameStartingFrame());
         var _loc1_:int = DisconnectionHandlerFrame.messagesAfterReset.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            Kernel.getWorker().process(DisconnectionHandlerFrame.messagesAfterReset.shift());
            _loc2_++;
         }
         if(AuthentificationManager.getInstance().loginValidationAction)
         {
            Kernel.getWorker().process(AuthentificationManager.getInstance().loginValidationAction);
         }
      }
   }
}
