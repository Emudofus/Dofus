package com.ankamagames.atouin.data.map
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class CellData extends Object
   {
      
      public function CellData(map:Map, cellId:uint) {
         super();
         this.id = cellId;
         this._map = map;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CellData));
      
      public var id:uint;
      
      public var speed:int;
      
      public var mapChangeData:uint;
      
      public var moveZone:uint;
      
      private var _losmov:int = 3;
      
      private var _floor:int;
      
      private var _map:Map;
      
      private var _arrow:int = 0;
      
      public function get map() : Map {
         return this._map;
      }
      
      private var _mov:Boolean;
      
      public function get mov() : Boolean {
         return this._mov;
      }
      
      private var _los:Boolean;
      
      public function get los() : Boolean {
         return this._los;
      }
      
      private var _nonWalkableDuringFight:Boolean;
      
      public function get nonWalkableDuringFight() : Boolean {
         return this._nonWalkableDuringFight;
      }
      
      private var _red:Boolean;
      
      public function get red() : Boolean {
         return this._red;
      }
      
      private var _blue:Boolean;
      
      public function get blue() : Boolean {
         return this._blue;
      }
      
      private var _farmCell:Boolean;
      
      public function get farmCell() : Boolean {
         return this._farmCell;
      }
      
      private var _visible:Boolean;
      
      public function get visible() : Boolean {
         return this._visible;
      }
      
      private var _nonWalkableDuringRP:Boolean;
      
      public function get nonWalkableDuringRP() : Boolean {
         return this._nonWalkableDuringRP;
      }
      
      public function get floor() : int {
         return this._floor;
      }
      
      public function get useTopArrow() : Boolean {
         return !((this._arrow & 1) == 0);
      }
      
      public function get useBottomArrow() : Boolean {
         return !((this._arrow & 2) == 0);
      }
      
      public function get useRightArrow() : Boolean {
         return !((this._arrow & 4) == 0);
      }
      
      public function get useLeftArrow() : Boolean {
         return !((this._arrow & 8) == 0);
      }
      
      public function fromRaw(raw:IDataInput) : void {
         var tmpBits:int = 0;
         try
         {
            this._floor = raw.readByte() * 10;
            if(this._floor == -1280)
            {
               return;
            }
            this._losmov = raw.readUnsignedByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (CellData) LOS+MOV : " + this._losmov);
            }
            this.speed = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (CellData) Speed : " + this.speed);
            }
            this.mapChangeData = raw.readUnsignedByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (CellData) MapChangeData : " + this.mapChangeData);
            }
            if(this._map.mapVersion > 5)
            {
               this.moveZone = raw.readUnsignedByte();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("  (CellData) moveZone : " + this.moveZone);
               }
            }
            if(this._map.mapVersion > 7)
            {
               tmpBits = raw.readByte();
               this._arrow = 15 & tmpBits;
               if(this.useTopArrow)
               {
                  this._map.topArrowCell.push(this.id);
               }
               if(this.useBottomArrow)
               {
                  this._map.bottomArrowCell.push(this.id);
               }
               if(this.useLeftArrow)
               {
                  this._map.leftArrowCell.push(this.id);
               }
               if(this.useRightArrow)
               {
                  this._map.rightArrowCell.push(this.id);
               }
            }
         }
         catch(e:*)
         {
            throw e;
         }
         this._los = (this._losmov & 2) >> 1 == 1;
         this._mov = (this._losmov & 1) == 1;
         this._visible = (this._losmov & 64) >> 6 == 1;
         this._farmCell = (this._losmov & 32) >> 5 == 1;
         this._blue = (this._losmov & 16) >> 4 == 1;
         this._red = (this._losmov & 8) >> 3 == 1;
         this._nonWalkableDuringRP = (this._losmov & 128) >> 7 == 1;
         this._nonWalkableDuringFight = (this._losmov & 4) >> 2 == 1;
      }
   }
}
