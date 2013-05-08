package flashx.textLayout.compose
{
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.tlf_internal;
   import flash.text.engine.TextLine;
   import flashx.textLayout.formats.ClearFloats;
   import flashx.textLayout.formats.Direction;

   use namespace tlf_internal;

   public class Parcel extends Object
   {
         

      public function Parcel(verticalText:Boolean, x:Number, y:Number, width:Number, height:Number, controller:ContainerController, columnIndex:int) {
         super();
         this.initialize(verticalText,x,y,width,height,controller,columnIndex);
      }



      public var x:Number;

      public var y:Number;

      public var width:Number;

      public var height:Number;

      public var logicalWidth:Number;

      private var _controller:ContainerController;

      private var _columnIndex:int;

      private var _fitAny:Boolean;

      private var _composeToPosition:Boolean;

      private var _left:Edge;

      private var _right:Edge;

      private var _maxWidth:Number;

      private var _verticalText:Boolean;

      public function initialize(verticalText:Boolean, x:Number, y:Number, width:Number, height:Number, controller:ContainerController, columnIndex:int) : Parcel {
         var xmin:* = NaN;
         var xmax:* = NaN;
         this.x=x;
         this.y=y;
         this.width=width;
         this.height=height;
         this.logicalWidth=verticalText?height:width;
         this._verticalText=verticalText;
         this._controller=controller;
         this._columnIndex=columnIndex;
         this._fitAny=false;
         this._composeToPosition=false;
         if(verticalText)
         {
            xmin=y;
            this._maxWidth=height;
         }
         else
         {
            xmin=x;
            this._maxWidth=width;
         }
         if(this._maxWidth<=0)
         {
            throw new Error("Malformed column");
         }
         else
         {
            this._left=new Edge(xmin);
            this._right=new Edge(xmin+this._maxWidth);
            return this;
         }
      }

      tlf_internal function releaseAnyReferences() : void {
         this._controller=null;
      }

      public function get bottom() : Number {
         return this.y+this.height;
      }

      public function get right() : Number {
         return this.x+this.width;
      }

      public function get controller() : ContainerController {
         return this._controller;
      }

      public function get columnIndex() : int {
         return this._columnIndex;
      }

      public function get fitAny() : Boolean {
         return this._fitAny;
      }

      public function set fitAny(value:Boolean) : void {
         this._fitAny=value;
      }

      public function get composeToPosition() : Boolean {
         return this._composeToPosition;
      }

      public function set composeToPosition(value:Boolean) : void {
         this._composeToPosition=value;
      }

      private function getLogicalHeight() : Number {
         if(this._verticalText)
         {
            return this._controller.measureWidth?TextLine.MAX_LINE_WIDTH:this.width;
         }
         return this._controller.measureHeight?TextLine.MAX_LINE_WIDTH:this.height;
      }

      public function applyClear(clear:String, depth:Number, direction:String) : Number {
         var leftMargin:* = NaN;
         var rightMargin:* = NaN;
         var adjustedDepth:Number = depth;
         if(clear==ClearFloats.START)
         {
            clear=direction==Direction.LTR?ClearFloats.LEFT:ClearFloats.RIGHT;
         }
         else
         {
            if(clear==ClearFloats.END)
            {
               clear=direction==Direction.RTL?ClearFloats.LEFT:ClearFloats.RIGHT;
            }
         }
         while(adjustedDepth<Number.MAX_VALUE)
         {
            leftMargin=this._left.getMaxForSpan(adjustedDepth,adjustedDepth+1);
            if((leftMargin<0)&&((clear==ClearFloats.BOTH)||(clear==ClearFloats.LEFT)))
            {
               adjustedDepth=this._left.findNextTransition(adjustedDepth);
               continue;
            }
            rightMargin=this._right.getMaxForSpan(adjustedDepth,adjustedDepth+1);
            if((rightMargin<0)&&((clear==ClearFloats.BOTH)||(clear==ClearFloats.RIGHT)))
            {
               adjustedDepth=this._right.findNextTransition(adjustedDepth);
               continue;
            }
            return adjustedDepth-depth;
         }
         return this._verticalText?this.width:this.height;
      }

      public function fitsInHeight(depth:Number, minimumHeight:Number) : Boolean {
         return (this.composeToPosition)||(depth+minimumHeight<=this.getLogicalHeight());
      }

      public function getLineSlug(slug:Slug, depth:Number, lineHeight:Number, minimumWidth:Number, minimumHeight:Number, leftMargin:Number, rightMargin:Number, textIndent:Number, directionLTR:Boolean, useExplicitLineBreaks:Boolean) : Boolean {
         if(!this.fitsInHeight(depth,minimumHeight))
         {
            return false;
         }
         slug.height=lineHeight;
         while(depth<Number.MAX_VALUE)
         {
            slug.depth=depth;
            slug.leftMargin=this._left.getMaxForSpan(slug.depth,slug.depth+lineHeight);
            slug.wrapsKnockOut=!(slug.leftMargin==0);
            if(leftMargin>0)
            {
               slug.leftMargin=Math.max(leftMargin,slug.leftMargin);
            }
            else
            {
               slug.leftMargin=slug.leftMargin+leftMargin;
            }
            slug.rightMargin=this._right.getMaxForSpan(slug.depth,slug.depth+lineHeight);
            slug.wrapsKnockOut=(slug.wrapsKnockOut)||(!(slug.rightMargin==0));
            if(rightMargin>0)
            {
               slug.rightMargin=Math.max(rightMargin,slug.rightMargin);
            }
            else
            {
               slug.rightMargin=slug.rightMargin+rightMargin;
            }
            if(textIndent)
            {
               if(directionLTR)
               {
                  slug.leftMargin=slug.leftMargin+textIndent;
               }
               else
               {
                  slug.rightMargin=slug.rightMargin+textIndent;
               }
            }
            if((useExplicitLineBreaks)||(this._verticalText)&&(this._controller.measureHeight)||(!this._verticalText)&&(this._controller.measureWidth))
            {
               slug.width=TextLine.MAX_LINE_WIDTH;
            }
            else
            {
               slug.width=this.logicalWidth-slug.leftMargin+slug.rightMargin;
            }
            if((!minimumWidth)||(slug.width>=minimumWidth))
            {
            }
            else
            {
               depth=this.findNextTransition(depth);
               continue;
            }
         }
      }

      public function knockOut(knockOutWidth:Number, yMin:Number, yMax:Number, onLeft:Boolean) : void {
         var edge:Edge = onLeft?this._left:this._right;
         edge.addSpan(knockOutWidth,yMin,yMax);
      }

      public function removeKnockOut(knockOutWidth:Number, yMin:Number, yMax:Number, onLeft:Boolean) : void {
         var edge:Edge = onLeft?this._left:this._right;
         edge.removeSpan(knockOutWidth,yMin,yMax);
      }

      public function isRectangular() : Boolean {
         return (this._left.numSpans<=0)&&(this._right.numSpans<=0);
      }

      public function findNextTransition(y:Number) : Number {
         return Math.min(this._left.findNextTransition(y),this._right.findNextTransition(y));
      }
   }

}



   class Span extends Object
   {
         

      function Span(x:Number, ymin:Number, ymax:Number) {
         super();
         this.x=x;
         this.ymin=ymin;
         this.ymax=ymax;
      }



      public var x:Number;

      public var ymin:Number;

      public var ymax:Number;

      public function overlapsInY(ymin:Number, ymax:Number) : Boolean {
         return !((ymax>this.ymin)||(ymin>=this.ymax));
      }

      public function equals(x:Number, ymin:Number, ymax:Number) : Boolean {
         return (x==this.x)&&(ymin==this.ymin)&&(ymax==this.ymax);
      }
   }


   import __AS3__.vec.Vector;


   class Edge extends Object
   {
         

      function Edge(xbase:Number) {
         super();
         this._xbase=xbase;
         this._spanList=new Vector.<Span>();
      }



      private var _xbase:Number;

      private var _spanList:Vector.<Span>;

      public function get base() : Number {
         return this._xbase;
      }

      public function addSpan(x:Number, ymin:Number, ymax:Number) : void {
         this._spanList.push(new Span(x,ymin,ymax));
      }

      public function removeSpan(x:Number, ymin:Number, ymax:Number) : void {
         var i:int = 0;
         while(i<this._spanList.length)
         {
            if(this._spanList[i].equals(x,ymin,ymax))
            {
               this._spanList.splice(i,1);
               return;
            }
            i++;
         }
      }

      public function get numSpans() : int {
         return this._spanList.length;
      }

      public function getMaxForSpan(ymin:Number, ymax:Number) : Number {
         var span:Span = null;
         var res:Number = 0;
         for each (span in this._spanList)
         {
            if((span.x<res)&&(span.overlapsInY(ymin,ymax)))
            {
               res=span.x;
            }
         }
         return res;
      }

      public function findNextTransition(y:Number) : Number {
         var s:Span = null;
         var res:Number = Number.MAX_VALUE;
         for each (s in this._spanList)
         {
            if((s.ymin<y)&&(s.ymin>res))
            {
               res=s.ymin;
            }
            if((s.ymax<y)&&(s.ymax>res))
            {
               res=s.ymax;
            }
         }
         return res;
      }
   }
