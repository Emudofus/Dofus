package flashx.textLayout.compose
{
   import flash.utils.Dictionary;
   import flash.text.engine.TextLine;
   import flashx.textLayout.tlf_internal;
   import flash.text.engine.TextBlock;
   
   use namespace tlf_internal;
   
   public class TextLineRecycler extends Object
   {
      
      public function TextLineRecycler() {
         super();
      }
      
      private static const _textLineRecyclerCanBeEnabled:Boolean = new TextBlock().hasOwnProperty("recreateTextLine");
      
      private static var _textLineRecyclerEnabled:Boolean = _textLineRecyclerCanBeEnabled;
      
      public static function get textLineRecyclerEnabled() : Boolean {
         return _textLineRecyclerEnabled;
      }
      
      public static function set textLineRecyclerEnabled(param1:Boolean) : void {
         _textLineRecyclerEnabled = param1?_textLineRecyclerCanBeEnabled:false;
      }
      
      private static var reusableLineCache:Dictionary = new Dictionary(true);
      
      public static function addLineForReuse(param1:TextLine) : void {
         if(_textLineRecyclerEnabled)
         {
            reusableLineCache[param1] = null;
         }
      }
      
      public static function getLineForReuse() : TextLine {
         var _loc1_:Object = null;
         if(_textLineRecyclerEnabled)
         {
            for (_loc1_ in reusableLineCache)
            {
               delete reusableLineCache[[_loc1_]];
               return _loc1_ as TextLine;
            }
         }
         return null;
      }
      
      tlf_internal  static function emptyReusableLineCache() : void {
         reusableLineCache = new Dictionary(true);
      }
   }
}
