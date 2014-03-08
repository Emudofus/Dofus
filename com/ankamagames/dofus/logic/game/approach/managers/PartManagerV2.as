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
      
      public function hasComponent(param1:String) : Boolean {
         return this._modules?this._modules[param1] != null?this._modules[param1].activated as Boolean:false:false;
      }
      
      public function activateComponent(param1:String, param2:Boolean=true, param3:String="game") : void {
         if(!this.hasComponent(param1))
         {
            logger.debug("Ask updater for " + param2?"activate":"desactivate" + " component : " + param1);
            this.api.activateComponent(param1,param2,param3);
         }
      }
      
      public function set installedModules(param1:Dictionary) : void {
         this._modules = param1;
      }
      
      public function handleMessage(param1:IUpdaterInputMessage) : void {
         var _loc4_:ComponentListMessage = null;
         var _loc5_:StepMessage = null;
         var _loc6_:UiModule = null;
         var _loc7_:ProgressMessage = null;
         var _loc8_:FinishedMessage = null;
         var _loc9_:ErrorMessage = null;
         var _loc2_:Hook = null;
         var _loc3_:Array = null;
         switch(true)
         {
            case param1 is ComponentListMessage:
               _loc4_ = param1 as ComponentListMessage;
               this._modules = _loc4_.components;
               break;
            case param1 is StepMessage:
               _loc5_ = param1 as StepMessage;
               if(_loc5_.step == StepMessage.UPDATING_STEP)
               {
                  _loc6_ = UiModuleManager.getInstance().getModule("Ankama_Common");
                  if(!Berilia.getInstance().isUiDisplayed("downloadUiNewUpdaterInstance"))
                  {
                     Berilia.getInstance().loadUi(_loc6_,_loc6_.getUi("downloadUiNewUpdater"),"downloadUiNewUpdaterInstance",null,false,StrataEnum.STRATA_HIGH);
                  }
               }
               _loc2_ = HookList.UpdateStepChange;
               _loc3_ = [_loc2_,_loc5_.step];
               break;
            case param1 is ProgressMessage:
               _loc7_ = param1 as ProgressMessage;
               _loc2_ = HookList.UpdateProgress;
               _loc3_ = [_loc2_,_loc7_.step,_loc7_.currentSize,_loc7_.eta,_loc7_.progress,_loc7_.smooth,_loc7_.speed,_loc7_.totalSize];
               break;
            case param1 is FinishedMessage:
               _loc8_ = param1 as FinishedMessage;
               _loc2_ = HookList.UpdateFinished;
               _loc3_ = [_loc2_,_loc8_.needRestart,_loc8_.needUpdate,_loc8_.newVersion,_loc8_.previousVersion,_loc8_.error];
               setTimeout(Berilia.getInstance().unloadUi,2000,"downloadUiNewUpdaterInstance");
               break;
            case param1 is d2hooks.UpdateError:
               _loc9_ = param1 as ErrorMessage;
               _loc2_ = HookList.UpdateError;
               _loc3_ = [_loc2_,_loc9_.type,_loc9_.message];
         }
         if(_loc2_)
         {
            KernelEventsManager.getInstance().processCallback.apply(null,_loc3_);
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
