package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.messages.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.connection.frames.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.logic.connection.messages.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.messages.connection.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.events.*;
    import flash.utils.*;

    public class LoadingModuleFrame extends Object implements Frame
    {
        private var _manageAuthentificationFrame:Boolean;
        private var _loadingScreen:LoadingScreen;
        private var _lastXmlParsedPrc:Number = 0;
        private var _tips:Array;
        private var _tipsTimer:Timer;
        private var _showContinueButton:Boolean = false;
        private var _startTime:uint;
        private var _waitDone:Boolean;
        private var _progressRation:Number;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(LoadingModuleFrame));

        public function LoadingModuleFrame(param1:Boolean = false)
        {
            this._tips = [];
            this._tipsTimer = new Timer(20 * 1000);
            this._manageAuthentificationFrame = param1;
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGH;
        }// end function

        public function pushed() : Boolean
        {
            var _loc_1:* = null;
            this._waitDone = false;
            this._startTime = getTimer();
            this._loadingScreen = new LoadingScreen(true);
            Dofus.getInstance().addChild(this._loadingScreen);
            for each (_loc_1 in Tips.getAllTips())
            {
                
                this._tips.push(_loc_1);
            }
            this._tipsTimer.addEventListener(TimerEvent.TIMER, this.changeTip);
            this._tipsTimer.start();
            this.changeTip(null);
            if (UiModuleManager.getInstance().unparsedXmlTotalCount == 0)
            {
                this._progressRation = 1 / 2;
            }
            else
            {
                this._progressRation = 1 / 3;
            }
            return true;
        }// end function

        private function changeTip(event:Event) : void
        {
            var _loc_2:* = this._tips[Math.floor(this._tips.length * Math.random())] as Tips;
            if (_loc_2)
            {
                this._loadingScreen.tip = _loc_2.description;
            }
            return;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            switch(true)
            {
                case param1 is ModuleLoadedMessage:
                {
                    this._loadingScreen.value = this._loadingScreen.value + 100 / UiModuleManager.getInstance().moduleCount * this._progressRation;
                    _loc_2 = UiModuleManager.getInstance().getModule(ModuleLoadedMessage(param1).moduleName).trusted;
                    this._loadingScreen.log(ModuleLoadedMessage(param1).moduleName + " script loaded " + (_loc_2 ? ("") : ("UNTRUSTED module")), _loc_2 ? (LoadingScreen.IMPORTANT) : (LoadingScreen.WARNING));
                    return true;
                }
                case param1 is ModuleExecErrorMessage:
                {
                    this._loadingScreen.value = this._loadingScreen.value + 100 / UiModuleManager.getInstance().moduleCount * this._progressRation;
                    this._loadingScreen.log("Error while executing " + ModuleExecErrorMessage(param1).moduleName + "\'s main script :\n" + ModuleExecErrorMessage(param1).stackTrace, LoadingScreen.ERROR);
                    this._showContinueButton = true;
                    return true;
                }
                case param1 is ModuleRessourceLoadFailedMessage:
                {
                    _loc_3 = param1 as ModuleRessourceLoadFailedMessage;
                    this._loadingScreen.log("Module " + _loc_3.moduleName + " : Cannot load " + _loc_3.uri, _loc_3.isImportant ? (LoadingScreen.ERROR) : (LoadingScreen.WARNING));
                    if (_loc_3.isImportant)
                    {
                        this._showContinueButton = true;
                    }
                    return true;
                }
                case param1 is AllModulesLoadedMessage:
                {
                    _loc_4 = "";
                    _loc_5 = UiModuleManager.getInstance().getModules();
                    for each (_loc_7 in _loc_5)
                    {
                        
                        if (!_loc_7.trusted)
                        {
                            _loc_4 = _loc_4 + (_loc_7.toString() + "\n");
                        }
                    }
                    if (_loc_4.length)
                    {
                        _loc_4 = "PID:" + PlayerManager.getInstance().accountId + "\n" + _loc_4;
                        StatisticReportingManager.getInstance().report("customMod", _loc_4);
                    }
                    if (this._manageAuthentificationFrame)
                    {
                        if (!this._showContinueButton)
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
                    if (this._showContinueButton)
                    {
                        this._showContinueButton = false;
                        this._loadingScreen.continueCallbak = this.dispatchEnd;
                        return true;
                    }
                    break;
                }
                case param1 is UiXmlParsedMessage:
                {
                    _loc_6 = 1 - UiModuleManager.getInstance().unparsedXmlCount / UiModuleManager.getInstance().unparsedXmlTotalCount;
                    if (_loc_6 < this._lastXmlParsedPrc)
                    {
                        break;
                    }
                    this._loadingScreen.log("Preparsing " + UiXmlParsedMessage(param1).url, LoadingScreen.INFO);
                    this._loadingScreen.value = this._loadingScreen.value + (_loc_6 - this._lastXmlParsedPrc) * 100 * this._progressRation;
                    this._lastXmlParsedPrc = _loc_6;
                    return true;
                }
                case param1 is UiXmlParsedErrorMessage:
                {
                    this._loadingScreen.log("Error while parsing  " + UiXmlParsedErrorMessage(param1).url + " : " + UiXmlParsedErrorMessage(param1).msg, LoadingScreen.ERROR);
                    return true;
                }
                case param1 is MapRenderProgressMessage:
                {
                    this._loadingScreen.value = this._loadingScreen.value + MapRenderProgressMessage(param1).percent * this._progressRation;
                    return true;
                }
                case param1 is GameStartingMessage:
                case param1 is ServersListMessage:
                case param1 is MapComplementaryInformationsDataMessage:
                {
                    Kernel.getWorker().removeFrame(this);
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
            if (this._tipsTimer)
            {
                this._tipsTimer.removeEventListener(TimerEvent.TIMER, this.changeTip);
            }
            this._tipsTimer = null;
            if (this._loadingScreen)
            {
                this._loadingScreen.parent.removeChild(this._loadingScreen);
            }
            this._loadingScreen = null;
            return true;
        }// end function

        private function dispatchEnd() : void
        {
            Kernel.getWorker().process(new AllModulesLoadedMessage());
            return;
        }// end function

        private function launchGame() : void
        {
            if (getTimer() - this._startTime < 2000 && !this._waitDone)
            {
                setTimeout(this.launchGame, 2000 - (getTimer() - this._startTime));
                this._waitDone = true;
                return;
            }
            this._manageAuthentificationFrame = false;
            Kernel.getWorker().addFrame(new AuthentificationFrame(AuthentificationManager.getInstance().loginValidationAction == null));
            Kernel.getWorker().addFrame(new QueueFrame());
            Kernel.getWorker().addFrame(new GameStartingFrame());
            var _loc_1:* = DisconnectionHandlerFrame.messagesAfterReset.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                Kernel.getWorker().process(DisconnectionHandlerFrame.messagesAfterReset.shift());
                _loc_2++;
            }
            if (AuthentificationManager.getInstance().loginValidationAction)
            {
                Kernel.getWorker().process(AuthentificationManager.getInstance().loginValidationAction);
            }
            return;
        }// end function

    }
}
