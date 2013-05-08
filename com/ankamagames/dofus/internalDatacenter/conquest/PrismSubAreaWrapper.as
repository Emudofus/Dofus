package com.ankamagames.dofus.internalDatacenter.conquest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;


   public class PrismSubAreaWrapper extends Object implements IDataCenter
   {
         

      public function PrismSubAreaWrapper() {
         super();
      }

      private static var _cache:Array = new Array();

      public static function create(subId:uint, align:uint, mapId:uint, isInFight:Boolean, isFightable:Boolean, useCache:Boolean=false, worldX:int=0, worldY:int=0) : PrismSubAreaWrapper {
         var prism:PrismSubAreaWrapper = null;
         if((!_cache[subId])||(!useCache))
         {
            prism=new PrismSubAreaWrapper();
            prism._subId=subId;
            prism._align=align;
            prism._mapId=mapId;
            prism._worldX=worldX;
            prism._worldY=worldY;
            prism._isInFight=isInFight;
            prism._isFightable=isFightable;
            if(useCache)
            {
               _cache[subId]=prism;
            }
         }
         else
         {
            prism=_cache[subId];
         }
         return prism;
      }

      private var _subId:uint;

      private var _align:uint;

      private var _mapId:uint;

      private var _worldX:int;

      private var _worldY:int;

      private var _isInFight:Boolean;

      private var _isFightable:Boolean;

      public function get subAreaId() : uint {
         return this._subId;
      }

      public function get alignmentId() : uint {
         return this._align;
      }

      public function get mapId() : uint {
         return this._mapId;
      }

      public function get worldX() : int {
         return this._worldX;
      }

      public function get worldY() : int {
         return this._worldY;
      }

      public function get isInFight() : Boolean {
         return this._isInFight;
      }

      public function get isFightable() : Boolean {
         return this._isFightable;
      }
   }

}