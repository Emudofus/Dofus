package com.ankamagames.dofus.internalDatacenter.appearance
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import flash.utils.flash_proxy;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   use namespace flash_proxy;
   
   public class TitleWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      public function TitleWrapper() {
         super();
      }
      
      private static var _cache:Array = new Array();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TitleWrapper));
      
      public static function create(titleId:uint, position:int=-1, useCache:Boolean=true) : TitleWrapper {
         var title:TitleWrapper = new TitleWrapper();
         if((!_cache[titleId]) || (!useCache))
         {
            title = new TitleWrapper();
            title.id = titleId;
            if(useCache)
            {
               _cache[titleId] = title;
            }
         }
         else
         {
            title = _cache[titleId];
         }
         title.id = titleId;
         title.text = title.text;
         return title;
      }
      
      public static function getTitleWrapperById(id:uint) : TitleWrapper {
         return _cache[id];
      }
      
      private var _uri:Uri;
      
      public var id:uint = 0;
      
      public var text:String;
      
      public var isOkForMultiUse:Boolean = false;
      
      public var quantity:uint = 1;
      
      public function get iconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/illusUi/genericTitleIcon.png"));
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/illusUi/genericTitleIcon.png"));
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
      
      public function set timerToStart(t:int) : void {
      }
      
      public function get active() : Boolean {
         return true;
      }
      
      public function get title() : Title {
         return Title.getTitleById(this.id);
      }
      
      public function get titleId() : uint {
         return this.id;
      }
      
      public function get isUsable() : Boolean {
         return false;
      }
      
      override flash_proxy function getProperty(name:*) : * {
         var t:* = undefined;
         var r:* = undefined;
         if(isAttribute(name))
         {
            return this[name];
         }
         t = this.title;
         if(!t)
         {
            r = "";
         }
         try
         {
            return t[name];
         }
         catch(e:Error)
         {
            return "Error_on_item_" + name;
         }
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean {
         return isAttribute(name);
      }
      
      public function toString() : String {
         return "[TitleWrapper#" + this.id + "]";
      }
      
      public function addHolder(h:ISlotDataHolder) : void {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void {
      }
      
      public function getIconUri(pngMode:Boolean=true) : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/illusUi/genericTitleIcon.png"));
         }
         return this._uri;
      }
   }
}
