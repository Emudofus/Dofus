package com.ankamagames.dofus.internalDatacenter.communication
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
   
   public class SmileyWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      public function SmileyWrapper() {
         super();
      }
      
      private static var _cache:Array = new Array();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SmileyWrapper));
      
      public static function create(param1:uint, param2:String, param3:int, param4:Boolean=true) : SmileyWrapper {
         var _loc5_:SmileyWrapper = null;
         if(!_cache[param1] || !param4)
         {
            _loc5_ = new SmileyWrapper();
            _loc5_.id = param1;
            if(param4)
            {
               _cache[param1] = _loc5_;
            }
         }
         else
         {
            _loc5_ = _cache[param1];
         }
         _loc5_.iconId = param2;
         _loc5_.order = param3;
         return _loc5_;
      }
      
      public static function getSmileyWrapperById(param1:uint) : SmileyWrapper {
         return _cache[param1];
      }
      
      private var _uri:Uri;
      
      public var id:uint = 0;
      
      public var iconId:String;
      
      public var order:int;
      
      public var isOkForMultiUse:Boolean = false;
      
      public var quantity:uint = 1;
      
      public function get iconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path") + "gfx/smilies/assets.swf|" + this.iconId);
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path") + "gfx/smilies/assets.swf|" + this.iconId);
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
         return true;
      }
      
      public function get currentCooldown() : uint {
         return 0;
      }
      
      public function get isUsable() : Boolean {
         return true;
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         if(isAttribute(param1))
         {
            return this[param1];
         }
         return "Error on smiley " + param1;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean {
         return isAttribute(param1);
      }
      
      public function toString() : String {
         return "[SmileyWrapper#" + this.id + "]";
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
      }
      
      public function getIconUri(param1:Boolean=true) : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path") + "gfx/smilies/assets.swf|" + this.iconId);
         }
         return this._uri;
      }
   }
}
