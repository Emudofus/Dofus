package flashx.textLayout.elements
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;

    public class BackgroundManager extends Object
    {
        protected var _lineDict:Dictionary;

        public function BackgroundManager()
        {
            this._lineDict = new Dictionary(true);
            return;
        }// end function

        public function addRect(param1:TextLine, param2:FlowLeafElement, param3:Rectangle, param4:uint, param5:Number) : void
        {
            var _loc_10:* = null;
            var _loc_6:* = this._lineDict[param1];
            if (this._lineDict[param1] == null)
            {
                var _loc_11:* = new Array();
                this._lineDict[param1] = new Array();
                _loc_6 = _loc_11;
            }
            var _loc_7:* = new Object();
            new Object().rect = param3;
            _loc_7.fle = param2;
            _loc_7.color = param4;
            _loc_7.alpha = param5;
            var _loc_8:* = param2.getAbsoluteStart();
            var _loc_9:* = 0;
            while (_loc_9 < _loc_6.length)
            {
                
                _loc_10 = _loc_6[_loc_9];
                if (_loc_10.hasOwnProperty("fle") && _loc_10.fle.getAbsoluteStart() == _loc_8)
                {
                    _loc_6[_loc_9] = _loc_7;
                    return;
                }
                _loc_9++;
            }
            _loc_6.push(_loc_7);
            return;
        }// end function

        public function addNumberLine(param1:TextLine, param2:TextLine) : void
        {
            var _loc_3:* = this._lineDict[param1];
            if (_loc_3 == null)
            {
                var _loc_4:* = new Array();
                this._lineDict[param1] = new Array();
                _loc_3 = _loc_4;
            }
            _loc_3.push({numberLine:param2});
            return;
        }// end function

        public function finalizeLine(param1:TextFlowLine) : void
        {
            return;
        }// end function

        function getEntry(param1:TextLine)
        {
            return this._lineDict ? (this._lineDict[param1]) : (undefined);
        }// end function

        public function drawAllRects(param1:TextFlow, param2:Shape, param3:Number, param4:Number) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            for (_loc_5 in this._lineDict)
            {
                
                _loc_6 = this._lineDict[_loc_5];
                if (_loc_6.length)
                {
                    _loc_7 = _loc_6[0].columnRect;
                    _loc_10 = 0;
                    while (_loc_10 < _loc_6.length)
                    {
                        
                        _loc_9 = _loc_6[_loc_10];
                        if (_loc_9.hasOwnProperty("numberLine"))
                        {
                            _loc_11 = _loc_9.numberLine;
                            _loc_12 = TextFlowLine.getNumberLineBackground(_loc_11);
                            _loc_13 = _loc_12._lineDict[_loc_11];
                            _loc_14 = 0;
                            while (_loc_14 < _loc_13.length)
                            {
                                
                                _loc_15 = _loc_13[_loc_14];
                                _loc_8 = _loc_15.rect;
                                _loc_15.rect.x = _loc_8.x + (_loc_5.x + _loc_11.x);
                                _loc_8.y = _loc_8.y + (_loc_5.y + _loc_11.y);
                                TextFlowLine.constrainRectToColumn(param1, _loc_8, _loc_7, 0, 0, param3, param4);
                                param2.graphics.beginFill(_loc_15.color, _loc_15.alpha);
                                param2.graphics.drawRect(_loc_8.x, _loc_8.y, _loc_8.width, _loc_8.height);
                                param2.graphics.endFill();
                                _loc_14++;
                            }
                        }
                        else
                        {
                            _loc_8 = _loc_9.rect;
                            _loc_9.rect.x = _loc_8.x + _loc_5.x;
                            _loc_8.y = _loc_8.y + _loc_5.y;
                            TextFlowLine.constrainRectToColumn(param1, _loc_8, _loc_7, 0, 0, param3, param4);
                            param2.graphics.beginFill(_loc_9.color, _loc_9.alpha);
                            param2.graphics.drawRect(_loc_8.x, _loc_8.y, _loc_8.width, _loc_8.height);
                            param2.graphics.endFill();
                        }
                        _loc_10++;
                    }
                }
            }
            return;
        }// end function

        public function removeLineFromCache(param1:TextLine) : void
        {
            delete this._lineDict[param1];
            return;
        }// end function

        public function onUpdateComplete(param1:ContainerController) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_2:* = param1.container;
            if (_loc_2 && _loc_2.numChildren)
            {
                _loc_3 = param1.getBackgroundShape();
                _loc_3.graphics.clear();
                _loc_4 = 0;
                while (_loc_4 < param1.textLines.length)
                {
                    
                    _loc_5 = param1.textLines[_loc_4];
                    _loc_6 = this._lineDict[_loc_5];
                    if (_loc_6)
                    {
                        _loc_8 = _loc_5.userData as TextFlowLine;
                        _loc_9 = 0;
                        while (_loc_9 < _loc_6.length)
                        {
                            
                            _loc_10 = _loc_6[_loc_9];
                            if (_loc_10.hasOwnProperty("numberLine"))
                            {
                                _loc_11 = _loc_10.numberLine;
                                _loc_12 = TextFlowLine.getNumberLineBackground(_loc_11);
                                _loc_13 = _loc_12._lineDict[_loc_11];
                                _loc_14 = 0;
                                while (_loc_14 < _loc_13.length)
                                {
                                    
                                    _loc_15 = _loc_13[_loc_14];
                                    _loc_7 = _loc_15.rect.clone();
                                    _loc_15.rect.clone().x = _loc_7.x + _loc_11.x;
                                    _loc_7.y = _loc_7.y + _loc_11.y;
                                    _loc_8.convertLineRectToContainer(_loc_7, true);
                                    _loc_3.graphics.beginFill(_loc_15.color, _loc_15.alpha);
                                    _loc_3.graphics.drawRect(_loc_7.x, _loc_7.y, _loc_7.width, _loc_7.height);
                                    _loc_3.graphics.endFill();
                                    _loc_14++;
                                }
                            }
                            else
                            {
                                _loc_7 = _loc_10.rect.clone();
                                _loc_8.convertLineRectToContainer(_loc_7, true);
                                _loc_3.graphics.beginFill(_loc_10.color, _loc_10.alpha);
                                _loc_3.graphics.drawRect(_loc_7.x, _loc_7.y, _loc_7.width, _loc_7.height);
                                _loc_3.graphics.endFill();
                            }
                            _loc_9++;
                        }
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

    }
}
