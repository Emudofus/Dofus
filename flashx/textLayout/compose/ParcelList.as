package flashx.textLayout.compose
{
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.formats.*;

    public class ParcelList extends Object
    {
        protected var _flowComposer:IFlowComposer;
        protected var _totalDepth:Number;
        protected var _hasContent:Boolean;
        protected var _parcelArray:Array;
        protected var _numParcels:int;
        protected var _singleParcel:Parcel;
        protected var _currentParcelIndex:int;
        protected var _currentParcel:Parcel;
        protected var _insideListItemMargin:Number;
        protected var _leftMargin:Number;
        protected var _rightMargin:Number;
        protected var _explicitLineBreaks:Boolean;
        protected var _verticalText:Boolean;
        private static const MAX_HEIGHT:Number = 900000000;
        private static const MAX_WIDTH:Number = 900000000;
        private static var _sharedParcelList:ParcelList;

        public function ParcelList()
        {
            this._numParcels = 0;
            return;
        }// end function

        function releaseAnyReferences() : void
        {
            this._flowComposer = null;
            this._numParcels = 0;
            this._parcelArray = null;
            if (this._singleParcel)
            {
                this._singleParcel.releaseAnyReferences();
            }
            return;
        }// end function

        public function getParcelAt(param1:int) : Parcel
        {
            return this._numParcels <= 1 ? (this._singleParcel) : (this._parcelArray[param1]);
        }// end function

        public function get currentParcelIndex() : int
        {
            return this._currentParcelIndex;
        }// end function

        public function get explicitLineBreaks() : Boolean
        {
            return this._explicitLineBreaks;
        }// end function

        private function get measureLogicalWidth() : Boolean
        {
            if (this._explicitLineBreaks)
            {
                return true;
            }
            if (!this._currentParcel)
            {
                return false;
            }
            var _loc_1:* = this._currentParcel.controller;
            return this._verticalText ? (_loc_1.measureHeight) : (_loc_1.measureWidth);
        }// end function

        private function get measureLogicalHeight() : Boolean
        {
            if (!this._currentParcel)
            {
                return false;
            }
            var _loc_1:* = this._currentParcel.controller;
            return this._verticalText ? (_loc_1.measureWidth) : (_loc_1.measureHeight);
        }// end function

        public function get totalDepth() : Number
        {
            return this._totalDepth;
        }// end function

        public function addTotalDepth(param1:Number) : Number
        {
            this._totalDepth = this._totalDepth + param1;
            return this._totalDepth;
        }// end function

        protected function reset() : void
        {
            this._totalDepth = 0;
            this._hasContent = false;
            this._currentParcelIndex = -1;
            this._currentParcel = null;
            this._leftMargin = 0;
            this._rightMargin = 0;
            this._insideListItemMargin = 0;
            return;
        }// end function

        private function addParcel(param1:Rectangle, param2:ContainerController, param3:int) : void
        {
            var _loc_4:* = this._numParcels == 0 && this._singleParcel ? (this._singleParcel.initialize(this._verticalText, param1.x, param1.y, param1.width, param1.height, param2, param3)) : (new Parcel(this._verticalText, param1.x, param1.y, param1.width, param1.height, param2, param3));
            if (this._numParcels == 0)
            {
                this._singleParcel = _loc_4;
            }
            else if (this._numParcels == 1)
            {
                this._parcelArray = [this._singleParcel, _loc_4];
            }
            else
            {
                this._parcelArray.push(_loc_4);
            }
            var _loc_5:* = this;
            var _loc_6:* = this._numParcels + 1;
            _loc_5._numParcels = _loc_6;
            return;
        }// end function

        protected function addOneControllerToParcelList(param1:ContainerController) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.columnState;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.columnCount)
            {
                
                _loc_4 = _loc_2.getColumnAt(_loc_3);
                if (!_loc_4.isEmpty())
                {
                    this.addParcel(_loc_4, param1, _loc_3);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function beginCompose(param1:IFlowComposer, param2:int, param3:int, param4:Boolean) : void
        {
            var _loc_6:* = 0;
            this._flowComposer = param1;
            var _loc_5:* = param1.rootElement.computedFormat;
            this._explicitLineBreaks = _loc_5.lineBreak == LineBreak.EXPLICIT;
            this._verticalText = _loc_5.blockProgression == BlockProgression.RL;
            if (param1.numControllers != 0)
            {
                if (param3 < 0)
                {
                    param3 = param1.numControllers - 1;
                }
                else
                {
                    param3 = Math.min(param3, (param1.numControllers - 1));
                }
                _loc_6 = param2;
                do
                {
                    
                    this.addOneControllerToParcelList(ContainerController(param1.getControllerAt(_loc_6)));
                }while (_loc_6++ != param3)
                if (param3 == (param1.numControllers - 1))
                {
                    this.adjustForScroll(param1.getControllerAt((param1.numControllers - 1)), param4);
                }
            }
            this.reset();
            return;
        }// end function

        private function adjustForScroll(param1:ContainerController, param2:Boolean) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            if (this._verticalText)
            {
                if (param1.horizontalScrollPolicy != ScrollPolicy.OFF)
                {
                    _loc_5 = this.getParcelAt((this._numParcels - 1));
                    if (_loc_5)
                    {
                        _loc_3 = param1.getTotalPaddingRight() + param1.getTotalPaddingLeft();
                        _loc_4 = _loc_5.right;
                        _loc_5.x = param1.horizontalScrollPosition - _loc_5.width - _loc_3;
                        _loc_5.width = _loc_4 - _loc_5.x;
                        _loc_5.fitAny = true;
                        _loc_5.composeToPosition = param2;
                    }
                }
            }
            else if (param1.verticalScrollPolicy != ScrollPolicy.OFF)
            {
                _loc_5 = this.getParcelAt((this._numParcels - 1));
                if (_loc_5)
                {
                    _loc_6 = param1.getTotalPaddingBottom() + param1.getTotalPaddingTop();
                    _loc_5.height = param1.verticalScrollPosition + _loc_5.height + _loc_6 - _loc_5.y;
                    _loc_5.fitAny = true;
                    _loc_5.composeToPosition = param2;
                }
            }
            return;
        }// end function

        public function get leftMargin() : Number
        {
            return this._leftMargin;
        }// end function

        public function pushLeftMargin(param1:Number) : void
        {
            this._leftMargin = this._leftMargin + param1;
            return;
        }// end function

        public function popLeftMargin(param1:Number) : void
        {
            this._leftMargin = this._leftMargin - param1;
            return;
        }// end function

        public function get rightMargin() : Number
        {
            return this._rightMargin;
        }// end function

        public function pushRightMargin(param1:Number) : void
        {
            this._rightMargin = this._rightMargin + param1;
            return;
        }// end function

        public function popRightMargin(param1:Number) : void
        {
            this._rightMargin = this._rightMargin - param1;
            return;
        }// end function

        public function pushInsideListItemMargin(param1:Number) : void
        {
            this._insideListItemMargin = this._insideListItemMargin + param1;
            return;
        }// end function

        public function popInsideListItemMargin(param1:Number) : void
        {
            this._insideListItemMargin = this._insideListItemMargin - param1;
            return;
        }// end function

        public function get insideListItemMargin() : Number
        {
            return this._insideListItemMargin;
        }// end function

        public function getComposeXCoord(param1:Rectangle) : Number
        {
            return this._verticalText ? (param1.right) : (param1.left);
        }// end function

        public function getComposeYCoord(param1:Rectangle) : Number
        {
            return param1.top;
        }// end function

        public function getComposeWidth(param1:Rectangle) : Number
        {
            if (this.measureLogicalWidth)
            {
                return TextLine.MAX_LINE_WIDTH;
            }
            return this._verticalText ? (param1.height) : (param1.width);
        }// end function

        public function getComposeHeight(param1:Rectangle) : Number
        {
            if (this.measureLogicalHeight)
            {
                return TextLine.MAX_LINE_WIDTH;
            }
            return this._verticalText ? (param1.width) : (param1.height);
        }// end function

        public function atLast() : Boolean
        {
            return this._numParcels == 0 || this._currentParcelIndex == (this._numParcels - 1);
        }// end function

        public function atEnd() : Boolean
        {
            return this._numParcels == 0 || this._currentParcelIndex >= this._numParcels;
        }// end function

        public function next() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = (this._currentParcelIndex + 1) < this._numParcels;
            (this._currentParcelIndex + 1);
            this._totalDepth = 0;
            if (_loc_1)
            {
                this._currentParcel = this.getParcelAt(this._currentParcelIndex);
                _loc_2 = this._currentParcel.controller;
            }
            else
            {
                this._currentParcel = null;
            }
            return _loc_1;
        }// end function

        public function get currentParcel() : Parcel
        {
            return this._currentParcel;
        }// end function

        public function getLineSlug(param1:Slug, param2:Number, param3:Number, param4:Number, param5:Boolean) : Boolean
        {
            if (this.currentParcel.getLineSlug(param1, this._totalDepth, param2, param3, this.currentParcel.fitAny ? (1) : (int(param2)), this._leftMargin, this._rightMargin, param4 + this._insideListItemMargin, param5, this._explicitLineBreaks))
            {
                if (this.totalDepth != param1.depth)
                {
                    this._totalDepth = param1.depth;
                }
                return true;
            }
            return false;
        }// end function

        public function fitFloat(param1:Slug, param2:Number, param3:Number, param4:Number) : Boolean
        {
            return this.currentParcel.getLineSlug(param1, param2, param4, param3, this.currentParcel.fitAny ? (1) : (int(param4)), this._leftMargin, this._rightMargin, 0, true, this._explicitLineBreaks);
        }// end function

        static function getParcelList() : ParcelList
        {
            var _loc_1:* = _sharedParcelList ? (_sharedParcelList) : (new ParcelList);
            _sharedParcelList = null;
            return _loc_1;
        }// end function

        static function releaseParcelList(param1:ParcelList) : void
        {
            if (_sharedParcelList == null)
            {
                _sharedParcelList = param1 as ParcelList;
                if (_sharedParcelList)
                {
                    _sharedParcelList.releaseAnyReferences();
                }
            }
            return;
        }// end function

    }
}
