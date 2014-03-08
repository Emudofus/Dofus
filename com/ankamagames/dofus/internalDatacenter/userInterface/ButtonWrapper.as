package com.ankamagames.dofus.internalDatacenter.userInterface
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.utils.flash_proxy;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   use namespace flash_proxy;
   
   public class ButtonWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      public function ButtonWrapper() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ButtonWrapper));
      
      public static function create(param1:uint, param2:int, param3:String, param4:Function, param5:String, param6:String="") : ButtonWrapper {
         var _loc7_:ButtonWrapper = new ButtonWrapper();
         _loc7_.id = param1;
         _loc7_.position = param2;
         _loc7_.callback = param4;
         _loc7_.uriName = param3;
         _loc7_.name = param5;
         _loc7_.shortcut = param6;
         return _loc7_;
      }
      
      public static function getButtonWrapperById(param1:uint) : ButtonWrapper {
         return null;
      }
      
      private var _uri:Uri;
      
      private var _active:Boolean = true;
      
      public var position:uint;
      
      public var id:uint = 0;
      
      public var uriName:String;
      
      public var callback:Function;
      
      public var name:String;
      
      public var shortcut:String;
      
      public function get iconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets.swf|").concat(this.uriName));
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets.swf|").concat(this.uriName));
         }
         return this._uri;
      }
      
      public function get backGroundIconUri() : Uri {
         return null;
      }
      
      public function get errorIconUri() : Uri {
         return null;
      }
      
      public function get info1() : String {
         return null;
      }
      
      public function get startTime() : int {
         return 0;
      }
      
      public function get endTime() : int {
         return 0;
      }
      
      public function set endTime(param1:int) : void {
      }
      
      public function get timer() : int {
         return 0;
      }
      
      public function get active() : Boolean {
         return this._active;
      }
      
      public function set active(param1:Boolean) : void {
         this._active = param1;
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         if(isAttribute(param1))
         {
            return this[param1];
         }
         return "Error_on_buttonWrapper_" + param1;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean {
         return isAttribute(param1);
      }
      
      public function toString() : String {
         return "[ButtonWrapper#" + this.id + "]";
      }
      
      public function setPosition(param1:int) : void {
         this.position = param1;
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
      }
      
      public function getIconUri(param1:Boolean=true) : Uri {
         return this.iconUri;
      }
   }
}
