package flashx.textLayout.utils
{
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.compose.TextFlowLine;
   import flash.text.engine.TextLine;
   import flash.geom.Rectangle;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public final class GeometryUtil extends Object
   {
      
      public function GeometryUtil() {
         super();
      }
      
      public static function getHighlightBounds(param1:TextRange) : Array {
         var _loc7_:TextFlowLine = null;
         var _loc11_:Array = null;
         var _loc12_:TextLine = null;
         var _loc13_:Rectangle = null;
         var _loc14_:TextFlowLine = null;
         var _loc15_:Object = null;
         var _loc2_:IFlowComposer = param1.textFlow.flowComposer;
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:Array = new Array();
         var _loc4_:int = _loc2_.findLineIndexAtPosition(param1.absoluteStart);
         var _loc5_:int = param1.absoluteStart == param1.absoluteEnd?_loc4_:_loc2_.findLineIndexAtPosition(param1.absoluteEnd);
         if(_loc5_ >= _loc2_.numLines)
         {
            _loc5_ = _loc2_.numLines-1;
         }
         var _loc6_:TextFlowLine = _loc4_ > 0?_loc2_.getLineAt(_loc4_-1):null;
         var _loc8_:TextFlowLine = _loc2_.getLineAt(_loc4_);
         var _loc9_:Array = [];
         var _loc10_:int = _loc4_;
         while(_loc10_ <= _loc5_)
         {
            _loc7_ = _loc10_ != _loc2_.numLines-1?_loc2_.getLineAt(_loc10_ + 1):null;
            _loc11_ = _loc8_.getRomanSelectionHeightAndVerticalAdjustment(_loc6_,_loc7_);
            _loc12_ = _loc8_.getTextLine(true);
            _loc8_.calculateSelectionBounds(_loc12_,_loc9_,param1.absoluteStart < _loc8_.absoluteStart?_loc8_.absoluteStart - _loc8_.paragraph.getAbsoluteStart():param1.absoluteStart - _loc8_.paragraph.getAbsoluteStart(),param1.absoluteEnd > _loc8_.absoluteStart + _loc8_.textLength?_loc8_.absoluteStart + _loc8_.textLength - _loc8_.paragraph.getAbsoluteStart():param1.absoluteEnd - _loc8_.paragraph.getAbsoluteStart(),param1.textFlow.computedFormat.blockProgression,_loc11_);
            for each (_loc13_ in _loc9_)
            {
               _loc15_ = new Object();
               _loc15_.textLine = _loc12_;
               _loc15_.rect = _loc13_.clone();
               _loc3_.push(_loc15_);
            }
            _loc9_.length = 0;
            _loc14_ = _loc8_;
            _loc8_ = _loc7_;
            _loc6_ = _loc14_;
            _loc10_++;
         }
         return _loc3_;
      }
   }
}
