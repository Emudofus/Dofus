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
         this._numParcels=0;
      }

      private static const MAX_HEIGHT:Number = 900000000;

      private static const MAX_WIDTH:Number = 900000000;

      private static var _sharedParcelList:ParcelList;

      tlf_internal  static function getParcelList() : ParcelList {
         var rslt:ParcelList = _sharedParcelList?_sharedParcelList:new ParcelList();
         _sharedParcelList=null;
         return rslt;
      }

      tlf_internal  static function releaseParcelList(list:ParcelList) : void {
         if(_sharedParcelList==null)
         {
            _sharedParcelList=list as ParcelList;
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
         this._flowComposer=null;
         this._numParcels=0;
         this._parcelArray=null;
         if(this._singleParcel)
         {
            this._singleParcel.releaseAnyReferences();
         }
      }

      public function getParcelAt(idx:int) : Parcel {
         return this._numParcels<=1?this._singleParcel:this._parcelArray[idx];
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
         var controller:ContainerController = this._currentParcel.controller;
         return this._verticalText?controller.measureHeight:controller.measureWidth;
      }

      private function get measureLogicalHeight() : Boolean {
         if(!this._currentParcel)
         {
            return false;
         }
         var controller:ContainerController = this._currentParcel.controller;
         return this._verticalText?controller.measureWidth:controller.measureHeight;
      }

      public function get totalDepth() : Number {
         return this._totalDepth;
      }

      public function addTotalDepth(value:Number) : Number {
         this._totalDepth=this._totalDepth+value;
         return this._totalDepth;
      }

      protected function reset() : void {
         this._totalDepth=0;
         this._hasContent=false;
         this._currentParcelIndex=-1;
         this._currentParcel=null;
         this._leftMargin=0;
         this._rightMargin=0;
         this._insideListItemMargin=0;
      }

      private function addParcel(column:Rectangle, controller:ContainerController, columnIndex:int) : void {
         var newParcel:Parcel = (this._numParcels==0)&&(this._singleParcel)?this._singleParcel.initialize(this._verticalText,column.x,column.y,column.width,column.height,controller,columnIndex):new Parcel(this._verticalText,column.x,column.y,column.width,column.height,controller,columnIndex);
         if(this._numParcels==0)
         {
            this._singleParcel=newParcel;
         }
         else
         {
            if(this._numParcels==1)
            {
               this._parcelArray=[this._singleParcel,newParcel];
            }
            else
            {
               this._parcelArray.push(newParcel);
            }
         }
         this._numParcels++;
      }

      protected function addOneControllerToParcelList(controllerToInitialize:ContainerController) : void {
         var column:Rectangle = null;
         var columnState:ColumnState = controllerToInitialize.columnState;
         var columnIndex:int = 0;
         while(columnIndex<columnState.columnCount)
         {
            column=columnState.getColumnAt(columnIndex);
            if(!column.isEmpty())
            {
               this.addParcel(column,controllerToInitialize,columnIndex);
            }
            columnIndex++;
         }
      }

      public function beginCompose(composer:IFlowComposer, controllerStartIndex:int, controllerEndIndex:int, composeToPosition:Boolean) : void {
         var idx:* = 0;
         this._flowComposer=composer;
         var rootFormat:ITextLayoutFormat = composer.rootElement.computedFormat;
         this._explicitLineBreaks=rootFormat.lineBreak==LineBreak.EXPLICIT;
         this._verticalText=rootFormat.blockProgression==BlockProgression.RL;
         if(composer.numControllers!=0)
         {
            if(controllerEndIndex<0)
            {
               controllerEndIndex=composer.numControllers-1;
            }
            else
            {
               controllerEndIndex=Math.min(controllerEndIndex,composer.numControllers-1);
            }
            idx=controllerStartIndex;
            do
            {
               this.addOneControllerToParcelList(ContainerController(composer.getControllerAt(idx)));
               if(idx++==controllerEndIndex)
               {
                  if(controllerEndIndex==composer.numControllers-1)
                  {
                     this.adjustForScroll(composer.getControllerAt(composer.numControllers-1),composeToPosition);
                  }
               }
               else
               {
                  continue;
               }
            }
            while(true);
         }
         this.reset();
      }

      private function adjustForScroll(containerToInitialize:ContainerController, composeToPosition:Boolean) : void {
         var horizontalPaddingAmount:* = NaN;
         var right:* = NaN;
         var p:Parcel = null;
         var verticalPaddingAmount:* = NaN;
         if(this._verticalText)
         {
            if(containerToInitialize.horizontalScrollPolicy!=ScrollPolicy.OFF)
            {
               p=this.getParcelAt(this._numParcels-1);
               if(p)
               {
                  horizontalPaddingAmount=containerToInitialize.getTotalPaddingRight()+containerToInitialize.getTotalPaddingLeft();
                  right=p.right;
                  p.x=containerToInitialize.horizontalScrollPosition-p.width-horizontalPaddingAmount;
                  p.width=right-p.x;
                  p.fitAny=true;
                  p.composeToPosition=composeToPosition;
               }
            }
         }
         else
         {
            if(containerToInitialize.verticalScrollPolicy!=ScrollPolicy.OFF)
            {
               p=this.getParcelAt(this._numParcels-1);
               if(p)
               {
                  verticalPaddingAmount=containerToInitialize.getTotalPaddingBottom()+containerToInitialize.getTotalPaddingTop();
                  p.height=containerToInitialize.verticalScrollPosition+p.height+verticalPaddingAmount-p.y;
                  p.fitAny=true;
                  p.composeToPosition=composeToPosition;
               }
            }
         }
      }

      public function get leftMargin() : Number {
         return this._leftMargin;
      }

      public function pushLeftMargin(leftMargin:Number) : void {
         this._leftMargin=this._leftMargin+leftMargin;
      }

      public function popLeftMargin(leftMargin:Number) : void {
         this._leftMargin=this._leftMargin-leftMargin;
      }

      public function get rightMargin() : Number {
         return this._rightMargin;
      }

      public function pushRightMargin(rightMargin:Number) : void {
         this._rightMargin=this._rightMargin+rightMargin;
      }

      public function popRightMargin(rightMargin:Number) : void {
         this._rightMargin=this._rightMargin-rightMargin;
      }

      public function pushInsideListItemMargin(margin:Number) : void {
         this._insideListItemMargin=this._insideListItemMargin+margin;
      }

      public function popInsideListItemMargin(margin:Number) : void {
         this._insideListItemMargin=this._insideListItemMargin-margin;
      }

      public function get insideListItemMargin() : Number {
         return this._insideListItemMargin;
      }

      public function getComposeXCoord(o:Rectangle) : Number {
         return this._verticalText?o.right:o.left;
      }

      public function getComposeYCoord(o:Rectangle) : Number {
         return o.top;
      }

      public function getComposeWidth(o:Rectangle) : Number {
         if(this.measureLogicalWidth)
         {
            return TextLine.MAX_LINE_WIDTH;
         }
         return this._verticalText?o.height:o.width;
      }

      public function getComposeHeight(o:Rectangle) : Number {
         if(this.measureLogicalHeight)
         {
            return TextLine.MAX_LINE_WIDTH;
         }
         return this._verticalText?o.width:o.height;
      }

      public function atLast() : Boolean {
         return (this._numParcels==0)||(this._currentParcelIndex==this._numParcels-1);
      }

      public function atEnd() : Boolean {
         return (this._numParcels==0)||(this._currentParcelIndex>=this._numParcels);
      }

      public function next() : Boolean {
         var nextController:ContainerController = null;
         var nextParcelIsValid:Boolean = this._currentParcelIndex+1>this._numParcels;
         this._currentParcelIndex=this._currentParcelIndex+1;
         this._totalDepth=0;
         if(nextParcelIsValid)
         {
            this._currentParcel=this.getParcelAt(this._currentParcelIndex);
            nextController=this._currentParcel.controller;
         }
         else
         {
            this._currentParcel=null;
         }
         return nextParcelIsValid;
      }

      public function get currentParcel() : Parcel {
         return this._currentParcel;
      }

      public function getLineSlug(slug:Slug, height:Number, minWidth:Number, textIndent:Number, directionLTR:Boolean) : Boolean {
         if(this.currentParcel.getLineSlug(slug,this._totalDepth,height,minWidth,this.currentParcel.fitAny?1:int(height),this._leftMargin,this._rightMargin,textIndent+this._insideListItemMargin,directionLTR,this._explicitLineBreaks))
         {
            if(this.totalDepth!=slug.depth)
            {
               this._totalDepth=slug.depth;
            }
            return true;
         }
         return false;
      }

      public function fitFloat(slug:Slug, totalDepth:Number, width:Number, height:Number) : Boolean {
         return this.currentParcel.getLineSlug(slug,totalDepth,height,width,this.currentParcel.fitAny?1:int(height),this._leftMargin,this._rightMargin,0,true,this._explicitLineBreaks);
      }
   }

}