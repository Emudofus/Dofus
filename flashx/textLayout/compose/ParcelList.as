package flashx.textLayout.compose
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.container.ContainerController;
   import flash.geom.Rectangle;
   import flashx.textLayout.container.ColumnState;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.LineBreak;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.container.ScrollPolicy;
   import flash.text.engine.TextLine;
   
   use namespace tlf_internal;
   
   public class ParcelList extends Object
   {
      
      public function ParcelList() {
         super();
         this._numParcels = 0;
      }
      
      private static const MAX_HEIGHT:Number = 900000000;
      
      private static const MAX_WIDTH:Number = 900000000;
      
      private static var _sharedParcelList:ParcelList;
      
      tlf_internal  static function getParcelList() : ParcelList {
         var _loc1_:ParcelList = _sharedParcelList?_sharedParcelList:new ParcelList();
         _sharedParcelList = null;
         return _loc1_;
      }
      
      tlf_internal  static function releaseParcelList(param1:ParcelList) : void {
         if(_sharedParcelList == null)
         {
            _sharedParcelList = param1 as ParcelList;
            if(_sharedParcelList)
            {
               _sharedParcelList.releaseAnyReferences();
            }
         }
      }
      
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
      
      tlf_internal function releaseAnyReferences() : void {
         this._flowComposer = null;
         this._numParcels = 0;
         this._parcelArray = null;
         if(this._singleParcel)
         {
            this._singleParcel.releaseAnyReferences();
         }
      }
      
      public function getParcelAt(param1:int) : Parcel {
         return this._numParcels <= 1?this._singleParcel:this._parcelArray[param1];
      }
      
      public function get currentParcelIndex() : int {
         return this._currentParcelIndex;
      }
      
      public function get explicitLineBreaks() : Boolean {
         return this._explicitLineBreaks;
      }
      
      private function get measureLogicalWidth() : Boolean {
         if(this._explicitLineBreaks)
         {
            return true;
         }
         if(!this._currentParcel)
         {
            return false;
         }
         var _loc1_:ContainerController = this._currentParcel.controller;
         return this._verticalText?_loc1_.measureHeight:_loc1_.measureWidth;
      }
      
      private function get measureLogicalHeight() : Boolean {
         if(!this._currentParcel)
         {
            return false;
         }
         var _loc1_:ContainerController = this._currentParcel.controller;
         return this._verticalText?_loc1_.measureWidth:_loc1_.measureHeight;
      }
      
      public function get totalDepth() : Number {
         return this._totalDepth;
      }
      
      public function addTotalDepth(param1:Number) : Number {
         this._totalDepth = this._totalDepth + param1;
         return this._totalDepth;
      }
      
      protected function reset() : void {
         this._totalDepth = 0;
         this._hasContent = false;
         this._currentParcelIndex = -1;
         this._currentParcel = null;
         this._leftMargin = 0;
         this._rightMargin = 0;
         this._insideListItemMargin = 0;
      }
      
      private function addParcel(param1:Rectangle, param2:ContainerController, param3:int) : void {
         var _loc4_:Parcel = this._numParcels == 0 && (this._singleParcel)?this._singleParcel.initialize(this._verticalText,param1.x,param1.y,param1.width,param1.height,param2,param3):new Parcel(this._verticalText,param1.x,param1.y,param1.width,param1.height,param2,param3);
         if(this._numParcels == 0)
         {
            this._singleParcel = _loc4_;
         }
         else
         {
            if(this._numParcels == 1)
            {
               this._parcelArray = [this._singleParcel,_loc4_];
            }
            else
            {
               this._parcelArray.push(_loc4_);
            }
         }
         this._numParcels++;
      }
      
      protected function addOneControllerToParcelList(param1:ContainerController) : void {
         var _loc4_:Rectangle = null;
         var _loc2_:ColumnState = param1.columnState;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_.columnCount)
         {
            _loc4_ = _loc2_.getColumnAt(_loc3_);
            if(!_loc4_.isEmpty())
            {
               this.addParcel(_loc4_,param1,_loc3_);
            }
            _loc3_++;
         }
      }
      
      public function beginCompose(param1:IFlowComposer, param2:int, param3:int, param4:Boolean) : void {
         var _loc6_:* = 0;
         this._flowComposer = param1;
         var _loc5_:ITextLayoutFormat = param1.rootElement.computedFormat;
         this._explicitLineBreaks = _loc5_.lineBreak == LineBreak.EXPLICIT;
         this._verticalText = _loc5_.blockProgression == BlockProgression.RL;
         if(param1.numControllers != 0)
         {
            if(param3 < 0)
            {
               param3 = param1.numControllers-1;
            }
            else
            {
               param3 = Math.min(param3,param1.numControllers-1);
            }
            _loc6_ = param2;
            do
            {
                  this.addOneControllerToParcelList(ContainerController(param1.getControllerAt(_loc6_)));
               }while(_loc6_++ != param3);
               
               if(param3 == param1.numControllers-1)
               {
                  this.adjustForScroll(param1.getControllerAt(param1.numControllers-1),param4);
               }
            }
            this.reset();
         }
         
         private function adjustForScroll(param1:ContainerController, param2:Boolean) : void {
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            var _loc5_:Parcel = null;
            var _loc6_:* = NaN;
            if(this._verticalText)
            {
               if(param1.horizontalScrollPolicy != ScrollPolicy.OFF)
               {
                  _loc5_ = this.getParcelAt(this._numParcels-1);
                  if(_loc5_)
                  {
                     _loc3_ = param1.getTotalPaddingRight() + param1.getTotalPaddingLeft();
                     _loc4_ = _loc5_.right;
                     _loc5_.x = param1.horizontalScrollPosition - _loc5_.width - _loc3_;
                     _loc5_.width = _loc4_ - _loc5_.x;
                     _loc5_.fitAny = true;
                     _loc5_.composeToPosition = param2;
                  }
               }
            }
            else
            {
               if(param1.verticalScrollPolicy != ScrollPolicy.OFF)
               {
                  _loc5_ = this.getParcelAt(this._numParcels-1);
                  if(_loc5_)
                  {
                     _loc6_ = param1.getTotalPaddingBottom() + param1.getTotalPaddingTop();
                     _loc5_.height = param1.verticalScrollPosition + _loc5_.height + _loc6_ - _loc5_.y;
                     _loc5_.fitAny = true;
                     _loc5_.composeToPosition = param2;
                  }
               }
            }
         }
         
         public function get leftMargin() : Number {
            return this._leftMargin;
         }
         
         public function pushLeftMargin(param1:Number) : void {
            this._leftMargin = this._leftMargin + param1;
         }
         
         public function popLeftMargin(param1:Number) : void {
            this._leftMargin = this._leftMargin - param1;
         }
         
         public function get rightMargin() : Number {
            return this._rightMargin;
         }
         
         public function pushRightMargin(param1:Number) : void {
            this._rightMargin = this._rightMargin + param1;
         }
         
         public function popRightMargin(param1:Number) : void {
            this._rightMargin = this._rightMargin - param1;
         }
         
         public function pushInsideListItemMargin(param1:Number) : void {
            this._insideListItemMargin = this._insideListItemMargin + param1;
         }
         
         public function popInsideListItemMargin(param1:Number) : void {
            this._insideListItemMargin = this._insideListItemMargin - param1;
         }
         
         public function get insideListItemMargin() : Number {
            return this._insideListItemMargin;
         }
         
         public function getComposeXCoord(param1:Rectangle) : Number {
            return this._verticalText?param1.right:param1.left;
         }
         
         public function getComposeYCoord(param1:Rectangle) : Number {
            return param1.top;
         }
         
         public function getComposeWidth(param1:Rectangle) : Number {
            if(this.measureLogicalWidth)
            {
               return TextLine.MAX_LINE_WIDTH;
            }
            return this._verticalText?param1.height:param1.width;
         }
         
         public function getComposeHeight(param1:Rectangle) : Number {
            if(this.measureLogicalHeight)
            {
               return TextLine.MAX_LINE_WIDTH;
            }
            return this._verticalText?param1.width:param1.height;
         }
         
         public function atLast() : Boolean {
            return this._numParcels == 0 || this._currentParcelIndex == this._numParcels-1;
         }
         
         public function atEnd() : Boolean {
            return this._numParcels == 0 || this._currentParcelIndex >= this._numParcels;
         }
         
         public function next() : Boolean {
            var _loc2_:ContainerController = null;
            var _loc1_:* = this._currentParcelIndex + 1 < this._numParcels;
            this._currentParcelIndex = this._currentParcelIndex + 1;
            this._totalDepth = 0;
            if(_loc1_)
            {
               this._currentParcel = this.getParcelAt(this._currentParcelIndex);
               _loc2_ = this._currentParcel.controller;
            }
            else
            {
               this._currentParcel = null;
            }
            return _loc1_;
         }
         
         public function get currentParcel() : Parcel {
            return this._currentParcel;
         }
         
         public function getLineSlug(param1:Slug, param2:Number, param3:Number, param4:Number, param5:Boolean) : Boolean {
            if(this.currentParcel.getLineSlug(param1,this._totalDepth,param2,param3,this.currentParcel.fitAny?1:int(param2),this._leftMargin,this._rightMargin,param4 + this._insideListItemMargin,param5,this._explicitLineBreaks))
            {
               if(this.totalDepth != param1.depth)
               {
                  this._totalDepth = param1.depth;
               }
               return true;
            }
            return false;
         }
         
         public function fitFloat(param1:Slug, param2:Number, param3:Number, param4:Number) : Boolean {
            return this.currentParcel.getLineSlug(param1,param2,param4,param3,this.currentParcel.fitAny?1:int(param4),this._leftMargin,this._rightMargin,0,true,this._explicitLineBreaks);
         }
      }
   }
