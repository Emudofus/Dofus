package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;

    class PlainTextImporter extends ConverterBase implements ITextImporter
    {
        protected var _config:IConfiguration = null;
        private static const _newLineRegex:RegExp = /
n|r
n?""
|
?/g;

        function PlainTextImporter()
        {
            return;
        }// end function

        public function importToFlow(param1:Object) : TextFlow
        {
            if (param1 is String)
            {
                return this.importFromString(String(param1));
            }
            return null;
        }// end function

        public function get configuration() : IConfiguration
        {
            return this._config;
        }// end function

        public function set configuration(param1:IConfiguration) : void
        {
            this._config = param1;
            return;
        }// end function

        protected function importFromString(param1:String) : TextFlow
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1.split(_newLineRegex);
            var _loc_3:* = new TextFlow(this._config);
            for each (_loc_4 in _loc_2)
            {
                
                _loc_5 = new ParagraphElement();
                _loc_6 = new SpanElement();
                _loc_6.replaceText(0, 0, _loc_4);
                _loc_5.replaceChildren(0, 0, _loc_6);
                _loc_3.replaceChildren(_loc_3.numChildren, _loc_3.numChildren, _loc_5);
            }
            if (useClipboardAnnotations && (param1.lastIndexOf("\n", param1.length - 2) < 0 || param1.lastIndexOf("\r\n", param1.length - 3) < 0))
            {
                _loc_7 = _loc_3.getLastLeaf();
                _loc_7.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE, "true");
                _loc_7.parent.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE, "true");
                _loc_3.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE, "true");
            }
            return _loc_3;
        }// end function

    }
}
