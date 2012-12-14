package flashx.textLayout.accessibility
{
    import flash.accessibility.*;
    import flash.display.*;
    import flash.events.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.events.*;

    public class TextAccImpl extends AccessibilityImplementation
    {
        protected var textContainer:DisplayObject;
        protected var textFlow:TextFlow;
        static const STATE_SYSTEM_NORMAL:uint = 0;
        static const STATE_SYSTEM_READONLY:uint = 64;
        static const STATE_SYSTEM_INVISIBLE:uint = 32768;
        static const ROLE_SYSTEM_STATICTEXT:uint = 41;
        static const ROLE_SYSTEM_TEXT:uint = 42;
        static const EVENT_OBJECT_NAMECHANGE:uint = 32780;
        static const EVENT_OBJECT_VALUECHANGE:uint = 32782;

        public function TextAccImpl(param1:DisplayObject, param2:TextFlow)
        {
            this.textContainer = param1;
            this.textFlow = param2;
            stub = false;
            if (param1.accessibilityProperties == null)
            {
                param1.accessibilityProperties = new AccessibilityProperties();
            }
            param2.addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE, this.eventHandler);
            return;
        }// end function

        public function detachListeners() : void
        {
            this.textFlow.removeEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE, this.eventHandler);
            return;
        }// end function

        override public function get_accRole(param1:uint) : uint
        {
            var _loc_2:* = this.textFlow.interactionManager;
            if (_loc_2 == null)
            {
                return ROLE_SYSTEM_STATICTEXT;
            }
            return ROLE_SYSTEM_TEXT;
        }// end function

        override public function get_accState(param1:uint) : uint
        {
            var _loc_2:* = this.textFlow.interactionManager;
            if (_loc_2 == null)
            {
                return STATE_SYSTEM_READONLY;
            }
            if (_loc_2.editingMode == EditingMode.READ_WRITE)
            {
                return STATE_SYSTEM_NORMAL;
            }
            return STATE_SYSTEM_READONLY;
        }// end function

        override public function get_accName(param1:uint) : String
        {
            switch(this.get_accRole(param1))
            {
                case ROLE_SYSTEM_STATICTEXT:
                {
                    return exportToString(this.textFlow);
                }
                case ROLE_SYSTEM_TEXT:
                {
                }
                default:
                {
                    return null;
                    break;
                }
            }
        }// end function

        override public function get_accValue(param1:uint) : String
        {
            switch(this.get_accRole(param1))
            {
                case ROLE_SYSTEM_TEXT:
                {
                    return exportToString(this.textFlow);
                }
                case ROLE_SYSTEM_STATICTEXT:
                {
                }
                default:
                {
                    return null;
                    break;
                }
            }
        }// end function

        protected function eventHandler(event:Event) : void
        {
            var event:* = event;
            switch(event.type)
            {
                case CompositionCompleteEvent.COMPOSITION_COMPLETE:
                {
                    try
                    {
                        Accessibility.sendEvent(this.textContainer, 0, EVENT_OBJECT_NAMECHANGE);
                        Accessibility.sendEvent(this.textContainer, 0, EVENT_OBJECT_VALUECHANGE);
                        Accessibility.updateProperties();
                    }
                    catch (e_err:Error)
                    {
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get selectionActiveIndex() : int
        {
            var _loc_1:* = this.textFlow.interactionManager;
            var _loc_2:* = -1;
            if (_loc_1 && _loc_1.editingMode != EditingMode.READ_ONLY)
            {
                _loc_2 = _loc_1.activePosition;
            }
            return _loc_2;
        }// end function

        public function get selectionAnchorIndex() : int
        {
            var _loc_1:* = this.textFlow.interactionManager;
            var _loc_2:* = -1;
            if (_loc_1 && _loc_1.editingMode != EditingMode.READ_ONLY)
            {
                _loc_2 = _loc_1.anchorPosition;
            }
            return _loc_2;
        }// end function

        public function get searchText() : String
        {
            return GlobalSettings.enableSearch ? (this.textFlow.getText()) : (null);
        }// end function

        private static function exportToString(param1:TextFlow) : String
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1.getFirstLeaf();
            var _loc_3:* = "";
            var _loc_4:* = "";
            var _loc_5:* = String.fromCharCode(173);
            while (_loc_2)
            {
                
                _loc_6 = _loc_2.getParagraph();
                while (true)
                {
                    
                    _loc_4 = _loc_2.text;
                    _loc_7 = _loc_4.split(_loc_5);
                    _loc_4 = _loc_7.join("");
                    _loc_3 = _loc_3 + _loc_4;
                    _loc_2 = _loc_2.getNextLeaf(_loc_6);
                    if (!_loc_2)
                    {
                        _loc_3 = _loc_3 + "\n";
                        break;
                    }
                }
                _loc_2 = _loc_6.getLastLeaf().getNextLeaf();
            }
            return _loc_3;
        }// end function

    }
}
