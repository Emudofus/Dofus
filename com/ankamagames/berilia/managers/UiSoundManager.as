package com.ankamagames.berilia.managers
{
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.data.BeriliaUiSound;
   import com.ankamagames.berilia.types.data.BeriliaUiElementSound;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   
   public class UiSoundManager extends Object
   {
      
      public function UiSoundManager() {
         this._registeredHook = new Dictionary();
         this._registeredUi = new Dictionary();
         this._registeredUiElement = new Dictionary();
         super();
      }
      
      public static const UI_LOAD:uint = 0;
      
      public static const UI_UNLOAD:uint = 1;
      
      private static var _self:UiSoundManager;
      
      public static function getInstance() : UiSoundManager {
         if(!_self)
         {
            _self = new UiSoundManager();
         }
         return _self;
      }
      
      private var _registeredHook:Dictionary;
      
      private var _registeredUi:Dictionary;
      
      private var _registeredUiElement:Dictionary;
      
      public var playSound:Function;
      
      public function registerUi(uiName:String, openFile:String = null, closeFile:String = null) : void {
         var uiSound:BeriliaUiSound = this._registeredUi[uiName];
         if(!uiSound)
         {
            uiSound = new BeriliaUiSound();
            uiSound.uiName = uiName;
            uiSound.openFile = openFile;
            uiSound.closeFile = closeFile;
            this._registeredUi[uiName] = uiSound;
         }
         else
         {
            uiSound.openFile = openFile;
            uiSound.closeFile = closeFile;
         }
      }
      
      public function getUi(uiName:String) : BeriliaUiSound {
         return this._registeredUi[uiName];
      }
      
      public function registerUiElement(uiName:String, instanceName:String, hookFct:String, file:String) : void {
         var uiElementSound:BeriliaUiElementSound = new BeriliaUiElementSound();
         uiElementSound.name = instanceName;
         uiElementSound.file = file;
         uiElementSound.hook = hookFct;
         this._registeredUiElement[uiName + "::" + instanceName + "::" + hookFct] = uiElementSound;
      }
      
      public function fromHook(target:Hook, params:Array = null) : Boolean {
         return true;
      }
      
      public function getAllSoundUiElement(target:GraphicContainer) : Vector.<BeriliaUiElementSound> {
         var elementHash:String = null;
         var result:Vector.<BeriliaUiElementSound> = new Vector.<BeriliaUiElementSound>();
         if(!target.getUi())
         {
            return result;
         }
         var uiName:String = target.getUi().name + "::";
         var uiNameLen:uint = uiName.length;
         for(elementHash in this._registeredUiElement)
         {
            if((elementHash.substr(0,uiNameLen) == uiName) && (elementHash.substr(uiNameLen,target.name.length) == target.name))
            {
               result.push(this._registeredUiElement[elementHash]);
            }
         }
         return result;
      }
      
      public function fromUiElement(target:GraphicContainer, hookFct:String) : Boolean {
         if((!target) || (!hookFct) || (!target.getUi()))
         {
            return false;
         }
         var sndElem:BeriliaUiElementSound = this._registeredUiElement[target.getUi().name + "::" + target.name + "::" + hookFct];
         if((target.getUi()) && (sndElem))
         {
            if(this.playSound != null)
            {
               this.playSound(sndElem.file);
            }
            return true;
         }
         return false;
      }
      
      public function fromUi(target:UiRootContainer, eventType:uint) : Boolean {
         if(this._registeredUi[target.name])
         {
            return true;
         }
         return false;
      }
   }
}
