package flashx.textLayout.utils
{
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    final public class NavigationUtil extends Object
    {

        public function NavigationUtil()
        {
            return;
        }// end function

        private static function validateTextRange(param1:TextRange) : Boolean
        {
            return param1.textFlow != null && param1.anchorPosition != -1 && param1.activePosition != -1;
        }// end function

        private static function doIncrement(param1:TextFlow, param2:int, param3:Function) : int
        {
            var _loc_4:* = param1.findAbsoluteParagraph(param2);
            return NavigationUtil.param3(param1, _loc_4, param2, _loc_4.getAbsoluteStart());
        }// end function

        private static function previousAtomHelper(param1:TextFlow, param2:ParagraphElement, param3:int, param4:int) : int
        {
            if (param3 - param4 == 0)
            {
                return param3 > 0 ? ((param3 - 1)) : (0);
            }
            return param2.findPreviousAtomBoundary(param3 - param4) + param4;
        }// end function

        public static function previousAtomPosition(param1:TextFlow, param2:int) : int
        {
            return doIncrement(param1, param2, previousAtomHelper);
        }// end function

        private static function nextAtomHelper(param1:TextFlow, param2:ParagraphElement, param3:int, param4:int) : int
        {
            if (param3 - param4 == (param2.textLength - 1))
            {
                return Math.min(param1.textLength, (param3 + 1));
            }
            return param2.findNextAtomBoundary(param3 - param4) + param4;
        }// end function

        public static function nextAtomPosition(param1:TextFlow, param2:int) : int
        {
            return doIncrement(param1, param2, nextAtomHelper);
        }// end function

        public static function previousWordPosition(param1:TextFlow, param2:int) : int
        {
            if (isOverset(param1, param2))
            {
                return endOfLastController(param1);
            }
            var _loc_3:* = param1.findAbsoluteParagraph(param2);
            var _loc_4:* = _loc_3.getAbsoluteStart();
            var _loc_5:* = param2 - _loc_4;
            var _loc_6:* = 0;
            if (param2 - _loc_4 == 0)
            {
                return param2 > 0 ? ((param2 - 1)) : (0);
            }
            do
            {
                
                _loc_6 = _loc_3.findPreviousWordBoundary(_loc_5);
                if (_loc_5 == _loc_6)
                {
                    _loc_5 = _loc_3.findPreviousWordBoundary((_loc_5 - 1));
                    continue;
                }
                _loc_5 = _loc_6;
            }while (_loc_5 > 0 && CharacterUtil.isWhitespace(_loc_3.getCharCodeAtPosition(_loc_5)))
            return _loc_5 + _loc_4;
        }// end function

        public static function nextWordPosition(param1:TextFlow, param2:int) : int
        {
            var _loc_3:* = param1.findAbsoluteParagraph(param2);
            var _loc_4:* = _loc_3.getAbsoluteStart();
            var _loc_5:* = param2 - _loc_4;
            if (param2 - _loc_4 == (_loc_3.textLength - 1))
            {
                return Math.min(param1.textLength, (param2 + 1));
            }
            do
            {
                
                _loc_5 = _loc_3.findNextWordBoundary(_loc_5);
            }while (_loc_5 < (_loc_3.textLength - 1) && CharacterUtil.isWhitespace(_loc_3.getCharCodeAtPosition(_loc_5)))
            return _loc_5 + _loc_4;
        }// end function

        static function updateStartIfInReadOnlyElement(param1:TextFlow, param2:int) : int
        {
            return param2;
        }// end function

        static function updateEndIfInReadOnlyElement(param1:TextFlow, param2:int) : int
        {
            return param2;
        }// end function

        private static function moveForwardHelper(param1:TextRange, param2:Boolean, param3:Function) : Boolean
        {
            var _loc_4:* = param1.textFlow;
            var _loc_5:* = param1.anchorPosition;
            var _loc_6:* = param1.activePosition;
            if (param2)
            {
                _loc_6 = NavigationUtil.param3(_loc_4, _loc_6);
            }
            else if (_loc_5 == _loc_6)
            {
                _loc_5 = NavigationUtil.param3(_loc_4, _loc_5);
                _loc_6 = _loc_5;
            }
            else if (_loc_6 > _loc_5)
            {
                _loc_5 = _loc_6;
            }
            else
            {
                _loc_6 = _loc_5;
            }
            if (_loc_5 == _loc_6)
            {
                _loc_5 = updateStartIfInReadOnlyElement(_loc_4, _loc_5);
                _loc_6 = updateEndIfInReadOnlyElement(_loc_4, _loc_6);
            }
            else
            {
                _loc_6 = updateEndIfInReadOnlyElement(_loc_4, _loc_6);
            }
            if (!param2 && param1.anchorPosition == _loc_5 && param1.activePosition == _loc_6)
            {
                if (_loc_5 < _loc_6)
                {
                    _loc_5 = Math.min((_loc_6 + 1), (_loc_4.textLength - 1));
                    _loc_6 = _loc_5;
                }
                else
                {
                    _loc_6 = Math.min((_loc_5 + 1), (_loc_4.textLength - 1));
                    _loc_5 = _loc_6;
                }
            }
            return param1.updateRange(_loc_5, _loc_6);
        }// end function

        private static function moveBackwardHelper(param1:TextRange, param2:Boolean, param3:Function) : Boolean
        {
            var _loc_4:* = param1.textFlow;
            var _loc_5:* = param1.anchorPosition;
            var _loc_6:* = param1.activePosition;
            if (param2)
            {
                _loc_6 = NavigationUtil.param3(_loc_4, _loc_6);
            }
            else if (_loc_5 == _loc_6)
            {
                _loc_5 = NavigationUtil.param3(_loc_4, _loc_5);
                _loc_6 = _loc_5;
            }
            else if (_loc_6 > _loc_5)
            {
                _loc_6 = _loc_5;
            }
            else
            {
                _loc_5 = _loc_6;
            }
            if (_loc_5 == _loc_6)
            {
                _loc_5 = updateEndIfInReadOnlyElement(_loc_4, _loc_5);
                _loc_6 = updateStartIfInReadOnlyElement(_loc_4, _loc_6);
            }
            else
            {
                _loc_6 = updateStartIfInReadOnlyElement(_loc_4, _loc_6);
            }
            if (!param2 && param1.anchorPosition == _loc_5 && param1.activePosition == _loc_6)
            {
                if (_loc_5 < _loc_6)
                {
                    _loc_6 = Math.max((_loc_5 - 1), 0);
                    _loc_5 = _loc_6;
                }
                else
                {
                    _loc_5 = Math.max((_loc_6 - 1), 0);
                    _loc_6 = _loc_5;
                }
            }
            return param1.updateRange(_loc_5, _loc_6);
        }// end function

        public static function nextCharacter(param1:TextRange, param2:Boolean = false) : Boolean
        {
            if (validateTextRange(param1))
            {
                if (!adjustForOversetForward(param1))
                {
                    moveForwardHelper(param1, param2, nextAtomPosition);
                }
                return true;
            }
            return false;
        }// end function

        public static function previousCharacter(param1:TextRange, param2:Boolean = false) : Boolean
        {
            if (validateTextRange(param1))
            {
                if (!adjustForOversetBack(param1))
                {
                    moveBackwardHelper(param1, param2, previousAtomPosition);
                }
                return true;
            }
            return false;
        }// end function

        public static function nextWord(param1:TextRange, param2:Boolean = false) : Boolean
        {
            if (validateTextRange(param1))
            {
                if (!adjustForOversetForward(param1))
                {
                    moveForwardHelper(param1, param2, nextWordPosition);
                }
                return true;
            }
            return false;
        }// end function

        public static function previousWord(param1:TextRange, param2:Boolean = false) : Boolean
        {
            if (validateTextRange(param1))
            {
                if (!adjustForOversetBack(param1))
                {
                    moveBackwardHelper(param1, param2, previousWordPosition);
                }
                return true;
            }
            return false;
        }// end function

        static function computeEndIdx(param1:TextFlowLine, param2:TextFlowLine, param3:String, param4:Boolean, param5:Point) : int
        {
            var _loc_6:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = false;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_7:* = param1.getTextLine(true);
            var _loc_8:* = param2.getTextLine(true);
            var _loc_9:* = param2.getTextLine(true).getAtomBidiLevel(_loc_10) % 2 != 0;
            if (param1.controller == param2.controller)
            {
                if (param3 != BlockProgression.RL)
                {
                    param5.y = param5.y - (_loc_8.y - _loc_7.y);
                }
                else
                {
                    param5.x = param5.x + (_loc_7.x - _loc_8.x);
                }
            }
            else
            {
                _loc_11 = _loc_7.getAtomBounds(0);
                _loc_12 = new Point();
                _loc_12.x = _loc_11.left;
                _loc_12.y = 0;
                _loc_12 = _loc_7.localToGlobal(_loc_12);
                if (param3 != BlockProgression.RL)
                {
                    param5.x = param5.x - param2.controller.container.x;
                    param5.y = _loc_12.y;
                }
                else
                {
                    param5.x = _loc_12.x;
                    param5.y = param5.y - param2.controller.container.y;
                }
            }
            _loc_10 = _loc_7.getAtomIndexAtPoint(param5.x, param5.y);
            if (_loc_10 == -1)
            {
                if (param3 != BlockProgression.RL)
                {
                    if (!_loc_9)
                    {
                        _loc_6 = param5.x <= _loc_7.x ? (param1.absoluteStart) : (param1.absoluteStart + param1.textLength - 1);
                    }
                    else
                    {
                        _loc_6 = param5.x <= _loc_7.x ? (param1.absoluteStart + param1.textLength - 1) : (param1.absoluteStart);
                    }
                }
                else if (!_loc_9)
                {
                    _loc_6 = param5.y <= _loc_7.y ? (param1.absoluteStart) : (param1.absoluteStart + param1.textLength - 1);
                }
                else
                {
                    _loc_6 = param5.y <= _loc_7.y ? (param1.absoluteStart + param1.textLength - 1) : (param1.absoluteStart);
                }
            }
            else
            {
                _loc_13 = _loc_7.getAtomBounds(_loc_10);
                _loc_14 = false;
                if (_loc_13)
                {
                    _loc_16 = new Point();
                    _loc_16.x = _loc_13.x;
                    _loc_16.y = _loc_13.y;
                    _loc_16 = _loc_7.localToGlobal(_loc_16);
                    if (param3 == BlockProgression.RL && _loc_7.getAtomTextRotation(_loc_10) != TextRotation.ROTATE_0)
                    {
                        _loc_14 = param5.y > _loc_16.y + _loc_13.height / 2;
                    }
                    else
                    {
                        _loc_14 = param5.x > _loc_16.x + _loc_13.width / 2;
                    }
                }
                if (_loc_7.getAtomBidiLevel(_loc_10) % 2 != 0)
                {
                    _loc_15 = _loc_14 ? (_loc_7.getAtomTextBlockBeginIndex(_loc_10)) : (_loc_7.getAtomTextBlockEndIndex(_loc_10));
                }
                else if (param4)
                {
                    if (_loc_14 == false && _loc_10 > 0)
                    {
                        _loc_15 = _loc_7.getAtomTextBlockBeginIndex((_loc_10 - 1));
                    }
                    else
                    {
                        _loc_15 = _loc_7.getAtomTextBlockBeginIndex(_loc_10);
                    }
                }
                else
                {
                    _loc_15 = _loc_14 ? (_loc_7.getAtomTextBlockEndIndex(_loc_10)) : (_loc_7.getAtomTextBlockBeginIndex(_loc_10));
                }
                _loc_6 = param1.paragraph.getAbsoluteStart() + _loc_15;
            }
            return _loc_6;
        }// end function

        public static function nextLine(param1:TextRange, param2:Boolean = false) : Boolean
        {
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = false;
            var _loc_17:* = null;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = NaN;
            if (!validateTextRange(param1))
            {
                return false;
            }
            if (adjustForOversetForward(param1))
            {
                return true;
            }
            var _loc_3:* = param1.textFlow;
            var _loc_4:* = _loc_3.computedFormat.blockProgression;
            var _loc_5:* = param1.anchorPosition;
            var _loc_6:* = param1.activePosition;
            var _loc_7:* = endOfLastController(_loc_3);
            var _loc_8:* = _loc_3.flowComposer.findLineIndexAtPosition(_loc_6);
            var _loc_9:* = _loc_3.computedFormat.direction == Direction.RTL;
            if (_loc_8 < (_loc_3.flowComposer.numLines - 1))
            {
                _loc_10 = _loc_3.flowComposer.getLineAt(_loc_8);
                _loc_11 = _loc_10.absoluteStart;
                _loc_12 = _loc_6 - _loc_11;
                _loc_13 = _loc_10.getTextLine(true);
                _loc_14 = _loc_10.paragraph;
                _loc_15 = _loc_13.getAtomIndexAtCharIndex(_loc_6 - _loc_14.getAbsoluteStart());
                _loc_16 = _loc_13.getAtomBidiLevel(_loc_15) % 2 != 0;
                _loc_17 = _loc_13.getAtomBounds(_loc_15);
                _loc_18 = _loc_13.x;
                _loc_19 = _loc_17.left;
                _loc_20 = _loc_17.right;
                if (_loc_4 == BlockProgression.RL)
                {
                    _loc_18 = _loc_13.y;
                    _loc_19 = _loc_17.top;
                    _loc_20 = _loc_17.bottom;
                }
                _loc_21 = new Point();
                if (_loc_4 != BlockProgression.RL)
                {
                    if (!_loc_9)
                    {
                        _loc_21.x = _loc_17.left;
                    }
                    else
                    {
                        _loc_21.x = _loc_17.right;
                    }
                    _loc_21.y = 0;
                }
                else
                {
                    _loc_21.x = 0;
                    if (!_loc_9)
                    {
                        _loc_21.y = _loc_17.top;
                    }
                    else
                    {
                        _loc_21.y = _loc_17.bottom;
                    }
                }
                _loc_21 = _loc_13.localToGlobal(_loc_21);
                _loc_22 = _loc_3.flowComposer.getLineAt((_loc_8 + 1));
                if (_loc_22.absoluteStart >= _loc_7)
                {
                    if (!param2)
                    {
                        param1.anchorPosition = _loc_3.textLength - 1;
                        param1.activePosition = _loc_3.textLength - 1;
                    }
                    else
                    {
                        param1.activePosition = _loc_3.textLength;
                    }
                    return true;
                }
                _loc_23 = _loc_3.flowComposer.getControllerAt((_loc_3.flowComposer.numControllers - 1));
                _loc_24 = _loc_23.absoluteStart;
                _loc_25 = _loc_24 + _loc_23.textLength;
                if (_loc_22.absoluteStart >= _loc_24 && _loc_22.absoluteStart < _loc_25)
                {
                    if (_loc_22.isDamaged())
                    {
                        _loc_3.flowComposer.composeToPosition((_loc_22.absoluteStart + 1));
                        _loc_22 = _loc_3.flowComposer.getLineAt((_loc_8 + 1));
                        if (_loc_22.isDamaged())
                        {
                            return false;
                        }
                    }
                    _loc_26 = _loc_4 == BlockProgression.TB ? (_loc_23.horizontalScrollPosition) : (_loc_23.verticalScrollPosition);
                    _loc_23.scrollToRange(_loc_22.absoluteStart, _loc_22.absoluteStart + _loc_22.textLength - 1);
                    if (_loc_4 == BlockProgression.TB)
                    {
                        _loc_23.horizontalScrollPosition = _loc_26;
                    }
                    else
                    {
                        _loc_23.verticalScrollPosition = _loc_26;
                    }
                }
                _loc_6 = computeEndIdx(_loc_22, _loc_10, _loc_4, _loc_9, _loc_21);
                if (_loc_6 >= _loc_3.textLength)
                {
                    _loc_6 = _loc_3.textLength;
                }
            }
            else
            {
                _loc_6 = _loc_3.textLength;
            }
            if (!param2)
            {
                _loc_5 = _loc_6;
            }
            if (_loc_5 == _loc_6)
            {
                _loc_5 = updateStartIfInReadOnlyElement(_loc_3, _loc_5);
                _loc_6 = updateEndIfInReadOnlyElement(_loc_3, _loc_6);
            }
            else
            {
                _loc_6 = updateEndIfInReadOnlyElement(_loc_3, _loc_6);
            }
            return param1.updateRange(_loc_5, _loc_6);
        }// end function

        public static function previousLine(param1:TextRange, param2:Boolean = false) : Boolean
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = NaN;
            if (!validateTextRange(param1))
            {
                return false;
            }
            if (adjustForOversetBack(param1))
            {
                return true;
            }
            var _loc_3:* = param1.textFlow;
            var _loc_4:* = _loc_3.computedFormat.blockProgression;
            var _loc_5:* = param1.anchorPosition;
            var _loc_6:* = param1.activePosition;
            var _loc_7:* = _loc_3.flowComposer.findLineIndexAtPosition(_loc_6);
            var _loc_8:* = _loc_3.computedFormat.direction == Direction.RTL;
            if (_loc_7 > 0)
            {
                _loc_9 = _loc_3.flowComposer.getLineAt(_loc_7);
                _loc_10 = _loc_9.absoluteStart;
                _loc_11 = _loc_6 - _loc_10;
                _loc_12 = _loc_9.getTextLine(true);
                _loc_13 = _loc_9.paragraph;
                _loc_14 = _loc_12.getAtomIndexAtCharIndex(_loc_6 - _loc_13.getAbsoluteStart());
                _loc_15 = _loc_12.getAtomBounds(_loc_14);
                _loc_16 = _loc_12.x;
                _loc_17 = _loc_15.left;
                _loc_18 = _loc_15.right;
                if (_loc_4 == BlockProgression.RL)
                {
                    _loc_16 = _loc_12.y;
                    _loc_17 = _loc_15.top;
                    _loc_18 = _loc_15.bottom;
                }
                _loc_19 = new Point();
                if (_loc_4 != BlockProgression.RL)
                {
                    if (!_loc_8)
                    {
                        _loc_19.x = _loc_15.left;
                    }
                    else
                    {
                        _loc_19.x = _loc_15.right;
                    }
                    _loc_19.y = 0;
                }
                else
                {
                    _loc_19.x = 0;
                    if (!_loc_8)
                    {
                        _loc_19.y = _loc_15.top;
                    }
                    else
                    {
                        _loc_19.y = _loc_15.bottom;
                    }
                }
                _loc_19 = _loc_12.localToGlobal(_loc_19);
                _loc_20 = _loc_3.flowComposer.getLineAt((_loc_7 - 1));
                _loc_21 = _loc_3.flowComposer.getControllerAt((_loc_3.flowComposer.numControllers - 1));
                _loc_22 = _loc_21.absoluteStart;
                _loc_23 = _loc_22 + _loc_21.textLength;
                if (_loc_20.absoluteStart >= _loc_22 && _loc_20.absoluteStart < _loc_23)
                {
                    _loc_24 = _loc_4 == BlockProgression.TB ? (_loc_21.horizontalScrollPosition) : (_loc_21.verticalScrollPosition);
                    _loc_21.scrollToRange(_loc_20.absoluteStart, _loc_20.absoluteStart + _loc_20.textLength - 1);
                    if (_loc_4 == BlockProgression.TB)
                    {
                        _loc_21.horizontalScrollPosition = _loc_24;
                    }
                    else
                    {
                        _loc_21.verticalScrollPosition = _loc_24;
                    }
                }
                _loc_6 = computeEndIdx(_loc_20, _loc_9, _loc_4, _loc_8, _loc_19);
            }
            else
            {
                _loc_6 = 0;
            }
            if (!param2)
            {
                _loc_5 = _loc_6;
            }
            if (_loc_5 == _loc_6)
            {
                _loc_5 = updateStartIfInReadOnlyElement(_loc_3, _loc_5);
                _loc_6 = updateEndIfInReadOnlyElement(_loc_3, _loc_6);
            }
            else
            {
                _loc_6 = updateEndIfInReadOnlyElement(_loc_3, _loc_6);
            }
            return param1.updateRange(_loc_5, _loc_6);
        }// end function

        public static function nextPage(param1:TextRange, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = null;
            var _loc_12:* = 0;
            var _loc_15:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            if (!validateTextRange(param1))
            {
                return false;
            }
            var _loc_4:* = param1.textFlow;
            var _loc_5:* = param1.textFlow.flowComposer.findControllerIndexAtPosition(param1.activePosition);
            if (param1.textFlow.flowComposer.findControllerIndexAtPosition(param1.activePosition) != (_loc_4.flowComposer.numControllers - 1))
            {
                param1.activePosition = _loc_4.flowComposer.getControllerAt((_loc_5 + 1)).absoluteStart;
                if (!param2)
                {
                    param1.anchorPosition = param1.activePosition;
                }
                return true;
            }
            if (!isScrollable(_loc_4, param1.activePosition))
            {
                return false;
            }
            if (adjustForOversetForward(param1))
            {
                return true;
            }
            var _loc_6:* = param1.absoluteStart;
            var _loc_7:* = param1.absoluteEnd;
            var _loc_8:* = _loc_4.flowComposer.findLineIndexAtPosition(_loc_7);
            var _loc_9:* = _loc_4.flowComposer.getLineAt(_loc_8);
            var _loc_10:* = _loc_4.flowComposer.getLineAt(_loc_8).absoluteStart;
            var _loc_11:* = _loc_7 - _loc_10;
            var _loc_13:* = _loc_9;
            var _loc_14:* = _loc_4.computedFormat.blockProgression == BlockProgression.RL;
            _loc_3 = _loc_4.flowComposer.getControllerAt((_loc_4.flowComposer.numControllers - 1));
            if (_loc_14)
            {
                _loc_15 = _loc_3.compositionWidth * _loc_4.configuration.scrollPagePercentage;
            }
            else
            {
                _loc_15 = _loc_3.compositionHeight * _loc_4.configuration.scrollPagePercentage;
            }
            if (_loc_14)
            {
                _loc_17 = _loc_3.contentWidth;
                if (_loc_3.horizontalScrollPosition - _loc_15 < -_loc_17)
                {
                    _loc_3.horizontalScrollPosition = -_loc_17;
                    _loc_12 = _loc_4.flowComposer.numLines - 1;
                    _loc_13 = _loc_4.flowComposer.getLineAt(_loc_12);
                }
                else
                {
                    _loc_18 = _loc_3.horizontalScrollPosition;
                    _loc_3.horizontalScrollPosition = _loc_3.horizontalScrollPosition - _loc_15;
                    _loc_19 = _loc_3.horizontalScrollPosition;
                    if (_loc_18 == _loc_19)
                    {
                        _loc_12 = _loc_4.flowComposer.numLines - 1;
                        _loc_13 = _loc_4.flowComposer.getLineAt(_loc_12);
                    }
                    else
                    {
                        _loc_12 = _loc_8;
                        while (_loc_12 < (_loc_4.flowComposer.numLines - 1))
                        {
                            
                            _loc_12++;
                            _loc_13 = _loc_4.flowComposer.getLineAt(_loc_12);
                            if (_loc_9.x - _loc_13.x >= _loc_18 - _loc_19)
                            {
                                break;
                            }
                        }
                    }
                }
            }
            else
            {
                _loc_20 = _loc_3.contentHeight;
                if (_loc_3.verticalScrollPosition + _loc_15 > _loc_20)
                {
                    _loc_3.verticalScrollPosition = _loc_20;
                    _loc_12 = _loc_4.flowComposer.numLines - 1;
                    _loc_13 = _loc_4.flowComposer.getLineAt(_loc_12);
                }
                else
                {
                    _loc_21 = _loc_3.verticalScrollPosition;
                    _loc_3.verticalScrollPosition = _loc_3.verticalScrollPosition + _loc_15;
                    _loc_22 = _loc_3.verticalScrollPosition;
                    if (_loc_22 == _loc_21)
                    {
                        _loc_12 = _loc_4.flowComposer.numLines - 1;
                        _loc_13 = _loc_4.flowComposer.getLineAt(_loc_12);
                    }
                    else
                    {
                        _loc_12 = _loc_8;
                        while (_loc_12 < (_loc_4.flowComposer.numLines - 1))
                        {
                            
                            _loc_12++;
                            _loc_13 = _loc_4.flowComposer.getLineAt(_loc_12);
                            if (_loc_13.y - _loc_9.y >= _loc_22 - _loc_21)
                            {
                                break;
                            }
                        }
                    }
                }
            }
            _loc_7 = _loc_13.absoluteStart + _loc_11;
            var _loc_16:* = _loc_13.absoluteStart + _loc_13.textLength - 1;
            if (_loc_7 > _loc_16)
            {
                _loc_7 = _loc_16;
            }
            if (!param2)
            {
                _loc_6 = _loc_7;
            }
            if (_loc_6 == _loc_7)
            {
                _loc_6 = updateEndIfInReadOnlyElement(_loc_4, _loc_6);
                _loc_7 = updateStartIfInReadOnlyElement(_loc_4, _loc_7);
            }
            else
            {
                _loc_7 = updateStartIfInReadOnlyElement(_loc_4, _loc_7);
            }
            return param1.updateRange(_loc_6, _loc_7);
        }// end function

        public static function previousPage(param1:TextRange, param2:Boolean = false) : Boolean
        {
            var _loc_13:* = 0;
            var _loc_16:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            if (!validateTextRange(param1))
            {
                return false;
            }
            var _loc_3:* = param1.textFlow;
            var _loc_4:* = _loc_3.flowComposer.findControllerIndexAtPosition(param1.activePosition);
            var _loc_5:* = _loc_3.flowComposer.getControllerAt(_loc_4);
            var _loc_6:* = _loc_3.flowComposer.findLineAtPosition(_loc_5.absoluteStart);
            if (param1.activePosition <= _loc_5.absoluteStart + _loc_6.textLength)
            {
                if (_loc_4 == 0)
                {
                    return false;
                }
                param1.activePosition = _loc_3.flowComposer.getControllerAt((_loc_4 - 1)).absoluteStart;
                if (!param2)
                {
                    param1.anchorPosition = param1.activePosition;
                }
                return true;
            }
            if (_loc_4 != (_loc_3.flowComposer.numControllers - 1))
            {
                param1.activePosition = _loc_5.absoluteStart;
                if (!param2)
                {
                    param1.anchorPosition = param1.activePosition;
                }
                return true;
            }
            if (!isScrollable(_loc_3, param1.activePosition))
            {
                return false;
            }
            if (adjustForOversetBack(param1))
            {
                return true;
            }
            var _loc_7:* = param1.absoluteStart;
            var _loc_8:* = param1.absoluteEnd;
            var _loc_9:* = _loc_3.flowComposer.findLineIndexAtPosition(_loc_8);
            var _loc_10:* = _loc_3.flowComposer.getLineAt(_loc_9);
            var _loc_11:* = _loc_3.flowComposer.getLineAt(_loc_9).absoluteStart;
            var _loc_12:* = _loc_8 - _loc_11;
            var _loc_14:* = _loc_10;
            var _loc_15:* = _loc_3.computedFormat.blockProgression == BlockProgression.RL;
            _loc_5 = _loc_3.flowComposer.getControllerAt((_loc_3.flowComposer.numControllers - 1));
            if (_loc_15)
            {
                _loc_16 = _loc_5.compositionWidth * _loc_3.configuration.scrollPagePercentage;
            }
            else
            {
                _loc_16 = _loc_5.compositionHeight * _loc_3.configuration.scrollPagePercentage;
            }
            if (_loc_15)
            {
                if (_loc_5.horizontalScrollPosition + _loc_16 + _loc_5.compositionWidth > 0)
                {
                    _loc_5.horizontalScrollPosition = 0;
                    _loc_13 = _loc_3.flowComposer.findLineIndexAtPosition(_loc_5.absoluteStart);
                    _loc_14 = _loc_3.flowComposer.getLineAt(_loc_13);
                }
                else
                {
                    _loc_18 = _loc_5.horizontalScrollPosition;
                    _loc_5.horizontalScrollPosition = _loc_5.horizontalScrollPosition + _loc_16;
                    _loc_19 = _loc_5.horizontalScrollPosition;
                    if (_loc_18 == _loc_19)
                    {
                        _loc_13 = _loc_3.flowComposer.findLineIndexAtPosition(_loc_5.absoluteStart);
                        _loc_14 = _loc_3.flowComposer.getLineAt(_loc_13);
                    }
                    else
                    {
                        _loc_13 = _loc_9;
                        while (_loc_13 > 0)
                        {
                            
                            _loc_13 = _loc_13 - 1;
                            _loc_14 = _loc_3.flowComposer.getLineAt(_loc_13);
                            if (_loc_14.x - _loc_10.x >= _loc_19 - _loc_18 || _loc_14.absoluteStart < _loc_5.absoluteStart)
                            {
                                break;
                            }
                        }
                    }
                }
            }
            else if (_loc_5.verticalScrollPosition - _loc_16 + _loc_5.compositionHeight < 0)
            {
                _loc_5.verticalScrollPosition = 0;
                _loc_13 = _loc_3.flowComposer.findLineIndexAtPosition(_loc_5.absoluteStart);
                _loc_14 = _loc_3.flowComposer.getLineAt(_loc_13);
            }
            else
            {
                _loc_20 = _loc_5.verticalScrollPosition;
                _loc_5.verticalScrollPosition = _loc_5.verticalScrollPosition - _loc_16;
                _loc_21 = _loc_5.verticalScrollPosition;
                if (_loc_20 == _loc_21)
                {
                    _loc_13 = _loc_3.flowComposer.findLineIndexAtPosition(_loc_5.absoluteStart);
                    _loc_14 = _loc_3.flowComposer.getLineAt(_loc_13);
                }
                else
                {
                    _loc_13 = _loc_9;
                    while (_loc_13 > 0)
                    {
                        
                        _loc_13 = _loc_13 - 1;
                        _loc_14 = _loc_3.flowComposer.getLineAt(_loc_13);
                        if (_loc_10.y - _loc_14.y >= _loc_20 - _loc_21 || _loc_14.absoluteStart < _loc_5.absoluteStart)
                        {
                            break;
                        }
                    }
                }
            }
            _loc_8 = _loc_14.absoluteStart + _loc_12;
            var _loc_17:* = _loc_14.absoluteStart + _loc_14.textLength - 1;
            if (_loc_8 > _loc_17)
            {
                _loc_8 = _loc_17;
            }
            if (!param2)
            {
                _loc_7 = _loc_8;
            }
            if (_loc_7 == _loc_8)
            {
                _loc_7 = updateEndIfInReadOnlyElement(_loc_3, _loc_7);
                _loc_8 = updateStartIfInReadOnlyElement(_loc_3, _loc_8);
            }
            else
            {
                _loc_8 = updateStartIfInReadOnlyElement(_loc_3, _loc_8);
            }
            return param1.updateRange(_loc_7, _loc_8);
        }// end function

        public static function endOfLine(param1:TextRange, param2:Boolean = false) : Boolean
        {
            if (!validateTextRange(param1))
            {
                return false;
            }
            var _loc_3:* = param1.textFlow;
            checkCompose(_loc_3.flowComposer, param1.absoluteEnd);
            var _loc_4:* = param1.anchorPosition;
            var _loc_5:* = param1.activePosition;
            var _loc_6:* = _loc_3.flowComposer.findLineIndexAtPosition(_loc_5);
            var _loc_7:* = _loc_3.flowComposer.getLineAt(_loc_6).absoluteStart;
            var _loc_8:* = _loc_3.flowComposer.getLineAt(_loc_6).absoluteStart + _loc_3.flowComposer.getLineAt(_loc_6).textLength - 1;
            var _loc_9:* = _loc_3.findLeaf(_loc_5);
            var _loc_10:* = _loc_3.findLeaf(_loc_5).getParagraph();
            if (CharacterUtil.isWhitespace(_loc_10.getCharCodeAtPosition(_loc_8 - _loc_10.getAbsoluteStart())))
            {
                _loc_5 = _loc_8;
            }
            else
            {
                _loc_5 = _loc_8 + 1;
            }
            if (!param2)
            {
                _loc_4 = _loc_5;
            }
            if (_loc_4 == _loc_5)
            {
                _loc_4 = updateEndIfInReadOnlyElement(_loc_3, _loc_4);
                _loc_5 = updateStartIfInReadOnlyElement(_loc_3, _loc_5);
            }
            else
            {
                _loc_5 = updateStartIfInReadOnlyElement(_loc_3, _loc_5);
            }
            return param1.updateRange(_loc_4, _loc_5);
        }// end function

        public static function startOfLine(param1:TextRange, param2:Boolean = false) : Boolean
        {
            if (!validateTextRange(param1))
            {
                return false;
            }
            var _loc_3:* = param1.textFlow;
            checkCompose(_loc_3.flowComposer, param1.absoluteEnd);
            var _loc_4:* = param1.anchorPosition;
            var _loc_5:* = param1.activePosition;
            var _loc_6:* = _loc_3.flowComposer.findLineIndexAtPosition(_loc_5);
            var _loc_7:* = _loc_3.flowComposer.getLineAt(_loc_6).absoluteStart;
            _loc_5 = _loc_3.flowComposer.getLineAt(_loc_6).absoluteStart;
            if (!param2)
            {
                _loc_4 = _loc_5;
            }
            if (_loc_4 == _loc_5)
            {
                _loc_4 = updateEndIfInReadOnlyElement(_loc_3, _loc_4);
                _loc_5 = updateStartIfInReadOnlyElement(_loc_3, _loc_5);
            }
            else
            {
                _loc_5 = updateStartIfInReadOnlyElement(_loc_3, _loc_5);
            }
            return param1.updateRange(_loc_4, _loc_5);
        }// end function

        public static function endOfDocument(param1:TextRange, param2:Boolean = false) : Boolean
        {
            if (!validateTextRange(param1))
            {
                return false;
            }
            var _loc_3:* = param1.textFlow;
            var _loc_4:* = param1.anchorPosition;
            var _loc_5:* = param1.activePosition;
            _loc_5 = _loc_3.textLength;
            if (!param2)
            {
                _loc_4 = _loc_5;
            }
            if (_loc_4 == _loc_5)
            {
                _loc_4 = updateEndIfInReadOnlyElement(_loc_3, _loc_4);
                _loc_5 = updateStartIfInReadOnlyElement(_loc_3, _loc_5);
            }
            else
            {
                _loc_5 = updateStartIfInReadOnlyElement(_loc_3, _loc_5);
            }
            return param1.updateRange(_loc_4, _loc_5);
        }// end function

        public static function startOfDocument(param1:TextRange, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = param1.anchorPosition;
            var _loc_4:* = 0;
            if (!param2)
            {
                _loc_3 = _loc_4;
            }
            if (_loc_3 == _loc_4)
            {
                _loc_3 = updateEndIfInReadOnlyElement(param1.textFlow, _loc_3);
                _loc_4 = updateStartIfInReadOnlyElement(param1.textFlow, _loc_4);
            }
            else
            {
                _loc_4 = updateStartIfInReadOnlyElement(param1.textFlow, _loc_4);
            }
            return param1.updateRange(_loc_3, _loc_4);
        }// end function

        public static function startOfParagraph(param1:TextRange, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = param1.anchorPosition;
            var _loc_4:* = param1.activePosition;
            var _loc_5:* = param1.textFlow.findLeaf(_loc_4);
            var _loc_6:* = param1.textFlow.findLeaf(_loc_4).getParagraph();
            _loc_4 = param1.textFlow.findLeaf(_loc_4).getParagraph().getAbsoluteStart();
            if (!param2)
            {
                _loc_3 = _loc_4;
            }
            if (_loc_3 == _loc_4)
            {
                _loc_3 = updateStartIfInReadOnlyElement(param1.textFlow, _loc_3);
                _loc_4 = updateEndIfInReadOnlyElement(param1.textFlow, _loc_4);
            }
            else
            {
                _loc_4 = updateEndIfInReadOnlyElement(param1.textFlow, _loc_4);
            }
            return param1.updateRange(_loc_3, _loc_4);
        }// end function

        public static function endOfParagraph(param1:TextRange, param2:Boolean = false) : Boolean
        {
            if (!validateTextRange(param1))
            {
                return false;
            }
            var _loc_3:* = param1.anchorPosition;
            var _loc_4:* = param1.activePosition;
            var _loc_5:* = param1.textFlow.findLeaf(_loc_4);
            var _loc_6:* = param1.textFlow.findLeaf(_loc_4).getParagraph();
            _loc_4 = param1.textFlow.findLeaf(_loc_4).getParagraph().getAbsoluteStart() + _loc_6.textLength - 1;
            if (!param2)
            {
                _loc_3 = _loc_4;
            }
            if (_loc_3 == _loc_4)
            {
                _loc_3 = updateStartIfInReadOnlyElement(param1.textFlow, _loc_3);
                _loc_4 = updateEndIfInReadOnlyElement(param1.textFlow, _loc_4);
            }
            else
            {
                _loc_4 = updateEndIfInReadOnlyElement(param1.textFlow, _loc_4);
            }
            return param1.updateRange(_loc_3, _loc_4);
        }// end function

        private static function adjustForOversetForward(param1:TextRange) : Boolean
        {
            var _loc_4:* = 0;
            var _loc_2:* = param1.textFlow.flowComposer;
            var _loc_3:* = null;
            checkCompose(_loc_2, param1.absoluteEnd);
            if (param1.absoluteEnd > (_loc_2.damageAbsoluteStart - 1))
            {
                clampToFit(param1, (_loc_2.damageAbsoluteStart - 1));
                return true;
            }
            if (_loc_2 && _loc_2.numControllers)
            {
                _loc_4 = _loc_2.findControllerIndexAtPosition(param1.absoluteEnd);
                if (_loc_4 >= 0)
                {
                    _loc_3 = _loc_2.getControllerAt(_loc_4);
                }
                if (_loc_4 == (_loc_2.numControllers - 1))
                {
                    if (_loc_3.absoluteStart + _loc_3.textLength <= param1.absoluteEnd && _loc_3.absoluteStart + _loc_3.textLength != param1.textFlow.textLength)
                    {
                        _loc_3 = null;
                    }
                }
            }
            if (!_loc_3)
            {
                param1.anchorPosition = param1.textFlow.textLength;
                param1.activePosition = param1.anchorPosition;
                return true;
            }
            return false;
        }// end function

        private static function clampToFit(param1:TextRange, param2:int) : void
        {
            if (param2 < 0)
            {
                param2 = 0;
            }
            param1.anchorPosition = Math.min(param1.anchorPosition, param2);
            param1.activePosition = Math.min(param1.activePosition, param2);
            return;
        }// end function

        private static function adjustForOversetBack(param1:TextRange) : Boolean
        {
            var _loc_2:* = param1.textFlow.flowComposer;
            if (_loc_2)
            {
                checkCompose(_loc_2, param1.absoluteEnd);
                if (param1.absoluteEnd > (_loc_2.damageAbsoluteStart - 1))
                {
                    clampToFit(param1, (_loc_2.damageAbsoluteStart - 1));
                    return true;
                }
                if (_loc_2.findControllerIndexAtPosition(param1.absoluteEnd) == -1)
                {
                    param1.anchorPosition = endOfLastController(param1.textFlow);
                    param1.activePosition = param1.anchorPosition;
                    return true;
                }
            }
            return false;
        }// end function

        private static function checkCompose(param1:IFlowComposer, param2:int) : void
        {
            if (param1.damageAbsoluteStart <= param2)
            {
                param1.composeToPosition(param2);
            }
            return;
        }// end function

        private static function endOfLastController(param1:TextFlow) : int
        {
            var _loc_2:* = param1.flowComposer;
            if (!_loc_2 || _loc_2.numControllers <= 0)
            {
                return 0;
            }
            var _loc_3:* = _loc_2.getControllerAt((_loc_2.numControllers - 1));
            return _loc_3.absoluteStart + Math.max((_loc_3.textLength - 1), 0);
        }// end function

        private static function isOverset(param1:TextFlow, param2:int) : Boolean
        {
            var _loc_3:* = param1.flowComposer;
            return !_loc_3 || _loc_3.findControllerIndexAtPosition(param2) == -1;
        }// end function

        private static function isScrollable(param1:TextFlow, param2:int) : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = param1.flowComposer;
            if (!_loc_3)
            {
                return false;
            }
            var _loc_4:* = _loc_3.findControllerIndexAtPosition(param2);
            if (_loc_3.findControllerIndexAtPosition(param2) >= 0)
            {
                _loc_5 = _loc_3.getControllerAt(_loc_4);
                _loc_6 = _loc_5.rootElement.computedFormat.blockProgression;
                return _loc_6 == BlockProgression.TB && _loc_5.verticalScrollPolicy != ScrollPolicy.OFF || _loc_6 == BlockProgression.RL && _loc_5.horizontalScrollPolicy != ScrollPolicy.OFF;
            }
            return false;
        }// end function

    }
}
