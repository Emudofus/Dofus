package com.ankamagames.berilia.managers
{
   import flash.utils.Timer;
   import __AS3__.vec.Vector;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.data.OldMessage;
   import com.ankamagames.berilia.types.event.HookLogEvent;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;


   public class KernelEventsManager extends GenericEventsManager
   {
         

      public function KernelEventsManager() {
         super();
         if(_self!=null)
         {
            throw new SingletonError("KernelEventsManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._aLoadingUi=new Array();
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete,this.processOldMessage);
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderFailed,this.processOldMessage);
            this._asyncError=new Vector.<Error>();
            this._asyncErrorTimer=new Timer(1,1);
            this._asyncErrorTimer.addEventListener(TimerEvent.TIMER,this.throwAsyncError);
            return;
         }
      }

      private static var _self:KernelEventsManager;

      public static function getInstance() : KernelEventsManager {
         if(_self==null)
         {
            _self=new KernelEventsManager();
         }
         return _self;
      }

      private var _aLoadingUi:Array;

      private var _asyncErrorTimer:Timer;

      private var _asyncError:Vector.<Error>;

      private var _debugMode:Boolean = false;

      public function disableAsyncError() : void {
         this._debugMode=true;
      }

      public function isRegisteredEvent(name:String) : Boolean {
         return !(_aEvent[name]==null);
      }

      public function processCallback(hook:Hook, ... args) : void {
         var s:String = null;
         var e:GenericListener = null;
         FpsManager.getInstance().startTracking("hook",7108545);
         if(!UiModuleManager.getInstance().ready)
         {
            _log.warn("Hook "+hook.name+" discarded");
            return;
         }
         var boxedParam:Array = SecureCenter.secureContent(args);
         var num:int = 0;
         var loadingUi:Array = Berilia.getInstance().loadingUi;
         for (s in loadingUi)
         {
            num++;
            if(!Berilia.getInstance().loadingUi[s])
            {
            }
            else
            {
               if(this._aLoadingUi[s]==null)
               {
                  this._aLoadingUi[s]=new Array();
               }
               this._aLoadingUi[s].push(new OldMessage(hook,boxedParam));
            }
         }
         _log.logDirectly(new HookLogEvent(hook.name,[]));
         if(!_aEvent[hook.name])
         {
            return;
         }
         ModuleLogger.log(hook,args);
         var tmpListner:Array = [];
         for each (e in _aEvent[hook.name])
         {
            tmpListner.push(e);
         }
         for each (e in tmpListner)
         {
            if(!e)
            {
            }
            else
            {
               ErrorManager.tryFunction(e.getCallback(),boxedParam,"Une erreur est survenue lors du traitement du hook "+hook.name);
            }
         }
         FpsManager.getInstance().stopTracking("hook");
      }

      private function processOldMessage(e:UiRenderEvent) : void {
         var hook:Hook = null;
         var args:Array = null;
         var s:String = null;
         var eGl:GenericListener = null;
         if(!this._aLoadingUi[e.uiTarget.name])
         {
            return;
         }
         if(e.type==UiRenderEvent.UIRenderFailed)
         {
            this._aLoadingUi[e.uiTarget.name]=null;
            return;
         }
         var i:uint = 0;
         while(i<this._aLoadingUi[e.uiTarget.name].length)
         {
            hook=this._aLoadingUi[e.uiTarget.name][i].hook;
            args=this._aLoadingUi[e.uiTarget.name][i].args;
            for (s in _aEvent[hook.name])
            {
               if(_aEvent[hook.name][s])
               {
                  eGl=_aEvent[hook.name][s];
                  _log.trace("Renvoi de "+hook.name+" vers "+eGl.listener);
                  if(eGl.listener==e.uiTarget.name)
                  {
                     eGl.getCallback().apply(null,args);
                  }
                  if(_aEvent[hook.name]==null)
                  {
                     break;
                  }
               }
            }
            i++;
         }
         delete this._aLoadingUi[[e.uiTarget.name]];
      }

      private function throwAsyncError(e:TimerEvent) : void {
         this._asyncErrorTimer.reset();
         if(!(this._asyncError.length))
         {
            return;
         }
         throw this._asyncError.shift();
      }
   }

}