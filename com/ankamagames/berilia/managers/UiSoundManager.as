package com.ankamagames.berilia.managers
{
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.data.BeriliaUiSound;
   import com.ankamagames.berilia.types.data.BeriliaUiElementSound;
   import com.ankamagames.berilia.types.data.Hook;
   import __AS3__.vec.Vector;
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
      
      public function registerUi(param1:String, param2:String=null, param3:String=null) : void {
         var _loc4_:BeriliaUiSound = this._registeredUi[param1];
         if(!_loc4_)
         {
            _loc4_ = new BeriliaUiSound();
            _loc4_.uiName = param1;
            _loc4_.openFile = param2;
            _loc4_.closeFile = param3;
            this._registeredUi[param1] = _loc4_;
         }
         else
         {
            _loc4_.openFile = param2;
            _loc4_.closeFile = param3;
         }
      }
      
      public function getUi(param1:String) : BeriliaUiSound {
         return this._registeredUi[param1];
      }
      
      public function registerUiElement(param1:String, param2:String, param3:String, param4:String) : void {
         var _loc5_:BeriliaUiElementSound = new BeriliaUiElementSound();
         _loc5_.name = param2;
         _loc5_.file = param4;
         _loc5_.hook = param3;
         this._registeredUiElement[param1 + "::" + param2 + "::" + param3] = _loc5_;
      }
      
      public function fromHook(param1:Hook, param2:Array=null) : Boolean {
         return true;
      }
      
      public function getAllSoundUiElement(param1:GraphicContainer) : Vector.<BeriliaUiElementSound> {
         var _loc5_:String = null;
         var _loc2_:Vector.<BeriliaUiElementSound> = new Vector.<BeriliaUiElementSound>();
         if(!param1.getUi())
         {
            return _loc2_;
         }
         var _loc3_:* = param1.getUi().name + "::";
         var _loc4_:uint = _loc3_.length;
         for (_loc5_ in this._registeredUiElement)
         {
            if(_loc5_.substr(0,_loc4_) == _loc3_ && _loc5_.substr(_loc4_,param1.name.length) == param1.name)
            {
               _loc2_.push(this._registeredUiElement[_loc5_]);
            }
         }
         return _loc2_;
      }
      
      public function fromUiElement(param1:GraphicContainer, param2:String) : Boolean {
         if(!param1 || !param2 || !param1.getUi())
         {
            return false;
         }
         var _loc3_:BeriliaUiElementSound = this._registeredUiElement[param1.getUi().name + "::" + param1.name + "::" + param2];
         if((param1.getUi()) && (_loc3_))
         {
            if(this.playSound != null)
            {
               this.playSound(_loc3_.file);
            }
            return true;
         }
         return false;
      }
      
      public function fromUi(param1:UiRootContainer, param2:uint) : Boolean {
         if(this._registeredUi[param1.name])
         {
            return true;
         }
         return false;
      }
   }
}
