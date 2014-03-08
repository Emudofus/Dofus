package com.ankamagames.atouin.utils
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.atouin.types.miscs.PartialDataMap;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.atouin.types.Frustum;
   import flash.geom.Point;
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.AtouinConstants;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.Sprite;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.atouin.data.map.elements.GraphicalElement;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class VisibleCellDetection extends Object
   {
      
      public function VisibleCellDetection() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(VisibleCellDetection));
      
      public static function detectCell(param1:Boolean, param2:Map, param3:WorldPoint, param4:Frustum, param5:WorldPoint) : PartialDataMap {
         var _loc7_:Point = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:uint = 0;
         var _loc11_:* = 0;
         var _loc12_:GraphicalElementData = null;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc23_:Layer = null;
         var _loc24_:String = null;
         var _loc25_:Cell = null;
         var _loc26_:BasicElement = null;
         var _loc27_:NormalGraphicalElementData = null;
         var _loc28_:uint = 0;
         if(param5 == null)
         {
            _log.error("Cannot detect visible cells with no current map point.");
            return null;
         }
         var _loc6_:PartialDataMap = new PartialDataMap();
         var _loc13_:int = (param3.x - param5.x) * AtouinConstants.CELL_WIDTH * AtouinConstants.MAP_WIDTH;
         var _loc14_:int = (param3.y - param5.y) * AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT;
         var _loc15_:Rectangle = new Rectangle(-param4.x / param4.scale,-param4.y / param4.scale,StageShareManager.startHeight / param4.scale,StageShareManager.stage.stageHeight / param4.scale);
         var _loc16_:Rectangle = new Rectangle();
         var _loc17_:Array = new Array();
         var _loc18_:Array = new Array();
         var _loc21_:Sprite = Sprite(Atouin.getInstance().worldContainer.parent).addChild(new Sprite()) as Sprite;
         _loc21_.graphics.beginFill(0,0);
         _loc21_.graphics.lineStyle(1,16711680);
         var _loc22_:Elements = Elements.getInstance();
         for each (_loc23_ in param2.layers)
         {
            for each (_loc25_ in _loc23_.cells)
            {
               _loc8_ = 0;
               _loc9_ = 0;
               _loc11_ = 100000;
               _loc19_ = 0;
               _loc18_ = new Array();
               for each (_loc26_ in _loc25_.elements)
               {
                  if(_loc26_.elementType == ElementTypesEnum.GRAPHICAL)
                  {
                     _loc12_ = _loc22_.getElementData(GraphicalElement(_loc26_).elementId);
                     _loc20_ = GraphicalElement(_loc26_).altitude * AtouinConstants.ALTITUDE_PIXEL_UNIT;
                     _loc19_ = _loc20_ < _loc19_?_loc20_:_loc19_;
                     if((_loc12_) && _loc12_ is NormalGraphicalElementData)
                     {
                        _loc27_ = _loc12_ as NormalGraphicalElementData;
                        if(-_loc27_.origin.x + AtouinConstants.CELL_WIDTH < _loc11_)
                        {
                           _loc11_ = -_loc27_.origin.x + AtouinConstants.CELL_WIDTH;
                        }
                        if(_loc27_.size.x > _loc9_)
                        {
                           _loc9_ = _loc27_.size.x;
                        }
                        _loc8_ = _loc8_ + (_loc27_.origin.y + _loc27_.size.y);
                        _loc18_.push(_loc27_.gfxId);
                     }
                     else
                     {
                        _loc8_ = _loc8_ + Math.abs(_loc20_);
                     }
                  }
               }
               if(!_loc8_)
               {
                  _loc8_ = AtouinConstants.CELL_HEIGHT;
               }
               if(_loc11_ == 100000)
               {
                  _loc11_ = 0;
               }
               if(_loc9_ < AtouinConstants.CELL_WIDTH)
               {
                  _loc9_ = AtouinConstants.CELL_WIDTH;
               }
               _loc7_ = Cell.cellPixelCoords(_loc25_.cellId);
               _loc16_.left = _loc7_.x + _loc13_ + _loc11_ - AtouinConstants.CELL_HALF_WIDTH;
               _loc16_.top = _loc7_.y + _loc14_ - _loc19_ - _loc8_;
               _loc16_.width = _loc9_;
               _loc16_.height = _loc8_ + AtouinConstants.CELL_HEIGHT * 2;
               if(!_loc17_[_loc25_.cellId])
               {
                  _loc17_[_loc25_.cellId] = 
                     {
                        "r":_loc16_.clone(),
                        "gfx":_loc18_
                     };
               }
               else
               {
                  _loc17_[_loc25_.cellId].r = _loc17_[_loc25_.cellId].r.union(_loc16_);
                  _loc17_[_loc25_.cellId].gfx = _loc17_[_loc25_.cellId].gfx.concat(_loc18_);
               }
            }
         }
         _loc18_ = new Array();
         _loc10_ = 0;
         while(_loc10_ < _loc17_.length)
         {
            if(_loc17_[_loc10_])
            {
               _loc16_ = _loc17_[_loc10_].r;
               if((_loc16_) && _loc16_.intersects(_loc15_) == param1)
               {
                  _loc6_.cell[_loc10_] = true;
                  _loc28_ = 0;
                  while(_loc28_ < _loc17_[_loc10_].gfx.length)
                  {
                     _loc18_[_loc17_[_loc10_].gfx[_loc28_]] = true;
                     _loc28_++;
                  }
               }
            }
            _loc10_++;
         }
         for (_loc24_ in _loc18_)
         {
            _loc6_.gfx.push(_loc24_);
         }
         return _loc6_;
      }
   }
}
