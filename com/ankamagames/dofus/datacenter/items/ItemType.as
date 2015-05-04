package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ItemType extends Object implements IDataCenter
   {
      
      public function ItemType()
      {
         super();
      }
      
      public static const MODULE:String = "ItemTypes";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemType));
      
      public static function getItemTypeById(param1:uint) : ItemType
      {
         return GameData.getObject(MODULE,param1) as ItemType;
      }
      
      public static function getItemTypes() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      private var _zoneSize:uint = 4.294967295E9;
      
      private var _zoneShape:uint = 4.294967295E9;
      
      private var _zoneMinSize:uint = 4.294967295E9;
      
      public var id:int;
      
      public var nameId:uint;
      
      public var superTypeId:uint;
      
      public var plural:Boolean;
      
      public var gender:uint;
      
      public var rawZone:String;
      
      public var needUseConfirm:Boolean;
      
      public var mimickable:Boolean;
      
      private var _name:String;
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get zoneSize() : uint
      {
         if(this._zoneSize == uint.MAX_VALUE)
         {
            this.parseZone();
         }
         return this._zoneSize;
      }
      
      public function get zoneShape() : uint
      {
         if(this._zoneShape == uint.MAX_VALUE)
         {
            this.parseZone();
         }
         return this._zoneShape;
      }
      
      public function get zoneMinSize() : uint
      {
         if(this._zoneMinSize == uint.MAX_VALUE)
         {
            this.parseZone();
         }
         return this._zoneMinSize;
      }
      
      private function parseZone() : void
      {
         var _loc1_:Array = null;
         if((this.rawZone) && (this.rawZone.length))
         {
            this._zoneShape = this.rawZone.charCodeAt(0);
            _loc1_ = this.rawZone.substr(1).split(",");
            if(_loc1_.length > 0)
            {
               this._zoneSize = parseInt(_loc1_[0]);
            }
            else
            {
               this._zoneSize = 0;
            }
            if(_loc1_.length > 1)
            {
               this._zoneMinSize = parseInt(_loc1_[1]);
            }
            else
            {
               this._zoneMinSize = 0;
            }
         }
         else
         {
            _log.error("Zone incorrect (" + this.rawZone + ")");
         }
      }
   }
}
