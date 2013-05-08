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

      public static function set textLineRecyclerEnabled(value:Boolean) : void {
         _textLineRecyclerEnabled=value?_textLineRecyclerCanBeEnabled:false;
      }

      private static var reusableLineCache:Dictionary = new Dictionary(true);

      public static function addLineForReuse(textLine:TextLine) : void {
         if(_textLineRecyclerEnabled)
         {
            reusableLineCache[textLine]=null;
         }
      }

      public static function getLineForReuse() : TextLine {
         var obj:Object = null;
         if(_textLineRecyclerEnabled)
         {
            if(!(reusableLineCache hasNext _loc2_))
            {
            }
            else
            {
               obj=nextName(_loc2_,_loc3_);
               delete reusableLineCache[[obj]];
               return obj as TextLine;
            }
         }
         return null;
      }

      tlf_internal  static function emptyReusableLineCache() : void {
         reusableLineCache=new Dictionary(true);
      }


   }

}