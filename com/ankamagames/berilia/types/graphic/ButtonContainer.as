package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.utils.*;

    public class ButtonContainer extends StateContainer implements IRadioItem, FinalizableUIComponent, IDragAndDropHandler
    {
        private var _selected:Boolean = false;
        private var _mousePressed:Boolean = false;
        private var _disabled:Boolean = false;
        private var _radioGroup:String;
        private var _value:Object;
        private var _checkbox:Boolean = false;
        private var _radioMode:Boolean = false;
        private var _sLinkedTo:String;
        protected var _soundId:String = "0";
        protected var _playRollOverSound:Boolean = true;
        protected var _isMute:Boolean = false;
        protected var _finalized:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ButtonContainer));

        public function ButtonContainer()
        {
            buttonMode = true;
            useHandCursor = true;
            mouseEnabled = true;
            mouseChildren = false;
            return;
        }// end function

        public function set checkBox(param1:Boolean) : void
        {
            this._checkbox = param1;
            this._radioMode = !param1 && this._radioMode;
            return;
        }// end function

        public function get checkBox() : Boolean
        {
            return this._checkbox;
        }// end function

        public function set radioMode(param1:Boolean) : void
        {
            this._radioMode = param1;
            this._checkbox = !param1 && this._checkbox;
            return;
        }// end function

        public function get radioMode() : Boolean
        {
            return this._radioMode;
        }// end function

        override public function set linkedTo(param1:String) : void
        {
            this._sLinkedTo = param1;
            return;
        }// end function

        override public function get linkedTo() : String
        {
            return this._sLinkedTo;
        }// end function

        public function set radioGroup(param1:String) : void
        {
            if (param1 == "")
            {
                this._radioGroup = null;
            }
            else
            {
                this._radioGroup = param1;
            }
            return;
        }// end function

        public function get radioGroup() : String
        {
            return this._radioGroup;
        }// end function

        public function get mousePressed() : Boolean
        {
            return this._mousePressed;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            var _loc_2:RadioGroup = null;
            this._selected = param1;
            if (changingStateData)
            {
                if (!changingStateData[param1 ? (StatesEnum.STATE_SELECTED) : (StatesEnum.STATE_NORMAL)])
                {
                    this.state = this._selected ? (StatesEnum.STATE_SELECTED) : (StatesEnum.STATE_NORMAL);
                }
                else
                {
                    this.state = param1 ? (StatesEnum.STATE_SELECTED) : (StatesEnum.STATE_NORMAL);
                }
            }
            if (this._radioGroup && getUi())
            {
                _loc_2 = getUi().getRadioGroup(this._radioGroup);
                if (_loc_2)
                {
                    _loc_2.selectedItem = this;
                }
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        override public function set state(param1) : void
        {
            if (_state == param1)
            {
                return;
            }
            switch(param1)
            {
                case StatesEnum.STATE_NORMAL:
                {
                    _state = param1;
                    restoreSnapshot(StatesEnum.STATE_NORMAL);
                    break;
                }
                case StatesEnum.STATE_DISABLED:
                {
                    this._disabled = true;
                }
                case StatesEnum.STATE_SELECTED:
                case StatesEnum.STATE_CLICKED:
                case StatesEnum.STATE_OVER:
                case StatesEnum.STATE_SELECTED_CLICKED:
                case StatesEnum.STATE_SELECTED_OVER:
                {
                    if (!softDisabled)
                    {
                        changeState(param1);
                        _state = param1;
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

        public function get id() : String
        {
            return name;
        }// end function

        public function get value()
        {
            return this._value;
        }// end function

        public function set value(param1) : void
        {
            this._value = param1;
            return;
        }// end function

        public function finalize() : void
        {
            var _loc_1:UiRootContainer = null;
            var _loc_2:RadioGroup = null;
            if (this._radioGroup)
            {
                _loc_1 = getUi();
                _loc_2 = _loc_1.addRadioGroup(this._radioGroup);
                _loc_2.addItem(this);
            }
            if (this._selected)
            {
                this.selected = this._selected;
            }
            if (getUi())
            {
                getUi().iAmFinalized(this);
            }
            this._finalized = true;
            return;
        }// end function

        public function get finalized() : Boolean
        {
            return this._finalized;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            this._finalized = param1;
            return;
        }// end function

        public function get soundId() : String
        {
            return this._soundId;
        }// end function

        public function set soundId(param1:String) : void
        {
            this._soundId = param1;
            return;
        }// end function

        public function get isMute() : Boolean
        {
            return this._isMute;
        }// end function

        public function set isMute(param1:Boolean) : void
        {
            this._isMute = param1;
            return;
        }// end function

        public function reset() : void
        {
            _snapshot = new Array();
            this.selected = false;
            _state = StatesEnum.STATE_NORMAL;
            return;
        }// end function

        override public function free() : void
        {
            super.free();
            this._selected = false;
            this._mousePressed = false;
            this._disabled = false;
            this._radioGroup = null;
            this._value = null;
            this._checkbox = false;
            this._radioMode = false;
            this._sLinkedTo = null;
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            this.free();
            return;
        }// end function

        private function selectSound() : String
        {
            if (this._soundId != "0")
            {
                return this._soundId;
            }
            switch(true)
            {
                case this.checkBox:
                {
                    if (this.selected)
                    {
                        return "16006";
                    }
                    return "16007";
                }
                default:
                {
                    return "16004";
                    break;
                }
            }
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_3:IInterfaceListener = null;
            var _loc_4:String = null;
            var _loc_5:IInterfaceListener = null;
            var _loc_6:RadioGroup = null;
            var _loc_2:uint = 9999;
            if (!super.canProcessMessage(param1))
            {
                return true;
            }
            if (!this._disabled)
            {
                switch(true)
                {
                    case param1 is MouseDownMessage:
                    {
                        this._mousePressed = true;
                        _loc_2 = this._selected ? (StatesEnum.STATE_SELECTED_CLICKED) : (StatesEnum.STATE_CLICKED);
                        break;
                    }
                    case param1 is MouseDoubleClickMessage:
                    case param1 is MouseClickMessage:
                    {
                        this._mousePressed = false;
                        if (this._checkbox)
                        {
                            this._selected = !this._selected;
                        }
                        else if (this._radioMode)
                        {
                            this._selected = true;
                        }
                        _loc_2 = this._selected ? (StatesEnum.STATE_SELECTED_OVER) : (StatesEnum.STATE_OVER);
                        if (!changingStateData[_loc_2])
                        {
                            _loc_2 = this._selected ? (StatesEnum.STATE_SELECTED) : (StatesEnum.STATE_NORMAL);
                        }
                        if (!this.isMute)
                        {
                            for each (_loc_3 in Berilia.getInstance().UISoundListeners)
                            {
                                
                                _loc_4 = this.selectSound();
                                if (int(_loc_4) != -1)
                                {
                                    _loc_3.playUISound(_loc_4);
                                }
                            }
                        }
                        break;
                    }
                    case param1 is MouseOverMessage:
                    {
                        if (this._mousePressed)
                        {
                            _loc_2 = this._selected ? (StatesEnum.STATE_SELECTED_CLICKED) : (StatesEnum.STATE_CLICKED);
                        }
                        else
                        {
                            if (this._playRollOverSound && !this.isMute)
                            {
                                for each (_loc_5 in Berilia.getInstance().UISoundListeners)
                                {
                                    
                                    _loc_5.playUISound("16010");
                                }
                            }
                            _loc_2 = this._selected ? (StatesEnum.STATE_SELECTED_OVER) : (StatesEnum.STATE_OVER);
                            if (!changingStateData[_loc_2])
                            {
                                _loc_2 = this._selected ? (StatesEnum.STATE_SELECTED) : (StatesEnum.STATE_NORMAL);
                            }
                        }
                        break;
                    }
                    case param1 is MouseReleaseOutsideMessage:
                    {
                        this._mousePressed = false;
                    }
                    case param1 is MouseOutMessage:
                    {
                        _loc_2 = this._selected ? (StatesEnum.STATE_SELECTED) : (StatesEnum.STATE_NORMAL);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (_loc_2 != 9999)
            {
                this.state = _loc_2;
                if (this._radioGroup && this._selected)
                {
                    _loc_6 = getUi().getRadioGroup(this._radioGroup);
                    if (_loc_6)
                    {
                        _loc_6.selectedItem = this;
                    }
                }
            }
            if (this._sLinkedTo)
            {
                getUi().getElement(this._sLinkedTo).process(param1);
            }
            return false;
        }// end function

    }
}
