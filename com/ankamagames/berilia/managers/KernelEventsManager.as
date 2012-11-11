package com.ankamagames.berilia.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.listener.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.utils.*;

    public class KernelEventsManager extends GenericEventsManager
    {
        private var _aLoadingUi:Array;
        private var _asyncErrorTimer:Timer;
        private var _asyncError:Vector.<Error>;
        private var _debugMode:Boolean = false;
        private static var _self:KernelEventsManager;

        public function KernelEventsManager()
        {
            if (_self != null)
            {
                throw new SingletonError("KernelEventsManager is a singleton and should not be instanciated directly.");
            }
            this._aLoadingUi = new Array();
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete, this.processOldMessage);
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderFailed, this.processOldMessage);
            this._asyncError = new Vector.<Error>;
            this._asyncErrorTimer = new Timer(1, 1);
            this._asyncErrorTimer.addEventListener(TimerEvent.TIMER, this.throwAsyncError);
            return;
        }// end function

        public function disableAsyncError() : void
        {
            this._debugMode = true;
            return;
        }// end function

        public function isRegisteredEvent(param1:String) : Boolean
        {
            return _aEvent[param1] != null;
        }// end function

        public function processCallback(param1:Hook, ... args) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            FpsManager.getInstance().startTracking("hook", 7108545);
            if (!UiModuleManager.getInstance().ready)
            {
                _log.warn("Hook " + param1.name + " discarded");
                return;
            }
            args = SecureCenter.secureContent(args);
            var _loc_4:* = 0;
            var _loc_5:* = Berilia.getInstance().loadingUi;
            for (_loc_6 in _loc_5)
            {
                
                _loc_4++;
                if (!Berilia.getInstance().loadingUi[_loc_6])
                {
                    continue;
                }
                if (this._aLoadingUi[_loc_6] == null)
                {
                    this._aLoadingUi[_loc_6] = new Array();
                }
                this._aLoadingUi[_loc_6].push(new OldMessage(param1, args));
            }
            _log.logDirectly(new HookLogEvent(param1.name, []));
            if (!_aEvent[param1.name])
            {
                return;
            }
            ModuleLogger.log(param1, args);
            var _loc_8:* = [];
            for each (_loc_7 in _aEvent[param1.name])
            {
                
                _loc_8.push(_loc_7);
            }
            for each (_loc_7 in _loc_8)
            {
                
                if (!_loc_7)
                {
                    continue;
                }
                ErrorManager.tryFunction(_loc_7.getCallback(), args, "Une erreur est survenue lors du traitement du hook " + param1.name);
            }
            FpsManager.getInstance().stopTracking("hook");
            return;
        }// end function

        private function processOldMessage(event:UiRenderEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this._aLoadingUi[event.uiTarget.name])
            {
                return;
            }
            if (event.type == UiRenderEvent.UIRenderFailed)
            {
                this._aLoadingUi[event.uiTarget.name] = null;
                return;
            }
            var _loc_4:* = 0;
            while (_loc_4 < this._aLoadingUi[event.uiTarget.name].length)
            {
                
                _loc_2 = this._aLoadingUi[event.uiTarget.name][_loc_4].hook;
                _loc_3 = this._aLoadingUi[event.uiTarget.name][_loc_4].args;
                for (_loc_5 in _aEvent[_loc_2.name])
                {
                    
                    if (_aEvent[_loc_2.name][_loc_5])
                    {
                        _loc_6 = _aEvent[_loc_2.name][_loc_5];
                        _log.trace("Renvoi de " + _loc_2.name + " vers " + _loc_6.listener);
                        if (_loc_6.listener == event.uiTarget.name)
                        {
                            _loc_6.getCallback().apply(null, _loc_3);
                        }
                        if (_aEvent[_loc_2.name] == null)
                        {
                            break;
                        }
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            delete this._aLoadingUi[event.uiTarget.name];
            return;
        }// end function

        private function throwAsyncError(event:TimerEvent) : void
        {
            this._asyncErrorTimer.reset();
            while (this._asyncError.length)
            {
                
                throw this._asyncError.shift();
            }
            return;
        }// end function

        public static function getInstance() : KernelEventsManager
        {
            if (_self == null)
            {
                _self = new KernelEventsManager;
            }
            return _self;
        }// end function

    }
}
