package flashx.textLayout.compose
{
    import flash.text.engine.*;
    import flash.utils.*;

    public class TextLineRecycler extends Object
    {
        private static const _textLineRecyclerCanBeEnabled:Boolean = new TextBlock().hasOwnProperty("recreateTextLine");
        private static var _textLineRecyclerEnabled:Boolean = _textLineRecyclerCanBeEnabled;
        private static var reusableLineCache:Dictionary = new Dictionary(true);

        public function TextLineRecycler()
        {
            return;
        }// end function

        public static function get textLineRecyclerEnabled() : Boolean
        {
            return _textLineRecyclerEnabled;
        }// end function

        public static function set textLineRecyclerEnabled(param1:Boolean) : void
        {
            _textLineRecyclerEnabled = param1 ? (_textLineRecyclerCanBeEnabled) : (false);
            return;
        }// end function

        public static function addLineForReuse(param1:TextLine) : void
        {
            if (_textLineRecyclerEnabled)
            {
                reusableLineCache[param1] = null;
            }
            return;
        }// end function

        public static function getLineForReuse() : TextLine
        {
            var _loc_1:* = null;
            if (_textLineRecyclerEnabled)
            {
                for (_loc_1 in reusableLineCache)
                {
                    
                    delete reusableLineCache[_loc_1];
                    return _loc_1 as TextLine;
                }
            }
            return null;
        }// end function

        static function emptyReusableLineCache() : void
        {
            reusableLineCache = new Dictionary(true);
            return;
        }// end function

    }
}
