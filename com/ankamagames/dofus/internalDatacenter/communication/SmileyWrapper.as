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
   
   public class SmileyWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      public function SmileyWrapper() {
         super();
      }
      
      private static var _cache:Array;
      
      protected static const _log:Logger;
      
      public static function create(smileyId:uint, iconId:String, order:int, useCache:Boolean = true) : SmileyWrapper {
         var smiley:SmileyWrapper = null;
         if((!_cache[smileyId]) || (!useCache))
         {
            smiley = new SmileyWrapper();
            smiley.id = smileyId;
            if(useCache)
            {
               _cache[smileyId] = smiley;
            }
         }
         else
         {
            smiley = _cache[smileyId];
         }
         smiley.iconId = iconId;
         smiley.order = order;
         return smiley;
      }
      
      public static function getSmileyWrapperById(id:uint) : SmileyWrapper {
         return _cache[id];
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
      
      public function set endTime(t:int) : void {
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
      
      override flash_proxy function getProperty(name:*) : * {
         if(isAttribute(name))
         {
            return this[name];
         }
         return "Error on smiley " + name;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean {
         return isAttribute(name);
      }
      
      public function toString() : String {
         return "[SmileyWrapper#" + this.id + "]";
      }
      
      public function addHolder(h:ISlotDataHolder) : void {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void {
      }
      
      public function getIconUri(pngMode:Boolean = true) : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path") + "gfx/smilies/assets.swf|" + this.iconId);
         }
         return this._uri;
      }
   }
}
