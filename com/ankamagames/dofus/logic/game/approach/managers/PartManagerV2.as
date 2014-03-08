package com.ankamagames.dofus.logic.game.approach.managers
{
   import com.ankamagames.dofus.kernel.updaterv2.IUpdaterMessageHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.kernel.updaterv2.UpdaterApi;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.ComponentListMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.StepMessage;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.ProgressMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.FinishedMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.ErrorMessage;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import flash.utils.setTimeout;
   import d2hooks.UpdateError;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   
   public class PartManagerV2 extends Object implements IUpdaterMessageHandler
   {
      
      public function PartManagerV2() {
         super();
         if(!this.api)
         {
            this.api = new UpdaterApi(this);
         }
      }
      
      private static const instance:PartManagerV2 = new PartManagerV2();
      
      private static const logger:Logger = Log.getLogger(getQualifiedClassName(PartManagerV2));
      
      private static const PROJECT_NAME:String = "game";
      
      public static function getInstance() : PartManagerV2 {
         return instance;
      }
      
      private var api:UpdaterApi;
      
      private var _modules:Dictionary;
      
      private var _init_mode:Boolean;
      
      public function init() : void {
         logger.info("Initializing PartManager");
         this.api.getComponentList(PROJECT_NAME);
      }
      
      public function hasComponent(name:String) : Boolean {
         return this._modules?!(this._modules[name] == null)?this._modules[name].activated as Boolean:false:false;
      }
      
      public function activateComponent(name:String, activate:Boolean=true, project:String="game") : void {
         if(!this.hasComponent(name))
         {
            logger.debug("Ask updater for " + activate?"activate":"desactivate" + " component : " + name);
            this.api.activateComponent(name,activate,project);
         }
      }
      
      public function set installedModules(m:Dictionary) : void {
         this._modules = m;
      }
      
      public function handleMessage(msg:IUpdaterInputMessage) : void {
         var clm:ComponentListMessage = null;
         var sm:StepMessage = null;
         var uiM:UiModule = null;
         var pm:ProgressMessage = null;
         var fm:FinishedMessage = null;
         var em:ErrorMessage = null;
         var hook:Hook = null;
         var params:Array = null;
         switch(true)
         {
            case msg is ComponentListMessage:
               clm = msg as ComponentListMessage;
               this._modules = clm.components;
               break;
            case msg is StepMessage:
               sm = msg as StepMessage;
               if(sm.step == StepMessage.UPDATING_STEP)
               {
                  uiM = UiModuleManager.getInstance().getModule("Ankama_Common");
                  if(!Berilia.getInstance().isUiDisplayed("downloadUiNewUpdaterInstance"))
                  {
                     Berilia.getInstance().loadUi(uiM,uiM.getUi("downloadUiNewUpdater"),"downloadUiNewUpdaterInstance",null,false,StrataEnum.STRATA_HIGH);
                  }
               }
               hook = HookList.UpdateStepChange;
               params = [hook,sm.step];
               break;
            case msg is ProgressMessage:
               pm = msg as ProgressMessage;
               hook = HookList.UpdateProgress;
               params = [hook,pm.step,pm.currentSize,pm.eta,pm.progress,pm.smooth,pm.speed,pm.totalSize];
               break;
            case msg is FinishedMessage:
               fm = msg as FinishedMessage;
               hook = HookList.UpdateFinished;
               params = [hook,fm.needRestart,fm.needUpdate,fm.newVersion,fm.previousVersion,fm.error];
               setTimeout(Berilia.getInstance().unloadUi,2000,"downloadUiNewUpdaterInstance");
               break;
            case msg is d2hooks.UpdateError:
               em = msg as ErrorMessage;
               hook = HookList.UpdateError;
               params = [hook,em.type,em.message];
               break;
         }
         if(hook)
         {
            KernelEventsManager.getInstance().processCallback.apply(null,params);
         }
      }
      
      public function handleConnectionOpened() : void {
         logger.info("Updater is online");
      }
      
      public function handleConnectionClosed() : void {
         logger.info("Connexion with updater has been closed");
      }
   }
}
