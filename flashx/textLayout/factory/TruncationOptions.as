package flashx.textLayout.factory
{
   import flashx.textLayout.formats.ITextLayoutFormat;
   
   public final class TruncationOptions extends Object
   {
      
      public function TruncationOptions(param1:String="…", param2:int=-1, param3:ITextLayoutFormat=null) {
         super();
         this.truncationIndicator = param1;
         this.truncationIndicatorFormat = param3;
         this.lineCountLimit = param2;
      }
      
      public static const NO_LINE_COUNT_LIMIT:int = -1;
      
      public static const HORIZONTAL_ELLIPSIS:String = "…";
      
      public function get truncationIndicator() : String {
         return this._truncationIndicator?this._truncationIndicator:HORIZONTAL_ELLIPSIS;
      }
      
      public function set truncationIndicator(param1:String) : void {
         this._truncationIndicator = param1;
      }
      
      public function get truncationIndicatorFormat() : ITextLayoutFormat {
         return this._truncationIndicatorFormat;
      }
      
      public function set truncationIndicatorFormat(param1:ITextLayoutFormat) : void {
         this._truncationIndicatorFormat = param1;
      }
      
      public function get lineCountLimit() : int {
         return this._lineCountLimit < NO_LINE_COUNT_LIMIT?0:this._lineCountLimit;
      }
      
      public function set lineCountLimit(param1:int) : void {
         this._lineCountLimit = param1;
      }
      
      private var _truncationIndicator:String;
      
      private var _truncationIndicatorFormat:ITextLayoutFormat;
      
      private var _lineCountLimit:int;
   }
}
