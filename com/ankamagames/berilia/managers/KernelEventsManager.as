package com.ankamagames.berilia.managers
{
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.types.event.UiRenderEvent;
    import com.ankamagames.berilia.types.listener.GenericListener;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
    import com.ankamagames.berilia.types.data.OldMessage;
    import com.ankamagames.berilia.types.event.HookLogEvent;
    import com.ankamagames.jerakine.logger.ModuleLogger;
    import com.ankamagames.jerakine.managers.ErrorManager;
    import com.ankamagames.berilia.types.event.HookEvent;
    import com.ankamagames.berilia.types.data.Hook;

    public class KernelEventsManager extends GenericEventsManager 
    {

        private static var _self:KernelEventsManager;

        private var _aLoadingUi:Array;
        private var _eventDispatcher:EventDispatcher;

        public function KernelEventsManager()
        {
            if (_self != null)
            {
                throw (new SingletonError("KernelEventsManager is a singleton and should not be instanciated directly."));
            };
            this._eventDispatcher = new EventDispatcher();
            this._aLoadingUi = new Array();
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete, this.processOldMessage);
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderFailed, this.processOldMessage);
        }

        public static function getInstance():KernelEventsManager
        {
            if (_self == null)
            {
                _self = new (KernelEventsManager)();
            };
            return (_self);
        }


        public function get eventDispatcher():EventDispatcher
        {
            return (this._eventDispatcher);
        }

        public function isRegisteredEvent(name:String):Boolean
        {
            return (!((_aEvent[name] == null)));
        }

        [APALogInfo(customInfo="'Hook: ' + hook.name")]
        public function processCallback(hook:Hook, ... args):void
        {
            var s:String;
            var e:GenericListener;
            FpsManager.getInstance().startTracking("hook", 7108545);
            if (!(UiModuleManager.getInstance().ready))
            {
                _log.warn((("Hook " + hook.name) + " discarded"));
                return;
            };
            var boxedParam:Array = SecureCenter.secureContent(args);
            var num:int;
            var loadingUi:Array = Berilia.getInstance().loadingUi;
            for (s in loadingUi)
            {
                num++;
                if (!!(Berilia.getInstance().loadingUi[s]))
                {
                    if (this._aLoadingUi[s] == null)
                    {
                        this._aLoadingUi[s] = new Array();
                    };
                    this._aLoadingUi[s].push(new OldMessage(hook, boxedParam));
                };
            };
            _log.logDirectly(new HookLogEvent(hook.name, []));
            if (!(_aEvent[hook.name]))
            {
                return;
            };
            ModuleLogger.log(hook, args);
            var tmpListner:Array = [];
            for each (e in _aEvent[hook.name])
            {
                tmpListner.push(e);
            };
            for each (e in tmpListner)
            {
                if (!!(e))
                {
                    if ((((e.listenerType == GenericListener.LISTENER_TYPE_UI)) && (!(Berilia.getInstance().getUi(e.listener)))))
                    {
                        _log.info(((("L'UI " + e.listener) + " n'existe plus pour recevoir le hook ") + e.event));
                    }
                    else
                    {
                        ErrorManager.tryFunction(e.callback, boxedParam, ("Une erreur est survenue lors du traitement du hook " + hook.name));
                    };
                };
            };
            if (this._eventDispatcher.hasEventListener(HookEvent.DISPATCHED))
            {
                this._eventDispatcher.dispatchEvent(new HookEvent(HookEvent.DISPATCHED, hook));
            };
            FpsManager.getInstance().stopTracking("hook");
        }

        private function processOldMessage(e:UiRenderEvent):void
        {
            var hook:Hook;
            var args:Array;
            var s:String;
            var eGl:GenericListener;
            if (!(this._aLoadingUi[e.uiTarget.name]))
            {
                return;
            };
            if (e.type == UiRenderEvent.UIRenderFailed)
            {
                this._aLoadingUi[e.uiTarget.name] = null;
                return;
            };
            var i:uint;
            while (i < this._aLoadingUi[e.uiTarget.name].length)
            {
                hook = this._aLoadingUi[e.uiTarget.name][i].hook;
                args = this._aLoadingUi[e.uiTarget.name][i].args;
                for (s in _aEvent[hook.name])
                {
                    if (_aEvent[hook.name][s])
                    {
                        eGl = _aEvent[hook.name][s];
                        if (eGl.listener == e.uiTarget.name)
                        {
                            eGl.callback.apply(null, args);
                        };
                        if (_aEvent[hook.name] == null) break;
                    };
                };
                i++;
            };
            delete this._aLoadingUi[e.uiTarget.name];
        }


    }
}//package com.ankamagames.berilia.managers

