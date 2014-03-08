package flashx.textLayout.edit
{
   public class SelectionFormat extends Object
   {
      
      public function SelectionFormat(param1:uint=16777215, param2:Number=1.0, param3:String="difference", param4:uint=16777215, param5:Number=1.0, param6:String="difference", param7:Number=500) {
         super();
         this._rangeColor = param1;
         this._rangeAlpha = param2;
         this._rangeBlendMode = param3;
         this._pointColor = param4;
         this._pointAlpha = param5;
         this._pointBlendMode = param6;
         this._pointBlinkRate = param7;
      }
      
      private var _rangeColor:uint;
      
      private var _rangeAlpha:Number;
      
      private var _rangeBlendMode:String;
      
      private var _pointColor:uint;
      
      private var _pointAlpha:Number;
      
      private var _pointBlendMode:String;
      
      private var _pointBlinkRate:Number;
      
      public function get rangeColor() : uint {
         return this._rangeColor;
      }
      
      public function get rangeAlpha() : Number {
         return this._rangeAlpha;
      }
      
      public function get rangeBlendMode() : String {
         return this._rangeBlendMode;
      }
      
      public function get pointColor() : uint {
         return this._pointColor;
      }
      
      public function get pointAlpha() : Number {
         return this._pointAlpha;
      }
      
      public function get pointBlinkRate() : Number {
         return this._pointBlinkRate;
      }
      
      public function get pointBlendMode() : String {
         return this._pointBlendMode;
      }
      
      public function equals(param1:SelectionFormat) : Boolean {
         if(this._rangeBlendMode == param1.rangeBlendMode && this._rangeAlpha == param1.rangeAlpha && this._rangeColor == param1.rangeColor && this._pointColor == param1.pointColor && this._pointAlpha == param1.pointAlpha && this._pointBlendMode == param1.pointBlendMode && this._pointBlinkRate == param1.pointBlinkRate)
         {
            return true;
         }
         return false;
      }
   }
}
