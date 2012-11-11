package flashx.textLayout.utils
{
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.elements.*;

    final public class GeometryUtil extends Object
    {

        public function GeometryUtil()
        {
            return;
        }// end function

        public static function getHighlightBounds(param1:TextRange) : Array
        {
            var _loc_7:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_2:* = param1.textFlow.flowComposer;
            if (!_loc_2)
            {
                return null;
            }
            var _loc_3:* = new Array();
            var _loc_4:* = _loc_2.findLineIndexAtPosition(param1.absoluteStart);
            var _loc_5:* = param1.absoluteStart == param1.absoluteEnd ? (_loc_4) : (_loc_2.findLineIndexAtPosition(param1.absoluteEnd));
            if ((param1.absoluteStart == param1.absoluteEnd ? (_loc_4) : (_loc_2.findLineIndexAtPosition(param1.absoluteEnd))) >= _loc_2.numLines)
            {
                _loc_5 = _loc_2.numLines - 1;
            }
            var _loc_6:* = _loc_4 > 0 ? (_loc_2.getLineAt((_loc_4 - 1))) : (null);
            var _loc_8:* = _loc_2.getLineAt(_loc_4);
            var _loc_9:* = [];
            var _loc_10:* = _loc_4;
            while (_loc_10 <= _loc_5)
            {
                
                _loc_7 = _loc_10 != (_loc_2.numLines - 1) ? (_loc_2.getLineAt((_loc_10 + 1))) : (null);
                _loc_11 = _loc_8.getRomanSelectionHeightAndVerticalAdjustment(_loc_6, _loc_7);
                _loc_12 = _loc_8.getTextLine(true);
                _loc_8.calculateSelectionBounds(_loc_12, _loc_9, param1.absoluteStart < _loc_8.absoluteStart ? (_loc_8.absoluteStart - _loc_8.paragraph.getAbsoluteStart()) : (param1.absoluteStart - _loc_8.paragraph.getAbsoluteStart()), param1.absoluteEnd > _loc_8.absoluteStart + _loc_8.textLength ? (_loc_8.absoluteStart + _loc_8.textLength - _loc_8.paragraph.getAbsoluteStart()) : (param1.absoluteEnd - _loc_8.paragraph.getAbsoluteStart()), param1.textFlow.computedFormat.blockProgression, _loc_11);
                for each (_loc_13 in _loc_9)
                {
                    
                    _loc_15 = new Object();
                    _loc_15.textLine = _loc_12;
                    _loc_15.rect = _loc_13.clone();
                    _loc_3.push(_loc_15);
                }
                _loc_9.length = 0;
                _loc_14 = _loc_8;
                _loc_8 = _loc_7;
                _loc_6 = _loc_14;
                _loc_10++;
            }
            return _loc_3;
        }// end function

    }
}
