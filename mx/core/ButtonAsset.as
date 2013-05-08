package mx.core
{

   use namespace mx_internal;

   public class ButtonAsset extends FlexSimpleButton implements IFlexAsset, IFlexDisplayObject
   {
         

      public function ButtonAsset() {
         super();
         this._measuredWidth=width;
         this._measuredHeight=height;
      }

      mx_internal  static const VERSION:String = "4.6.0.23201";

      private var _measuredHeight:Number;

      public function get measuredHeight() : Number {
         return this._measuredHeight;
      }

      private var _measuredWidth:Number;

      public function get measuredWidth() : Number {
         return this._measuredWidth;
      }

      public function move(x:Number, y:Number) : void {
         this.x=x;
         this.y=y;
      }

      public function setActualSize(newWidth:Number, newHeight:Number) : void {
         width=newWidth;
         height=newHeight;
      }
   }

}