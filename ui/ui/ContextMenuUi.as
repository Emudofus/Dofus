package ui
{
    import __AS3__.vec.Vector;
    import flash.geom.Point;
    import d2components.Label;
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.SoundApi;
    import d2components.GraphicContainer;
    import flash.utils.Timer;
    import d2components.Texture;
    import contextMenu.ContextMenuItem;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import contextMenu.ContextMenuPictureLabelItem;
    import contextMenu.ContextMenuTitle;
    import contextMenu.ContextMenuSeparator;
    import contextMenu.ContextMenuPictureItem;
    import d2components.ButtonContainer;
    import d2enums.StatesEnum;
    import contextMenu.ContextMenuManager;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import d2actions.*;
    import d2hooks.*;
    import __AS3__.vec.*;

    public class ContextMenuUi 
    {

        private static var _openedMenuTriangle:Vector.<Point> = new Vector.<Point>();
        private static var _testLabel:Label;
        private static const LEFT_DIR:uint = 1;
        private static const RIGHT_DIR:uint = 2;
        private static const UP_DIR:uint = 3;
        private static const DOWN_DIR:uint = 4;
        private static const ACTIVATION_DELAY:uint = 300;

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var soundApi:SoundApi;
        public var mainCtr:GraphicContainer;
        public var bgCtr:GraphicContainer;
        private var _items:Array;
        private var _orderedItems:Array;
        private var _openTimer:Timer;
        private var _closeTimer:Timer;
        private var _lastItemOver:Object;
        private var _openedItem:Object;
        private var _lastOverIsVirtual:Boolean;
        private var _hasPuce:Boolean;
        private var _radioStyle:Boolean;
        private var _tooltipTimer:Timer;
        private var _currentHelpText:String;

        public function ContextMenuUi()
        {
            this._items = new Array();
            this._orderedItems = [];
            super();
        }

        public function get items():Array
        {
            return (this._items);
        }

        public function main(args:Object):void
        {
            var menu:Array;
            var btn:GraphicContainer;
            var btnLbl:Label;
            var btnTx:Texture;
            var btnChildIcon:Texture;
            var item:*;
            var i:uint;
            var startPoint:Point;
            var textureSize:int;
            var tempWidth:int;
            var _local_20:Boolean;
            var _local_21:Boolean;
            var _local_22:String;
            var _local_23:ContextMenuItem;
            var _local_24:Texture;
            var _local_25:Array;
            var uriArr:Array;
            this.soundApi.playSound(SoundTypeEnum.OPEN_CONTEXT_MENU);
            if (!(_testLabel))
            {
                _testLabel = (this.uiApi.createComponent("Label") as Label);
                _testLabel.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
                _testLabel.cssClass = this.uiApi.me().getConstant("item.cssClass");
                _testLabel.fixedWidth = false;
                _testLabel.useExtendWidth = true;
            };
            this.initTimer();
            if ((args is Array))
            {
                menu = (args[0] as Array);
            }
            else
            {
                menu = args.menu;
            };
            var currentY:uint;
            var sepHeight:int = parseInt(this.uiApi.me().getConstant("separatorHeight"));
            var titleHeight:int = parseInt(this.uiApi.me().getConstant("titleHeight"));
            var itemHeight:int = parseInt(this.uiApi.me().getConstant("itemHeight"));
            var minWidth:int = parseInt(this.uiApi.me().getConstant("minWidth"));
            this.uiApi.addShortcutHook("ALL", this.onShortcut);
            var maxWidth:uint;
            var hasChild:Boolean;
            i = 0;
            while (i < menu.length)
            {
                item = menu[i];
                switch (true)
                {
                    case (item is ContextMenuTitle):
                    case (item is ContextMenuItem):
                        if ((((item is ContextMenuItem)) || ((item is ContextMenuPictureLabelItem))))
                        {
                            if (item.child)
                            {
                                hasChild = true;
                            };
                            if ((((item is ContextMenuItem)) && (ContextMenuItem(item).selected)))
                            {
                                this._hasPuce = true;
                                this._radioStyle = ((this._radioStyle) || (ContextMenuItem(item).radioStyle));
                            };
                        };
                        _testLabel.text = item.label;
                        if (_testLabel.width > maxWidth)
                        {
                            maxWidth = _testLabel.width;
                        };
                        if ((item is ContextMenuPictureLabelItem))
                        {
                            textureSize = ContextMenuPictureLabelItem(item).txSize;
                            tempWidth = (_testLabel.width + textureSize);
                        };
                        if (tempWidth > maxWidth)
                        {
                            maxWidth = tempWidth;
                        };
                        break;
                };
                i++;
            };
            var xOffset:uint = 16;
            maxWidth = (maxWidth + ((10 + ((hasChild) ? 20 : 0)) + xOffset));
            if (maxWidth < minWidth)
            {
                maxWidth = minWidth;
            };
            i = 0;
            while (i < menu.length)
            {
                item = menu[i];
                switch (true)
                {
                    case (item is ContextMenuTitle):
                        btnLbl = (this.uiApi.createComponent("Label") as Label);
                        btnLbl.width = maxWidth;
                        btnLbl.height = titleHeight;
                        btnLbl.cssClass = this.uiApi.me().getConstant("title.cssClass");
                        btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
                        btnLbl.text = this.uiApi.replaceKey(item.label);
                        btnLbl.bgColor = this.sysApi.getConfigEntry("colors.contextmenu.title");
                        btnLbl.bgAlpha = this.sysApi.getConfigEntry("colors.contextmenu.title.alpha");
                        btnLbl.y = (currentY - 2);
                        this.mainCtr.addChild(btnLbl);
                        currentY = (currentY + titleHeight);
                        this.uiApi.addComponentHook(btnLbl, "onRollOver");
                        break;
                    case (item is ContextMenuSeparator):
                        btn = this.uiApi.createContainer("GraphicContainer");
                        btn.width = maxWidth;
                        btn.height = 1;
                        btn.y = (currentY + ((sepHeight - 1) / 2));
                        btn.bgColor = this.sysApi.getConfigEntry("colors.contextmenu.separator");
                        this.mainCtr.addChild(btn);
                        currentY = (currentY + sepHeight);
                        this.uiApi.addComponentHook(btn, "onRollOver");
                        break;
                    case (item is ContextMenuItem):
                        _local_20 = true;
                        _local_21 = false;
                        _local_22 = "";
                        if ((item is ContextMenuPictureItem))
                        {
                            _local_22 = ContextMenuPictureItem(item).uri;
                            _local_20 = false;
                            _local_21 = true;
                        }
                        else
                        {
                            if ((item is ContextMenuPictureLabelItem))
                            {
                                _local_21 = true;
                                _local_22 = ContextMenuPictureLabelItem(item).uri;
                            };
                        };
                        _local_23 = (item as ContextMenuItem);
                        btn = this.uiApi.createContainer("ButtonContainer");
                        ButtonContainer(btn).isMute = true;
                        btn.width = maxWidth;
                        btn.height = itemHeight;
                        btn.y = currentY;
                        btn.name = ("btn" + (i + 1));
                        this.uiApi.me().registerId(btn.name, this.uiApi.createContainer("GraphicElement", btn, new Array(), btn.name));
                        this._orderedItems.push(btn);
                        _local_24 = (this.uiApi.createComponent("Texture") as Texture);
                        _local_24.width = 16;
                        _local_24.height = 16;
                        _local_24.y = 3;
                        _local_24.name = ("puce" + i);
                        _local_24.uri = this.uiApi.createUri(this.uiApi.me().getConstant(((_local_23.radioStyle) ? "radio.uri" : "selected.uri")));
                        _local_24.finalize();
                        btn.addChild(_local_24);
                        _local_24.alpha = 0;
                        this.uiApi.me().registerId(_local_24.name, this.uiApi.createContainer("GraphicElement", _local_24, new Array(), _local_24.name));
                        _local_25 = new Array();
                        if (((!(_local_23.child)) || (!(_local_23.child.length))))
                        {
                            _local_25[StatesEnum.STATE_SELECTED] = new Array();
                            _local_25[StatesEnum.STATE_SELECTED][("puce" + i)] = new Array();
                            _local_25[StatesEnum.STATE_SELECTED][("puce" + i)]["alpha"] = 1;
                            _local_25[StatesEnum.STATE_SELECTED][btn.name] = new Array();
                            _local_25[StatesEnum.STATE_SELECTED][btn.name]["bgColor"] = -1;
                        };
                        if (!(_local_23.disabled))
                        {
                            _local_25[StatesEnum.STATE_OVER] = new Array();
                            _local_25[StatesEnum.STATE_OVER][btn.name] = new Array();
                            _local_25[StatesEnum.STATE_OVER][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
                            if (((!(_local_23.child)) || (!(_local_23.child.length))))
                            {
                                _local_25[StatesEnum.STATE_SELECTED_OVER] = new Array();
                                _local_25[StatesEnum.STATE_SELECTED_OVER][("puce" + i)] = new Array();
                                _local_25[StatesEnum.STATE_SELECTED_OVER][("puce" + i)]["alpha"] = 1;
                                _local_25[StatesEnum.STATE_SELECTED_OVER][btn.name] = new Array();
                                _local_25[StatesEnum.STATE_SELECTED_OVER][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
                                _local_25[StatesEnum.STATE_SELECTED_CLICKED] = _local_25[4];
                                _local_25[StatesEnum.STATE_OVER][("puce" + i)] = new Array();
                                _local_25[StatesEnum.STATE_OVER][("puce" + i)]["alpha"] = 0;
                            };
                        };
                        ButtonContainer(btn).changingStateData = _local_25;
                        if (_local_21)
                        {
                            btnTx = (this.uiApi.createComponent("Texture") as Texture);
                            if ((((item is ContextMenuPictureLabelItem)) && ((item.txSize <= itemHeight))))
                            {
                                btnTx.height = item.txSize;
                                btnTx.width = item.txSize;
                                btnTx.y = ((itemHeight / 2) - (item.txSize / 2));
                            }
                            else
                            {
                                btnTx.height = itemHeight;
                                btnTx.width = itemHeight;
                                btnTx.y = 0;
                            };
                            uriArr = _local_22.split("?");
                            btnTx.uri = this.uiApi.createUri(uriArr[0]);
                            btnTx.x = xOffset;
                            if (uriArr.length == 2)
                            {
                                btnTx.gotoAndStop = parseInt(uriArr[1]);
                            };
                            btnTx.finalize();
                        };
                        if (_local_20)
                        {
                            btnLbl = (this.uiApi.createComponent("Label") as Label);
                            btnLbl.width = (maxWidth - xOffset);
                            btnLbl.height = itemHeight;
                            if (_local_23.disabled)
                            {
                                btnLbl.cssClass = this.uiApi.me().getConstant("disabled.cssClass");
                            }
                            else
                            {
                                btnLbl.cssClass = this.uiApi.me().getConstant("item.cssClass");
                            };
                            btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
                            btnLbl.html = true;
                            btnLbl.useCustomFormat = true;
                            btnLbl.text = this.uiApi.replaceKey(_local_23.label);
                            if (_local_21)
                            {
                                if ((((item is ContextMenuPictureLabelItem)) && (item.pictureAfterLaber)))
                                {
                                    btnTx.x = (btnLbl.x + (maxWidth - btnTx.width));
                                    btnLbl.x = xOffset;
                                }
                                else
                                {
                                    btnLbl.x = (xOffset + btnTx.width);
                                };
                            }
                            else
                            {
                                btnLbl.x = xOffset;
                            };
                            btnLbl.y = -3;
                        };
                        if (!(_local_23.disabled))
                        {
                            if (_local_23.child)
                            {
                                btnChildIcon = (this.uiApi.createComponent("Texture") as Texture);
                                btnChildIcon.width = 10;
                                btnChildIcon.height = 10;
                                btnChildIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("rightArrow.uri"));
                                btnChildIcon.x = (btnLbl.width - btnChildIcon.width);
                                btnChildIcon.y = ((btn.height - btnChildIcon.height) / 2);
                                btnChildIcon.finalize();
                                btn.addChild(btnChildIcon);
                            };
                            this.uiApi.addComponentHook(btn, "onRollOver");
                            this.uiApi.addComponentHook(btn, "onRollOut");
                        };
                        if (((!((_local_23.callback == null))) || (_local_23.child)))
                        {
                            this.uiApi.addComponentHook(btn, "onRelease");
                        };
                        if (_local_21)
                        {
                            btn.addChild(btnTx);
                        };
                        if (_local_20)
                        {
                            btn.addChild(btnLbl);
                        };
                        ButtonContainer(btn).finalize();
                        currentY = (currentY + itemHeight);
                        this._items[btn.name] = _local_23;
                        this.mainCtr.addChild(btn);
                        ButtonContainer(btn).selected = _local_23.selected;
                        break;
                };
                i++;
            };
            this.bgCtr.x = -1;
            this.bgCtr.y = -1;
            this.bgCtr.width = (maxWidth + 2);
            this.bgCtr.height = (currentY + 4);
            if ((args is Array))
            {
                if (!(args[1]))
                {
                    startPoint = new Point((this.uiApi.getMouseX() + 5), (this.uiApi.getMouseY() + 5));
                }
                else
                {
                    startPoint = new Point(args[1].x, args[1].y);
                };
                ContextMenuManager.getInstance().mainUiLoaded = true;
            }
            else
            {
                startPoint = new Point(args.x, args.y);
            };
            ContextMenuManager.getInstance().placeMe(this.uiApi.me(), this.mainCtr, startPoint);
        }

        public function selectParentOpenItem():void
        {
            var s:Object;
            var parent:Object = ContextMenuManager.getInstance().getParent(this.uiApi.me());
            if (parent)
            {
                s = parent.uiClass.getOpenItem();
                if (s)
                {
                    parent.uiClass.onRollOver(s, true);
                };
            };
        }

        public function getOpenItem():Object
        {
            return (this._openedItem);
        }

        public function unload():void
        {
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.showHelp);
            this.uiApi.hideTooltip("contextMenuHelp");
        }

        public function onRelease(target:Object):void
        {
            var tmpItem:Object;
            var dir:uint;
            var menuX:Number;
            var menuY:Number;
            var menuWidth:Number;
            var menuHeight:Number;
            var menuTopCorner:Point;
            var menuBottomCorner:Point;
            if (this._openedItem == target)
            {
                return;
            };
            var item:ContextMenuItem = this._items[target.name];
            if (this._openedItem)
            {
                this.closeChild();
            };
            if (!(item))
            {
                return;
            };
            if (((!(item.disabled)) && (!((item.callback == null)))))
            {
                if (((item.radioStyle) || (item.forceCloseOnSelect)))
                {
                    item.callback.apply(null, item.callbackArgs);
                    if (!(item.child))
                    {
                        ContextMenuManager.getInstance().closeAll();
                    };
                }
                else
                {
                    for each (tmpItem in this._orderedItems)
                    {
                        if (tmpItem != target)
                        {
                            if (this._radioStyle)
                            {
                                tmpItem.selected = false;
                            };
                        }
                        else
                        {
                            if (!(this._radioStyle))
                            {
                                item.callback.apply(null, item.callbackArgs);
                                target.selected = !(target.selected);
                            }
                            else
                            {
                                if (!(target.selected))
                                {
                                    item.callback.apply(null, item.callbackArgs);
                                };
                                target.selected = true;
                            };
                        };
                    };
                };
            }
            else
            {
                if (((item.disabled) && (!((item.disabledCallback == null)))))
                {
                    item.disabledCallback.apply(null, item.disabledCallbackArgs);
                };
            };
            if (((((item.child) && (!(item.disabled)))) && (!((this.mainCtr == null)))))
            {
                this._openTimer.reset();
                this._openedItem = target;
                dir = RIGHT_DIR;
                menuX = (this.mainCtr.x + this.mainCtr.width);
                menuY = (this.mainCtr.y + target.y);
                menuWidth = (this.getMenuWidth(this._items[target.name].child) + 2);
                menuHeight = (this.getMenuHeight(this._items[target.name].child) + 4);
                if ((menuX + menuWidth) > this.uiApi.getStageWidth())
                {
                    menuX = (this.mainCtr.x - menuWidth);
                    dir = LEFT_DIR;
                };
                if ((menuY + menuHeight) > this.uiApi.getStageHeight())
                {
                    menuY = (menuY - menuHeight);
                };
                if (menuX < 0)
                {
                    menuX = 0;
                };
                if (menuY < 0)
                {
                    menuY = 0;
                };
                menuTopCorner = new Point();
                menuBottomCorner = new Point();
                if (dir == RIGHT_DIR)
                {
                    menuTopCorner.x = menuX;
                    menuTopCorner.y = menuY;
                    menuBottomCorner.x = menuTopCorner.x;
                    menuBottomCorner.y = (menuTopCorner.y + menuHeight);
                }
                else
                {
                    if (dir == LEFT_DIR)
                    {
                        menuTopCorner.x = (menuX + menuWidth);
                        menuTopCorner.y = menuY;
                        menuBottomCorner.x = menuTopCorner.x;
                        menuBottomCorner.y = (menuTopCorner.y + menuHeight);
                    };
                };
                _openedMenuTriangle.length = 0;
                _openedMenuTriangle.push(new Point(this.uiApi.getMouseX(), this.uiApi.getMouseY()), menuTopCorner, menuBottomCorner);
                target.selected = true;
                ContextMenuManager.getInstance().openChild({
                    "menu":this._items[target.name].child,
                    "x":(this.mainCtr.x + this.mainCtr.width),
                    "y":(this.mainCtr.y + target.y)
                });
            };
            if (!(item.child))
            {
                item.selected = target.selected;
            };
        }

        public function onRollOver(target:Object, virtual:Boolean=false):void
        {
            this._tooltipTimer.reset();
            this.selectParentOpenItem();
            if (((this._items[target.name]) && (this._items[target.name].child)))
            {
                this._openTimer.delay = ((this.isPointInsideTriangle(_openedMenuTriangle, new Point(this.uiApi.getMouseX(), this.uiApi.getMouseY()))) ? ACTIVATION_DELAY : 0);
                this._openTimer.start();
            };
            if (ContextMenuManager.getInstance().childHasFocus(this.uiApi.me()))
            {
                this._closeTimer.start();
            };
            if (this._lastItemOver == target)
            {
                this._closeTimer.reset();
            };
            if (virtual)
            {
                this._lastOverIsVirtual = true;
                target.state = (target.state + 1);
            };
            if (((this._lastItemOver) && (this._lastOverIsVirtual)))
            {
                this.onRollOut(this._lastItemOver, true);
            };
            var item:ContextMenuItem = this._items[target.name];
            if (((item) && (item.help)))
            {
                this._tooltipTimer.delay = item.helpDelay;
                this._tooltipTimer.start();
                this._currentHelpText = item.help;
            };
            ContextMenuManager.getInstance().setCurrentFocus(this.uiApi.me());
            this._lastItemOver = target;
            this._lastOverIsVirtual = virtual;
        }

        public function onRollOut(target:Object, virtual:Boolean=false):void
        {
            this._tooltipTimer.reset();
            this.uiApi.hideTooltip("contextMenuHelp");
            if (this._openedItem)
            {
                this._closeTimer.start();
            };
            this._openTimer.reset();
            if (((virtual) && (target.hasOwnProperty("state"))))
            {
                target.state = (target.state - 1);
            };
        }

        public function showHelp(e:Event):void
        {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this._currentHelpText), ContextMenuManager.getInstance().getTopParent().getElement("mainCtr"), false, "contextMenuHelp", 2, 0, 3, null, null, null, "TextInfo");
        }

        private function openChild(e:Event=null):void
        {
            this._openTimer.reset();
            this.onRelease(this._lastItemOver);
        }

        private function closeChild(e:Event=null):void
        {
            if (((!(this.uiApi)) || (ContextMenuManager.getInstance().childHasFocus(this.uiApi.me()))))
            {
                return;
            };
            this._openedItem.selected = false;
            this._closeTimer.reset();
            this._openedItem = null;
            ContextMenuManager.getInstance().closeChild(this.uiApi.me());
        }

        private function initTimer():void
        {
            this._tooltipTimer = new Timer(1000, 1);
            this._tooltipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.showHelp);
            this._openTimer = new Timer(parseInt(this.uiApi.me().getConstant("timer.open")), 1);
            this._openTimer.addEventListener(TimerEvent.TIMER, this.openChild);
            this._closeTimer = new Timer(parseInt(this.uiApi.me().getConstant("timer.close")), 1);
            this._closeTimer.addEventListener(TimerEvent.TIMER, this.closeChild);
        }

        private function addToIndex(index:int):void
        {
            var currentIndex:int = -1;
            if (this._lastItemOver)
            {
                currentIndex = this._orderedItems.indexOf(this._lastItemOver);
            };
            if (currentIndex == -1)
            {
                currentIndex = 0;
            }
            else
            {
                currentIndex = ((currentIndex + index) % this._orderedItems.length);
                if (currentIndex == -1)
                {
                    currentIndex = (this._orderedItems.length - 1);
                };
            };
            var btn:Object = this._orderedItems[currentIndex];
            if (btn)
            {
                if (this._lastItemOver)
                {
                    this.onRollOut(this._lastItemOver);
                };
                this.onRollOver(btn, true);
                this._lastItemOver = btn;
            };
        }

        private function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (this._lastItemOver)
                    {
                        this.onRelease(this._lastItemOver);
                    };
                    ContextMenuManager.getInstance().closeAll();
                    return (true);
                case "upArrow":
                    this.addToIndex(-1);
                    return (true);
                case "downArrow":
                    this.addToIndex(1);
                    return (true);
                case "closeUi":
                    ContextMenuManager.getInstance().closeAll();
                    return (true);
            };
            return (true);
        }

        private function getMenuWidth(pItems:Array):Number
        {
            var i:int;
            var item:*;
            var itemWidth:Number;
            var nbItems:int = pItems.length;
            var maxWidth:Number = 0;
            var hasChild:Boolean;
            i = 0;
            while (i < nbItems)
            {
                item = pItems[i];
                if ((((item is ContextMenuItem)) && (item.child)))
                {
                    hasChild = true;
                };
                switch (true)
                {
                    case (item is ContextMenuTitle):
                    case (item is ContextMenuItem):
                        _testLabel.text = item.label;
                        itemWidth = (((item is ContextMenuPictureLabelItem)) ? (_testLabel.width + (item as ContextMenuPictureLabelItem).txSize) : _testLabel.width);
                        if (itemWidth > maxWidth)
                        {
                            maxWidth = itemWidth;
                        };
                        break;
                };
                i++;
            };
            var minWidth:int = parseInt(this.uiApi.me().getConstant("minWidth"));
            maxWidth = (maxWidth + ((10 + ((hasChild) ? 20 : 0)) + 16));
            if (maxWidth < minWidth)
            {
                maxWidth = minWidth;
            };
            return (maxWidth);
        }

        private function getMenuHeight(pItems:Array):Number
        {
            var i:int;
            var item:*;
            var nbItems:int = pItems.length;
            var height:Number = 0;
            i = 0;
            while (i < nbItems)
            {
                item = pItems[i];
                switch (true)
                {
                    case (item is ContextMenuTitle):
                        height = (height + parseInt(this.uiApi.me().getConstant("titleHeight")));
                        break;
                    case (item is ContextMenuSeparator):
                        height = (height + parseInt(this.uiApi.me().getConstant("separatorHeight")));
                        break;
                    case (item is ContextMenuItem):
                        height = (height + parseInt(this.uiApi.me().getConstant("itemHeight")));
                        break;
                };
                i++;
            };
            return (height);
        }

        private function isPointInsideTriangle(pTriangle:Vector.<Point>, p:Point):Boolean
        {
            if (pTriangle.length != 3)
            {
                return (false);
            };
            var p1:Point = pTriangle[0];
            var p2:Point = pTriangle[1];
            var p3:Point = pTriangle[2];
            var alpha:Number = ((((p2.y - p3.y) * (p.x - p3.x)) + ((p3.x - p2.x) * (p.y - p3.y))) / (((p2.y - p3.y) * (p1.x - p3.x)) + ((p3.x - p2.x) * (p1.y - p3.y))));
            var beta:Number = ((((p3.y - p1.y) * (p.x - p3.x)) + ((p1.x - p3.x) * (p.y - p3.y))) / (((p2.y - p3.y) * (p1.x - p3.x)) + ((p3.x - p2.x) * (p1.y - p3.y))));
            var gamma:Number = ((1 - alpha) - beta);
            return ((((((alpha > 0)) && ((beta > 0)))) && ((gamma > 0))));
        }


    }
}//package ui

