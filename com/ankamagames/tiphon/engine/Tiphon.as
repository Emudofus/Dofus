package com.ankamagames.tiphon.engine
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.types.ColoredSprite;
   import com.ankamagames.tiphon.types.AdvancedColoredSprite;
   import com.ankamagames.tiphon.types.CarriedSprite;
   import com.ankamagames.tiphon.types.EquipmentSprite;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import com.ankamagames.tiphon.TiphonConstants;
   import flash.events.Event;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public final class Tiphon extends EventDispatcher implements IFLAEventHandler
   {
      
      public function Tiphon() {
         this._rasterizedAnimationNameList = new Array();
         super();
         if(_self != null)
         {
            throw new SingletonError("Tiphon is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(Tiphon));
      
      private static var _self:Tiphon;
      
      public static const skullLibrary:LibrariesManager = TiphonLibraries.skullLibrary;
      
      public static const skinLibrary:LibrariesManager = TiphonLibraries.skinLibrary;
      
      public static function getInstance() : Tiphon {
         if(_self == null)
         {
            _self = new Tiphon();
         }
         return _self;
      }
      
      protected var coloredSprite:ColoredSprite;
      
      protected var advancedColoredSprite:AdvancedColoredSprite;
      
      protected var carriedSprite:CarriedSprite;
      
      protected var equipmentSprite:EquipmentSprite;
      
      protected var scriptedAnimation:ScriptedAnimation;
      
      private var _rasterizedAnimationNameList:Array;
      
      private var _toOptions;
      
      private var _waitForInit:Boolean;
      
      public function addRasterizeAnimation(param1:String) : void {
      }
      
      public function isRasterizeAnimation(param1:String) : Boolean {
         return this._rasterizedAnimationNameList[param1];
      }
      
      public function get options() : * {
         return this._toOptions;
      }
      
      public function init(param1:String, param2:String, param3:String=null) : void {
         if(param1.split("://").length == 1)
         {
            param1 = "file://" + param1;
         }
         if(param2.split("://").length == 1)
         {
            param2 = "file://" + param2;
         }
         TiphonConstants.SWF_SKULL_PATH = param1;
         TiphonConstants.SWF_SKIN_PATH = param2;
         if(param3)
         {
            this._waitForInit = true;
            BoneIndexManager.getInstance().addEventListener(Event.INIT,this.onBoneIndexManagerInit);
            BoneIndexManager.getInstance().init(param3);
         }
         TiphonFpsManager.init();
         TiphonEventsManager.addListener(this,TiphonEvent.PLAYANIM_EVENT);
         if(!this._waitForInit)
         {
            dispatchEvent(new Event(Event.INIT));
         }
      }
      
      public function setDisplayOptions(param1:*) : void {
         this._toOptions = param1;
      }
      
      public function handleFLAEvent(param1:String, param2:String, param3:String, param4:Object=null) : void {
         var _loc5_:TiphonSprite = param4 as TiphonSprite;
         if(param3 == TiphonEvent.EVENT_SHOT)
         {
            _loc5_.onAnimationEvent(TiphonEvent.EVENT_SHOT);
         }
         else
         {
            if(param3 == TiphonEvent.EVENT_END)
            {
               _loc5_.onAnimationEvent(TiphonEvent.EVENT_END);
            }
            else
            {
               if(param3 == TiphonEvent.PLAYER_STOP)
               {
                  _loc5_.onAnimationEvent(TiphonEvent.PLAYER_STOP);
               }
               else
               {
                  if(param2 == TiphonEvent.PLAYANIM_EVENT)
                  {
                     _loc5_.onAnimationEvent(TiphonEvent.PLAYANIM_EVENT,param3);
                  }
               }
            }
         }
      }
      
      public function removeEntitySound(param1:IEntity) : void {
      }
      
      private function onBoneIndexManagerInit(param1:Event) : void {
         dispatchEvent(new Event(Event.INIT));
      }
   }
}
