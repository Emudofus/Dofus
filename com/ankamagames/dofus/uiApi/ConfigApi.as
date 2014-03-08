package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.berilia.managers.ThemeManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.tiphon.engine.Tiphon;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.atouin.types.AtouinOptions;
   import com.ankamagames.dofus.types.DofusOptions;
   import com.ankamagames.berilia.types.BeriliaOptions;
   import com.ankamagames.tiphon.types.TiphonOptions;
   import com.ankamagames.tubul.types.TubulOptions;
   import com.ankamagames.dofus.misc.options.ChatOptions;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class ConfigApi extends Object implements IApi
   {
      
      public function ConfigApi() {
         super();
         this.init();
      }
      
      private static var _init:Boolean = false;
      
      private var _module:UiModule;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
         _init = false;
      }
      
      public function getConfigProperty(param1:String, param2:String) : * {
         var _loc3_:* = OptionManager.getOptionManager(param1);
         if(!_loc3_)
         {
            throw new ApiError("Config module [" + param1 + "] does not exist.");
         }
         else
         {
            if((_loc3_) && (this.isSimpleConfigType(_loc3_[param2])))
            {
               return _loc3_[param2];
            }
            return null;
         }
      }
      
      public function setConfigProperty(param1:String, param2:String, param3:*) : void {
         var _loc4_:OptionManager = OptionManager.getOptionManager(param1);
         if(!_loc4_)
         {
            throw new ApiError("Config module [" + param1 + "] does not exist.");
         }
         else
         {
            if(this.isSimpleConfigType(_loc4_.getDefaultValue(param2)))
            {
               _loc4_[param2] = param3;
               return;
            }
            throw new ApiError(param2 + " cannot be set in config module " + param1 + ".");
         }
      }
      
      public function resetConfigProperty(param1:String, param2:String) : void {
         if(!OptionManager.getOptionManager(param1))
         {
            throw ApiError("Config module [" + param1 + "] does not exist.");
         }
         else
         {
            OptionManager.getOptionManager(param1).restaureDefaultValue(param2);
            return;
         }
      }
      
      public function createOptionManager(param1:String) : OptionManager {
         var _loc2_:OptionManager = new OptionManager(param1);
         return _loc2_;
      }
      
      public function getAllThemes() : Array {
         return ThemeManager.getInstance().getThemes();
      }
      
      public function getCurrentTheme() : String {
         return ThemeManager.getInstance().currentTheme;
      }
      
      public function isOptionalFeatureActive(param1:int) : Boolean {
         var _loc2_:MiscFrame = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
         return _loc2_.isOptionalFeatureActive(param1);
      }
      
      public function getServerConstant(param1:int) : Object {
         return MiscFrame.getInstance().getServerSessionConstant(param1);
      }
      
      public function getExternalNotificationOptions(param1:int) : Object {
         return ExternalNotificationManager.getInstance().getNotificationOptions(param1);
      }
      
      public function setExternalNotificationOptions(param1:int, param2:Object) : void {
         ExternalNotificationManager.getInstance().setNotificationOptions(param1,param2);
      }
      
      public function setDebugMode(param1:Boolean) : void {
         DofusErrorHandler.manualActivation = param1;
         if(param1)
         {
            DofusErrorHandler.activateDebugMode();
         }
      }
      
      public function getDebugMode() : Boolean {
         return DofusErrorHandler.manualActivation;
      }
      
      public function debugFileExists() : Boolean {
         return DofusErrorHandler.debugFileExists;
      }
      
      private function init() : void {
         if(_init)
         {
            return;
         }
         _init = true;
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Tiphon.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }
      
      private function isSimpleConfigType(param1:*) : Boolean {
         switch(true)
         {
            case param1 is int:
            case param1 is uint:
            case param1 is Number:
            case param1 is Boolean:
            case param1 is String:
               return true;
            default:
               return false;
         }
      }
      
      private function onPropertyChanged(param1:PropertyChangeEvent) : void {
         var _loc4_:String = null;
         var _loc2_:* = param1.propertyValue;
         if(_loc2_ is DisplayObject)
         {
            _loc2_ = SecureCenter.secure(_loc2_,this._module.trusted);
         }
         var _loc3_:* = param1.propertyOldValue;
         if(_loc3_ is DisplayObject)
         {
            _loc2_ = SecureCenter.secure(_loc2_,this._module.trusted);
         }
         switch(true)
         {
            case param1.watchedClassInstance is AtouinOptions:
               _loc4_ = "atouin";
               break;
            case param1.watchedClassInstance is DofusOptions:
               _loc4_ = "dofus";
               break;
            case param1.watchedClassInstance is BeriliaOptions:
               _loc4_ = "berilia";
               break;
            case param1.watchedClassInstance is TiphonOptions:
               _loc4_ = "tiphon";
               break;
            case param1.watchedClassInstance is TubulOptions:
               _loc4_ = "soundmanager";
               break;
            case param1.watchedClassInstance is ChatOptions:
               _loc4_ = "chat";
               break;
            default:
               _loc4_ = getQualifiedClassName(param1.watchedClassInstance);
         }
         KernelEventsManager.getInstance().processCallback(HookList.ConfigPropertyChange,_loc4_,param1.propertyName,_loc2_,_loc3_);
      }
   }
}
