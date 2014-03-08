package com.ankamagames.dofus.internalDatacenter.appearance
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.utils.flash_proxy;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   use namespace flash_proxy;
   
   public class OrnamentWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      public function OrnamentWrapper() {
         super();
      }
      
      private static var _cache:Array = new Array();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(OrnamentWrapper));
      
      public static function create(param1:uint, param2:int=-1, param3:Boolean=true) : OrnamentWrapper {
         var _loc4_:OrnamentWrapper = new OrnamentWrapper();
         if(!_cache[param1] || !param3)
         {
            _loc4_ = new OrnamentWrapper();
            _loc4_.id = param1;
            if(param3)
            {
               _cache[param1] = _loc4_;
            }
         }
         else
         {
            _loc4_ = _cache[param1];
         }
         var _loc5_:Ornament = Ornament.getOrnamentById(param1);
         _loc4_.id = param1;
         _loc4_.name = _loc5_.name;
         _loc4_.iconId = _loc5_.iconId;
         return _loc4_;
      }
      
      public static function getOrnamentWrapperById(param1:uint) : OrnamentWrapper {
         return _cache[param1];
      }
      
      private var _uri:Uri;
      
      public var id:uint = 0;
      
      public var name:String;
      
      public var iconId:uint = 0;
      
      public var isOkForMultiUse:Boolean = false;
      
      public var quantity:uint = 1;
      
      public function get iconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/ornaments/").concat(this.iconId).concat(".png"));
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/ornaments/").concat(this.iconId).concat(".png"));
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
      
      public function set timerToStart(param1:int) : void {
      }
      
      public function get active() : Boolean {
         return true;
      }
      
      public function get ornament() : Ornament {
         return Ornament.getOrnamentById(this.id);
      }
      
      public function get ornamentId() : uint {
         return this.id;
      }
      
      public function get isUsable() : Boolean {
         return false;
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         var t:* = undefined;
         var r:* = undefined;
         var name:* = param1;
         if(isAttribute(name))
         {
            return this[name];
         }
         t = this.ornament;
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
      
      override flash_proxy function hasProperty(param1:*) : Boolean {
         return isAttribute(param1);
      }
      
      public function toString() : String {
         return "[OrnamentWrapper#" + this.id + "]";
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
      }
      
      public function getIconUri(param1:Boolean=true) : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/ornaments/").concat(this.iconId).concat(".png"));
         }
         return this._uri;
      }
   }
}
