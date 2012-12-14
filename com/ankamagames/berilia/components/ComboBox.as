package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.handlers.messages.keyboard.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;

    public class ComboBox extends GraphicContainer implements FinalizableUIComponent
    {
        private var _list:Grid;
        private var _button:ButtonContainer;
        private var _mainContainer:DisplayObject;
        private var _bgTexture:Texture;
        private var _listTexture:Texture;
        private var _finalized:Boolean;
        private var _maxListSize:uint = 300;
        private var _previousState:Boolean = false;
        public var listSizeOffset:uint = 25;
        public var autoCenter:Boolean = true;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function ComboBox()
        {
            this._button = new ButtonContainer();
            this._button.soundId = "0";
            this._bgTexture = new Texture();
            this._listTexture = new Texture();
            this._list = new Grid();
            this.showList(false);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function set buttonTexture(param1:Uri) : void
        {
            this._bgTexture.uri = param1;
            return;
        }// end function

        public function get buttonTexture() : Uri
        {
            return this._bgTexture.uri;
        }// end function

        public function set listTexture(param1:Uri) : void
        {
            this._listTexture.uri = param1;
            return;
        }// end function

        public function get listTexture() : Uri
        {
            return this._listTexture.uri;
        }// end function

        public function get maxHeight() : uint
        {
            return this._maxListSize;
        }// end function

        public function set maxHeight(param1:uint) : void
        {
            this._maxListSize = param1;
            return;
        }// end function

        public function set dataProvider(param1) : void
        {
            var _loc_2:* = this._maxListSize / this._list.slotHeight;
            if (param1.length > _loc_2)
            {
                this._list.width = width - 2;
                this._list.height = this._maxListSize;
                this._list.slotWidth = this._list.width - 16;
            }
            else
            {
                this._list.width = width - this.listSizeOffset;
                this._list.height = this._list.slotHeight * param1.length;
                this._list.slotWidth = this._list.width;
            }
            this._listTexture.height = this._list.height + 8;
            this._listTexture.width = this._list.width + 3;
            this._list.dataProvider = param1;
            return;
        }// end function

        public function get dataProvider()
        {
            return this._list.dataProvider;
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

        public function set scrollBarCss(param1:Uri) : void
        {
            this._list.verticalScrollbarCss = param1;
            return;
        }// end function

        public function get scrollBarCss() : Uri
        {
            return this._list.verticalScrollbarCss;
        }// end function

        public function set rendererName(param1:String) : void
        {
            this._list.rendererName = param1;
            return;
        }// end function

        public function get rendererName() : String
        {
            return this._list.rendererName;
        }// end function

        public function set rendererArgs(param1:String) : void
        {
            this._list.rendererArgs = param1;
            return;
        }// end function

        public function get rendererArgs() : String
        {
            return this._list.rendererArgs;
        }// end function

        public function get value()
        {
            return this._list.selectedItem;
        }// end function

        public function set value(param1) : void
        {
            this._list.selectedItem = param1;
            return;
        }// end function

        public function set autoSelect(param1:Boolean) : void
        {
            this._list.autoSelect = param1;
            return;
        }// end function

        public function get autoSelect() : Boolean
        {
            return this._list.autoSelect;
        }// end function

        public function set selectedItem(param1:Object) : void
        {
            this._list.selectedItem = param1;
            return;
        }// end function

        public function get selectedItem() : Object
        {
            return this._list.selectedItem;
        }// end function

        public function get selectedIndex() : uint
        {
            return this._list.selectedIndex;
        }// end function

        public function set selectedIndex(param1:uint) : void
        {
            this._list.selectedIndex = param1;
            return;
        }// end function

        public function get container()
        {
            if (!this._mainContainer)
            {
                return null;
            }
            if (this._mainContainer is UiRootContainer)
            {
                return SecureCenter.secure(this._mainContainer as UiRootContainer, getUi().uiModule.trusted);
            }
            return SecureCenter.secure(this._mainContainer, getUi().uiModule.trusted);
        }// end function

        public function renderModificator(param1:Array, param2:Object) : Array
        {
            if (param2 != SecureCenter.ACCESS_KEY)
            {
                throw new IllegalOperationError();
            }
            this._list.rendererName = this._list.rendererName ? (this._list.rendererName) : ("LabelGridRenderer");
            this._list.rendererArgs = this._list.rendererArgs ? (this._list.rendererArgs) : (",0xFFFFFF,0xEEEEFF,0xC0E272,0x99D321");
            this._list.width = width - this.listSizeOffset;
            this._list.slotWidth = this._list.width;
            this._list.slotHeight = height - 4;
            return this._list.renderModificator(param1, param2);
        }// end function

        public function finalize() : void
        {
            this._button.width = width;
            this._button.height = height;
            this._bgTexture.width = width;
            this._bgTexture.height = height;
            this._bgTexture.autoGrid = true;
            this._bgTexture.finalize();
            this._button.addChild(this._bgTexture);
            getUi().registerId(this._bgTexture.name, new GraphicElement(this._bgTexture, new Array(), this._bgTexture.name));
            var _loc_1:* = new Array();
            _loc_1[StatesEnum.STATE_OVER] = new Array();
            _loc_1[StatesEnum.STATE_OVER][this._bgTexture.name] = new Array();
            _loc_1[StatesEnum.STATE_OVER][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
            _loc_1[StatesEnum.STATE_CLICKED] = new Array();
            _loc_1[StatesEnum.STATE_CLICKED][this._bgTexture.name] = new Array();
            _loc_1[StatesEnum.STATE_CLICKED][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
            this._button.changingStateData = _loc_1;
            this._button.finalize();
            this._list.width = width - this.listSizeOffset;
            this._list.slotWidth = this._list.width;
            this._list.slotHeight = height - 4;
            this._list.x = 2;
            this._list.y = height + 2;
            this._list.finalize();
            this._listTexture.width = this._list.width + 4;
            this._listTexture.autoGrid = true;
            this._listTexture.y = height - 2;
            this._listTexture.finalize();
            addChild(this._button);
            addChild(this._listTexture);
            addChild(this._list);
            this._listTexture.mouseEnabled = false;
            this._list.mouseEnabled = false;
            this._mainContainer = this._list.renderer.render(null, 0, false);
            this._mainContainer.x = this._list.x;
            if (this.autoCenter)
            {
                this._mainContainer.y = (height - this._mainContainer.height) / 2;
            }
            this._button.addChild(this._mainContainer);
            this._finalized = true;
            getUi().iAmFinalized(this);
            return;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            switch(true)
            {
                case param1 is MouseReleaseOutsideMessage:
                {
                    this.showList(false);
                    break;
                }
                case param1 is SelectItemMessage:
                {
                    this._list.renderer.update(this._list.selectedItem, 0, this._mainContainer, false);
                    switch(SelectItemMessage(param1).selectMethod)
                    {
                        case SelectMethodEnum.UP_ARROW:
                        case SelectMethodEnum.DOWN_ARROW:
                        case SelectMethodEnum.RIGHT_ARROW:
                        case SelectMethodEnum.LEFT_ARROW:
                        {
                            break;
                        }
                        default:
                        {
                            this.showList(false);
                            break;
                            break;
                        }
                    }
                    break;
                }
                case param1 is MouseDownMessage:
                {
                    if (!this._list.visible)
                    {
                        this.showList(true);
                        this._list.moveTo(this._list.selectedIndex);
                    }
                    else if (MouseDownMessage(param1).target == this._button)
                    {
                        this.showList(false);
                    }
                    break;
                }
                case param1 is MouseWheelMessage:
                {
                    if (this._list.visible)
                    {
                        this._list.process(param1);
                    }
                    else
                    {
                        this._list.setSelectedIndex(this._list.selectedIndex + MouseWheelMessage(param1).mouseEvent.delta / Math.abs(MouseWheelMessage(param1).mouseEvent.delta) * -1, SelectMethodEnum.WHEEL);
                    }
                    return true;
                }
                case param1 is KeyboardKeyUpMessage:
                {
                    if (KeyboardMessage(param1).keyboardEvent.keyCode == Keyboard.ENTER && this._list.visible)
                    {
                        this.showList(false);
                        return true;
                    }
                    break;
                }
                case param1 is KeyboardMessage:
                {
                    this._list.process(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        override public function remove() : void
        {
            if (!__removed)
            {
                removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
                StageShareManager.stage.removeEventListener(MouseEvent.CLICK, this.onClick);
                this._listTexture.remove();
                this._list.remove();
                this._button.remove();
                this._list.renderer.remove(this._mainContainer);
                SecureCenter.destroy(this._mainContainer);
                SecureCenter.destroy(this._list);
                this._bgTexture.remove();
                this._bgTexture = null;
                this._list = null;
                this._button = null;
                this._mainContainer = null;
                this._listTexture = null;
            }
            super.remove();
            return;
        }// end function

        private function showList(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._previousState != param1)
            {
                if (param1)
                {
                    for each (_loc_2 in Berilia.getInstance().UISoundListeners)
                    {
                        
                        _loc_2.playUISound("16012");
                    }
                }
                else
                {
                    for each (_loc_3 in Berilia.getInstance().UISoundListeners)
                    {
                        
                        _loc_3.playUISound("16013");
                    }
                }
            }
            this._listTexture.visible = param1;
            this._list.visible = param1;
            this._previousState = param1;
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            var _loc_2:* = DisplayObject(event.target);
            while (_loc_2.parent)
            {
                
                if (_loc_2 == this)
                {
                    return;
                }
                _loc_2 = _loc_2.parent;
            }
            this.showList(false);
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            StageShareManager.stage.addEventListener(MouseEvent.CLICK, this.onClick);
            return;
        }// end function

    }
}
