package com.ankamagames.jerakine.types.positions
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.errors.*;

    public class MovementPath extends Object
    {
        protected var _oStart:MapPoint;
        protected var _oEnd:MapPoint;
        protected var _aPath:Array;
        public static var MAX_PATH_LENGTH:int = 100;

        public function MovementPath()
        {
            this._oEnd = new MapPoint();
            this._oStart = new MapPoint();
            this._aPath = new Array();
            return;
        }// end function

        public function get start() : MapPoint
        {
            return this._oStart;
        }// end function

        public function set start(param1:MapPoint) : void
        {
            this._oStart = param1;
            return;
        }// end function

        public function get end() : MapPoint
        {
            return this._oEnd;
        }// end function

        public function set end(param1:MapPoint) : void
        {
            this._oEnd = param1;
            return;
        }// end function

        public function get path() : Array
        {
            return this._aPath;
        }// end function

        public function get length() : uint
        {
            return this._aPath.length;
        }// end function

        public function fillFromCellIds(param1:Vector.<uint>) : void
        {
            var _loc_2:uint = 0;
            while (_loc_2 < param1.length)
            {
                
                this._aPath.push(new PathElement(MapPoint.fromCellId(param1[_loc_2])));
                _loc_2 = _loc_2 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < (param1.length - 1))
            {
                
                PathElement(this._aPath[_loc_2]).orientation = PathElement(this._aPath[_loc_2]).step.orientationTo(PathElement(this._aPath[(_loc_2 + 1)]).step);
                _loc_2 = _loc_2 + 1;
            }
            if (this._aPath[0])
            {
                this._oStart = this._aPath[0].step;
                this._oEnd = this._aPath[(this._aPath.length - 1)].step;
            }
            return;
        }// end function

        public function addPoint(param1:PathElement) : void
        {
            this._aPath.push(param1);
            return;
        }// end function

        public function getPointAtIndex(param1:uint) : PathElement
        {
            return this._aPath[param1];
        }// end function

        public function deletePoint(param1:uint, param2:uint = 1) : void
        {
            if (param2 == 0)
            {
                this._aPath.splice(param1);
            }
            else
            {
                this._aPath.splice(param1, param2);
            }
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = "\ndepart : [" + this._oStart.x + ", " + this._oStart.y + "]";
            _loc_1 = _loc_1 + ("\narrivée : [" + this._oEnd.x + ", " + this._oEnd.y + "]\nchemin :");
            var _loc_2:uint = 0;
            while (_loc_2 < this._aPath.length)
            {
                
                _loc_1 = _loc_1 + ("[" + PathElement(this._aPath[_loc_2]).step.x + ", " + PathElement(this._aPath[_loc_2]).step.y + ", " + PathElement(this._aPath[_loc_2]).orientation + "]  ");
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        public function compress() : void
        {
            var _loc_1:uint = 0;
            if (this._aPath.length > 0)
            {
                _loc_1 = this._aPath.length - 1;
                while (_loc_1 > 0)
                {
                    
                    if (this._aPath[_loc_1].orientation == this._aPath[(_loc_1 - 1)].orientation)
                    {
                        this.deletePoint(_loc_1);
                        _loc_1 = _loc_1 - 1;
                        continue;
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            return;
        }// end function

        public function fill() : void
        {
            var _loc_1:int = 0;
            var _loc_2:PathElement = null;
            var _loc_3:PathElement = null;
            if (this._aPath.length > 0)
            {
                _loc_1 = 0;
                _loc_2 = new PathElement();
                _loc_2.orientation = 0;
                _loc_2.step = this._oEnd;
                this._aPath.push(_loc_2);
                while (_loc_1 < (this._aPath.length - 1))
                {
                    
                    switch(_loc_3.orientation)
                    {
                        case DirectionsEnum.RIGHT:
                        {
                            break;
                        }
                        case DirectionsEnum.DOWN_RIGHT:
                        {
                            break;
                        }
                        case DirectionsEnum.DOWN:
                        {
                            break;
                        }
                        case DirectionsEnum.DOWN_LEFT:
                        {
                            break;
                        }
                        case DirectionsEnum.LEFT:
                        {
                            break;
                        }
                        case DirectionsEnum.UP_LEFT:
                        {
                            break;
                        }
                        case DirectionsEnum.UP:
                        {
                            break;
                        }
                        case DirectionsEnum.UP_RIGHT:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_1 > MAX_PATH_LENGTH)
                    {
                        throw new JerakineError("Path too long. Maybe an orientation problem?");
                    }
                }
            }
            this._aPath.pop();
            return;
        }// end function

        public function getCells() : Vector.<uint>
        {
            var _loc_3:MapPoint = null;
            var _loc_1:* = new Vector.<uint>;
            var _loc_2:uint = 0;
            while (_loc_2 < this._aPath.length)
            {
                
                _loc_3 = this._aPath[_loc_2].step;
                _loc_1.push(_loc_3.cellId);
                _loc_2 = _loc_2 + 1;
            }
            _loc_1.push(this._oEnd.cellId);
            return _loc_1;
        }// end function

        public function replaceEnd(param1:MapPoint) : void
        {
            this._oEnd = param1;
            return;
        }// end function

    }
}
