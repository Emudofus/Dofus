package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;

    public class PlainTextExporter extends ConverterBase implements IPlainTextExporter
    {
        private var _stripDiscretionaryHyphens:Boolean;
        private var _paragraphSeparator:String;
        private static var _discretionaryHyphen:String = String.fromCharCode(173);

        public function PlainTextExporter()
        {
            this._stripDiscretionaryHyphens = true;
            this._paragraphSeparator = "\n";
            return;
        }// end function

        public function get stripDiscretionaryHyphens() : Boolean
        {
            return this._stripDiscretionaryHyphens;
        }// end function

        public function set stripDiscretionaryHyphens(param1:Boolean) : void
        {
            this._stripDiscretionaryHyphens = param1;
            return;
        }// end function

        public function get paragraphSeparator() : String
        {
            return this._paragraphSeparator;
        }// end function

        public function set paragraphSeparator(param1:String) : void
        {
            this._paragraphSeparator = param1;
            return;
        }// end function

        public function export(param1:TextFlow, param2:String) : Object
        {
            clear();
            if (param2 == ConversionType.STRING_TYPE)
            {
                return this.exportToString(param1);
            }
            return null;
        }// end function

        protected function exportToString(param1:TextFlow) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_2:* = "";
            var _loc_3:* = param1.getFirstLeaf();
            while (_loc_3)
            {
                
                _loc_4 = _loc_3.getParagraph();
                while (true)
                {
                    
                    _loc_5 = _loc_3.text;
                    if (this._stripDiscretionaryHyphens)
                    {
                        _loc_7 = _loc_5.split(_discretionaryHyphen);
                        _loc_5 = _loc_7.join("");
                    }
                    _loc_2 = _loc_2 + _loc_5;
                    _loc_6 = _loc_3.getNextLeaf(_loc_4);
                    if (!_loc_6)
                    {
                        break;
                    }
                    _loc_3 = _loc_6;
                }
                _loc_3 = _loc_3.getNextLeaf();
                if (_loc_3)
                {
                    _loc_2 = _loc_2 + this._paragraphSeparator;
                }
            }
            if (useClipboardAnnotations)
            {
                _loc_8 = param1.getLastLeaf().getParagraph();
                if (_loc_8.getStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE) != "true")
                {
                    _loc_2 = _loc_2 + this._paragraphSeparator;
                }
            }
            return _loc_2;
        }// end function

    }
}
