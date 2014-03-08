package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.TrapZoneTile;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.filters.ColorMatrixFilter;
   
   public class TrapZoneRenderer extends Object implements IZoneRenderer
   {
      
      public function TrapZoneRenderer(param1:uint=10) {
         super();
         this._aZoneTile = new Array();
         this._aCellTile = new Array();
         this.strata = param1;
      }
      
      private var _aZoneTile:Array;
      
      private var _aCellTile:Array;
      
      public var strata:uint;
      
      public function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean=false, param5:Boolean=false) : void {
         var _loc6_:TrapZoneTile = null;
         var _loc8_:uint = 0;
         var _loc9_:MapPoint = null;
         var _loc10_:* = false;
         var _loc11_:* = false;
         var _loc12_:* = false;
         var _loc13_:* = false;
         var _loc14_:uint = 0;
         var _loc15_:MapPoint = null;
         var _loc7_:* = 0;
         while(_loc7_ < param1.length)
         {
            if(!this._aZoneTile[_loc7_])
            {
               this._aZoneTile[_loc7_] = _loc6_ = new TrapZoneTile();
               _loc6_.mouseChildren = false;
               _loc6_.mouseEnabled = false;
               _loc6_.strata = this.strata;
               _loc6_.filters = [new ColorMatrixFilter([0,0,0,0,param2.red,0,0,0,0,param2.green,0,0,0,0,param2.blue,0,0,0,0.7,0])];
            }
            this._aCellTile[_loc7_] = param1[_loc7_];
            _loc8_ = param1[_loc7_];
            _loc9_ = MapPoint.fromCellId(_loc8_);
            TrapZoneTile(this._aZoneTile[_loc7_]).cellId = _loc8_;
            _loc10_ = false;
            _loc11_ = false;
            _loc12_ = false;
            _loc13_ = false;
            for each (_loc14_ in param1)
            {
               if(_loc14_ != _loc8_)
               {
                  _loc15_ = MapPoint.fromCellId(_loc14_);
                  if(_loc15_.x == _loc9_.x)
                  {
                     if(_loc15_.y == _loc9_.y-1)
                     {
                        _loc10_ = true;
                     }
                     else
                     {
                        if(_loc15_.y == _loc9_.y + 1)
                        {
                           _loc11_ = true;
                        }
                     }
                  }
                  else
                  {
                     if(_loc15_.y == _loc9_.y)
                     {
                        if(_loc15_.x == _loc9_.x-1)
                        {
                           _loc12_ = true;
                        }
                        else
                        {
                           if(_loc15_.x == _loc9_.x + 1)
                           {
                              _loc13_ = true;
                           }
                        }
                     }
                  }
               }
            }
            TrapZoneTile(this._aZoneTile[_loc7_]).drawStroke(_loc10_,_loc12_,_loc11_,_loc13_);
            TrapZoneTile(this._aZoneTile[_loc7_]).display(this.strata);
            _loc7_++;
         }
         while(_loc7_ < this._aZoneTile.length)
         {
            if(this._aZoneTile[_loc7_])
            {
               (this._aZoneTile[_loc7_] as TrapZoneTile).remove();
            }
            _loc7_++;
         }
      }
      
      public function remove(param1:Vector.<uint>, param2:DataMapContainer) : void {
         if(!param1)
         {
            return;
         }
         var _loc3_:Array = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_[param1[_loc4_]] = true;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < this._aCellTile.length)
         {
            if(_loc3_[this._aCellTile[_loc4_]])
            {
               if(this._aZoneTile[_loc4_])
               {
                  TrapZoneTile(this._aZoneTile[_loc4_]).remove();
               }
               delete this._aZoneTile[[_loc4_]];
               delete this._aCellTile[[_loc4_]];
            }
            _loc4_++;
         }
      }
   }
}
