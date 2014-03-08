package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import com.ankamagames.atouin.types.ZoneClipTile;
   import com.ankamagames.jerakine.types.Uri;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import com.ankamagames.jerakine.utils.prng.PRNG;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.atouin.Atouin;
   
   public class ZoneClipRenderer extends Object implements IZoneRenderer
   {
      
      public function ZoneClipRenderer(param1:uint, param2:String, param3:Array, param4:int=-1, param5:Boolean=false) {
         super();
         this._aZoneTile = new Array();
         this._aCellTile = new Array();
         this.strata = param1;
         this._currentMapId = param4;
         this._needBorders = param5;
         this._uri = new Uri(param2);
         this._clipName = param3;
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }
      
      private static var zoneTile:Array = new Array();
      
      private static function getZoneTile(param1:Uri, param2:String, param3:Boolean) : ZoneClipTile {
         var _loc5_:ZoneClipTile = null;
         var _loc4_:CachedTile = getData(param1.fileName,param2);
         if(_loc4_.length)
         {
            return _loc4_.shift();
         }
         _loc5_ = new ZoneClipTile(param1,param2,param3);
         return _loc5_;
      }
      
      private static function destroyZoneTile(param1:ZoneClipTile) : void {
         param1.remove();
         var _loc2_:CachedTile = getData(param1.uri.fileName,param1.clipName);
         _loc2_.push(param1);
      }
      
      private static function getData(param1:String, param2:String) : CachedTile {
         var _loc3_:* = 0;
         var _loc4_:int = zoneTile.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(zoneTile[_loc3_].uriName == param1 && zoneTile[_loc3_].clipName == param2)
            {
               return zoneTile[_loc3_] as ZoneClipRenderer;
            }
            _loc3_ = _loc3_ + 1;
         }
         var _loc5_:CachedTile = new CachedTile(param1,param2);
         zoneTile.push(_loc5_);
         return _loc5_;
      }
      
      private var _uri:Uri;
      
      private var _clipName:Array;
      
      private var _currentMapId:int;
      
      private var _needBorders:Boolean;
      
      protected var _aZoneTile:Array;
      
      protected var _aCellTile:Array;
      
      public var strata:uint = 0;
      
      protected var _cells:Vector.<uint>;
      
      public function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean=false, param5:Boolean=false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function remove(param1:Vector.<uint>, param2:DataMapContainer) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onPropertyChanged(param1:PropertyChangeEvent) : void {
         var _loc2_:* = 0;
         var _loc3_:ZoneClipTile = null;
         if(param1.propertyName == "transparentOverlayMode")
         {
            _loc2_ = 0;
            while(_loc2_ < this._aZoneTile.length)
            {
               _loc3_ = this._aZoneTile[_loc2_];
               _loc3_.remove();
               _loc3_.display();
               _loc2_++;
            }
         }
      }
   }
}
import __AS3__.vec.Vector;
import com.ankamagames.atouin.types.ZoneClipTile;

class CachedTile extends Object
{
   
   function CachedTile(param1:String, param2:String) {
      super();
      this.uriName = param1;
      this.clipName = param2;
      this._list = new Vector.<ZoneClipTile>();
   }
   
   public var uriName:String;
   
   public var clipName:String;
   
   private var _list:Vector.<ZoneClipTile>;
   
   public function push(param1:ZoneClipTile) : void {
      this._list.push(param1);
   }
   
   public function shift() : ZoneClipTile {
      return this._list.shift();
   }
   
   public function get length() : uint {
      return this._list.length;
   }
}
