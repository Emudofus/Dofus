package flashx.textLayout.edit
{
    import flash.desktop.*;
    import flash.system.*;
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;

    public class TextClipboard extends Object
    {
        static const TEXT_LAYOUT_MARKUP:String = "TEXT_LAYOUT_MARKUP";

        public function TextClipboard()
        {
            return;
        }// end function

        public static function getContents() : TextScrap
        {
            var systemClipboard:Clipboard;
            var getFromClipboard:Function;
            getFromClipboard = function (param1:String) : String
            {
                return systemClipboard.hasFormat(param1) ? (String(systemClipboard.getData(param1))) : (null);
            }// end function
            ;
            systemClipboard = Clipboard.generalClipboard;
            return importScrap(getFromClipboard);
        }// end function

        static function importScrap(param1:Function) : TextScrap
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_6:* = null;
            var _loc_4:* = TextConverter.numFormats;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4 && !_loc_2)
            {
                
                _loc_6 = TextConverter.getFormatDescriptorAt(_loc_5);
                _loc_3 = TextClipboard.param1(_loc_6.clipboardFormat);
                if (_loc_3 && _loc_3 != "")
                {
                    _loc_2 = importToScrap(_loc_3, _loc_6.format);
                }
                _loc_5++;
            }
            return _loc_2;
        }// end function

        public static function setContents(param1:TextScrap) : void
        {
            var systemClipboard:Clipboard;
            var addToClipboard:Function;
            var textScrap:* = param1;
            addToClipboard = function (param1:String, param2:String) : void
            {
                systemClipboard.setData(param1, param2);
                return;
            }// end function
            ;
            if (!textScrap)
            {
                return;
            }
            systemClipboard = Clipboard.generalClipboard;
            systemClipboard.clear();
            exportScrap(textScrap, addToClipboard);
            return;
        }// end function

        static function exportScrap(param1:TextScrap, param2:Function) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = [];
            var _loc_4:* = TextConverter.numFormats;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = TextConverter.getFormatDescriptorAt(_loc_5);
                if (_loc_6.clipboardFormat && _loc_3.indexOf(_loc_6.clipboardFormat) < 0)
                {
                    _loc_7 = exportForClipboard(param1, _loc_6.format);
                    if (_loc_7)
                    {
                        TextClipboard.param2(_loc_6.clipboardFormat, _loc_7);
                        _loc_3.push(_loc_6.clipboardFormat);
                    }
                }
                _loc_5++;
            }
            return;
        }// end function

        static function importToScrap(param1:String, param2:String) : TextScrap
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_4:* = TextConverter.getImporter(param2);
            if (TextConverter.getImporter(param2))
            {
                _loc_4.useClipboardAnnotations = true;
                _loc_5 = _loc_4.importToFlow(param1);
                if (_loc_5)
                {
                    _loc_3 = new TextScrap(_loc_5);
                }
                if (param2 == TextConverter.PLAIN_TEXT_FORMAT)
                {
                    _loc_3.setPlainText(true);
                }
                else if (param2 == TextConverter.TEXT_LAYOUT_FORMAT)
                {
                    _loc_3.setPlainText(false);
                }
                if (!_loc_3 && param2 == TextConverter.TEXT_LAYOUT_FORMAT)
                {
                    _loc_3 = importOldTextLayoutFormatToScrap(param1);
                }
            }
            return _loc_3;
        }// end function

        static function importOldTextLayoutFormatToScrap(param1:String) : TextScrap
        {
            var textScrap:TextScrap;
            var xmlTree:XML;
            var beginArrayChild:XML;
            var endArrayChild:XML;
            var textLayoutMarkup:XML;
            var textFlow:TextFlow;
            var element:FlowElement;
            var endMissingArray:Array;
            var textOnClipboard:* = param1;
            var originalSettings:* = XML.settings();
            XML.ignoreProcessingInstructions = false;
            XML.ignoreWhitespace = false;
            xmlTree = new XML(textOnClipboard);
            if (xmlTree.localName() == "TextScrap")
            {
                beginArrayChild = xmlTree..BeginMissingElements[0];
                endArrayChild = xmlTree..EndMissingElements[0];
                textLayoutMarkup = xmlTree..TextFlow[0];
                textFlow = TextConverter.importToFlow(textLayoutMarkup, TextConverter.TEXT_LAYOUT_FORMAT);
                if (textFlow)
                {
                    textScrap = new TextScrap(textFlow);
                    endMissingArray = getEndArray(endArrayChild, textFlow);
                    var _loc_3:* = 0;
                    var _loc_4:* = endMissingArray;
                    while (_loc_4 in _loc_3)
                    {
                        
                        element = _loc_4[_loc_3];
                        element.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE, "true");
                    }
                }
            }
            if (Configuration.playerEnablesArgoFeatures)
            {
                var _loc_3:* = System;
                _loc_3.System["disposeXML"](xmlTree);
            }
            finally
            {
                var _loc_3:* = new catch0;
                throw null;
            }
            finally
            {
                XML.setSettings(originalSettings);
            }
            return textScrap;
        }// end function

        static function exportForClipboard(param1:TextScrap, param2:String) : String
        {
            var _loc_3:* = TextConverter.getExporter(param2);
            if (_loc_3)
            {
                _loc_3.flashx.textLayout.conversion:ITextExporter::useClipboardAnnotations = true;
                return _loc_3.export(param1.textFlow, ConversionType.STRING_TYPE) as String;
            }
            return null;
        }// end function

        private static function getBeginArray(param1:XML, param2:TextFlow) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_3:* = new Array();
            var _loc_4:* = param2;
            if (param1 != null)
            {
                _loc_5 = param1.@value != undefined ? (String(param1.@value)) : ("");
                _loc_3.push(param2);
                _loc_6 = _loc_5.indexOf(",");
                while (_loc_6 >= 0)
                {
                    
                    _loc_7 = _loc_6 + 1;
                    _loc_6 = _loc_5.indexOf(",", _loc_7);
                    if (_loc_6 >= 0)
                    {
                        _loc_8 = _loc_6;
                    }
                    else
                    {
                        _loc_8 = _loc_5.length;
                    }
                    _loc_9 = _loc_5.substring(_loc_7, _loc_8);
                    if (_loc_9.length > 0)
                    {
                        _loc_10 = parseInt(_loc_9);
                        if (_loc_4 is FlowGroupElement)
                        {
                            _loc_4 = (_loc_4 as FlowGroupElement).getChildAt(_loc_10);
                            _loc_3.push(_loc_4);
                        }
                    }
                }
            }
            return _loc_3.reverse();
        }// end function

        private static function getEndArray(param1:XML, param2:TextFlow) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_3:* = new Array();
            var _loc_4:* = param2;
            if (param1 != null)
            {
                _loc_5 = param1.@value != undefined ? (String(param1.@value)) : ("");
                _loc_3.push(param2);
                _loc_6 = _loc_5.indexOf(",");
                while (_loc_6 >= 0)
                {
                    
                    _loc_7 = _loc_6 + 1;
                    _loc_6 = _loc_5.indexOf(",", _loc_7);
                    if (_loc_6 >= 0)
                    {
                        _loc_8 = _loc_6;
                    }
                    else
                    {
                        _loc_8 = _loc_5.length;
                    }
                    _loc_9 = _loc_5.substring(_loc_7, _loc_8);
                    if (_loc_9.length > 0)
                    {
                        _loc_10 = parseInt(_loc_9);
                        if (_loc_4 is FlowGroupElement)
                        {
                            _loc_4 = (_loc_4 as FlowGroupElement).getChildAt(_loc_10);
                            _loc_3.push(_loc_4);
                        }
                    }
                }
            }
            return _loc_3.reverse();
        }// end function

    }
}
