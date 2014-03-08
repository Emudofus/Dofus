package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.datacenter.livingObjects.LivingObjectSkinJntMood;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   public class LivingObjectSkinWrapper extends Object implements ISlotData
   {
      
      public function LivingObjectSkinWrapper() {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(LivingObjectSkinWrapper));
      
      public static function create(param1:int, param2:int, param3:int) : LivingObjectSkinWrapper {
         var _loc4_:LivingObjectSkinWrapper = new LivingObjectSkinWrapper();
         var _loc5_:Item = Item.getItemById(param1);
         _loc4_._id = param1;
         _loc4_._category = _loc5_.category;
         _loc4_._mood = param2;
         _loc4_._skin = param3;
         return _loc4_;
      }
      
      private var _id:int;
      
      private var _category:int;
      
      private var _mood:int;
      
      private var _skin:int;
      
      private var _uri:Uri;
      
      private var _pngMode:Boolean;
      
      private var _backGroundIconUri:Uri;
      
      public function get iconUri() : Uri {
         return this.getIconUri(true);
      }
      
      public function get fullSizeIconUri() : Uri {
         return this.getIconUri(false);
      }
      
      public function get id() : int {
         return this._id;
      }
      
      public function get category() : int {
         return this._category;
      }
      
      public function get mood() : int {
         return this._mood;
      }
      
      public function get skin() : int {
         return this._skin;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public function get errorIconUri() : Uri {
         return null;
      }
      
      public function get backGroundIconUri() : Uri {
         if(!this._backGroundIconUri)
         {
            this._backGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png"));
         }
         return this._backGroundIconUri;
      }
      
      public function set backGroundIconUri(param1:Uri) : void {
         this._backGroundIconUri = param1;
      }
      
      public function getIconUri(param1:Boolean=true) : Uri {
         var _loc3_:* = 0;
         var _loc2_:* = false;
         if(this._uri)
         {
            if(param1 != this._pngMode)
            {
               _loc2_ = true;
            }
         }
         else
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = LivingObjectSkinJntMood.getLivingObjectSkin(this._id,this._mood,this._skin);
            if(param1)
            {
               this._pngMode = true;
               this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(_loc3_).concat(".png"));
            }
            else
            {
               this._pngMode = false;
               this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat(_loc3_).concat(".swf"));
            }
         }
         return this._uri;
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
      
      public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
      }
   }
}
