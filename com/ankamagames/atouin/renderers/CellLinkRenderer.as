package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.types.CellLink;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.types.DataMapContainer;
   import flash.geom.Point;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.utils.CellUtil;
   
   public class CellLinkRenderer extends Object implements IZoneRenderer
   {
      
      public function CellLinkRenderer(param1:Number = 10, param2:Number = 1, param3:Boolean = false, param4:uint = 160)
      {
         super();
         this.strata = param4;
         this._thickness = param1;
         this._alpha = param2;
         this._useThicknessMalus = param3;
      }
      
      public var strata:uint;
      
      public var cells:Vector.<Cell>;
      
      private var _cellLinks:Vector.<CellLink>;
      
      private var _useThicknessMalus:Boolean;
      
      private var _thickness:Number;
      
      private var _alpha:Number;
      
      public function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc7_:CellLink = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:MapPoint = null;
         var _loc12_:MapPoint = null;
         var _loc14_:* = 0;
         this._cellLinks = new Vector.<CellLink>();
         var _loc6_:Vector.<MapPoint> = new Vector.<MapPoint>();
         while(param1.length)
         {
            _loc6_.push(MapPoint.fromCellId(param1.shift()));
         }
         var _loc13_:Number = this._thickness;
         var _loc15_:int = _loc6_.length - 1;
         _loc14_ = 0;
         while(_loc14_ < _loc15_)
         {
            _loc8_ = CellUtil.getPixelsPointFromMapPoint(_loc6_[_loc14_],false);
            _loc9_ = CellUtil.getPixelsPointFromMapPoint(_loc6_[_loc14_ + 1],false);
            if(_loc8_.y > _loc9_.y || _loc8_.y == _loc9_.y && _loc8_.x > _loc9_.x)
            {
               _loc11_ = _loc6_[_loc14_];
               _loc12_ = _loc6_[_loc14_ + 1];
               _loc10_ = new Point(_loc9_.x - _loc8_.x,_loc9_.y - _loc8_.y);
            }
            else
            {
               _loc11_ = _loc6_[_loc14_ + 1];
               _loc12_ = _loc6_[_loc14_];
               _loc10_ = new Point(_loc8_.x - _loc9_.x,_loc8_.y - _loc9_.y);
            }
            _loc7_ = new CellLink();
            _loc7_.graphics.lineStyle(_loc13_,param2.color,this._alpha);
            _loc7_.graphics.moveTo(0,0);
            _loc7_.graphics.lineTo(_loc10_.x,_loc10_.y);
            _loc7_.orderedCheckpoints = new <MapPoint>[_loc11_,_loc12_];
            _loc7_.display(this.strata);
            this._cellLinks.push(_loc7_);
            _loc13_ = _loc13_ - 2;
            if(_loc13_ < 1)
            {
               _loc13_ = 1;
            }
            _loc14_++;
         }
      }
      
      public function remove(param1:Vector.<uint>, param2:DataMapContainer) : void
      {
         if(this._cellLinks)
         {
            while(this._cellLinks.length)
            {
               this._cellLinks.pop().remove();
            }
         }
         this._cellLinks = null;
      }
   }
}
