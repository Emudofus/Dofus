package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.SoundApi;
   import d2components.GraphicContainer;
   import flash.utils.Timer;
   import d2components.Label;
   import d2components.Texture;
   import flash.geom.Point;
   import contextMenu.ContextMenuItem;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2actions.*;
   import d2hooks.*;
   import contextMenu.ContextMenuPictureLabelItem;
   import contextMenu.ContextMenuTitle;
   import contextMenu.ContextMenuPictureItem;
   import d2components.ButtonContainer;
   import d2enums.StatesEnum;
   import contextMenu.ContextMenuSeparator;
   import contextMenu.ContextMenuManager;
   import flash.events.TimerEvent;
   import flash.events.Event;
   
   public class ContextMenuUi extends Object
   {
      
      public function ContextMenuUi() {
         this._items = new Array();
         this._orderedItems = [];
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var soundApi:SoundApi;
      
      public var mainCtr:GraphicContainer;
      
      public var bgCtr:GraphicContainer;
      
      private var _items:Array;
      
      public function get items() : Array {
         return this._items;
      }
      
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
      
      public function main(args:Object) : void {
         var menu:Array = null;
         var btn:GraphicContainer = null;
         var btnLbl:Label = null;
         var btnTx:Texture = null;
         var btnChildIcon:Texture = null;
         var item:* = undefined;
         var i:uint = 0;
         var startPoint:Point = null;
         var testTexture:Texture = null;
         var textureSize:* = 0;
         var tempWidth:* = 0;
         var asLabel:* = false;
         var asTexture:* = false;
         var uri:String = null;
         var cmi:ContextMenuItem = null;
         var puce:Texture = null;
         var stateChangingProperties:Array = null;
         var uriArr:Array = null;
         this.soundApi.playSound(SoundTypeEnum.OPEN_CONTEXT_MENU);
         this.initTimer();
         if(args is Array)
         {
            menu = args[0] as Array;
         }
         else
         {
            menu = args.menu;
         }
         var currentY:uint = 0;
         var sepHeight:int = parseInt(this.uiApi.me().getConstant("separatorHeight"));
         var titleHeight:int = parseInt(this.uiApi.me().getConstant("titleHeight"));
         var itemHeight:int = parseInt(this.uiApi.me().getConstant("itemHeight"));
         var minWidth:int = parseInt(this.uiApi.me().getConstant("minWidth"));
         this.uiApi.addShortcutHook("ALL",this.onShortcut);
         var maxWidth:uint = 0;
         var hasChild:Boolean = false;
         var testLabel:Object = this.uiApi.createComponent("Label");
         testLabel.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
         testLabel.cssClass = this.uiApi.me().getConstant("item.cssClass");
         testLabel.fixedWidth = false;
         testLabel.useExtendWidth = true;
         i = 0;
         while(i < menu.length)
         {
            item = menu[i];
            switch(true)
            {
               case item is ContextMenuTitle:
               case item is ContextMenuItem:
                  if((item is ContextMenuItem) || (item is ContextMenuPictureLabelItem))
                  {
                     if(item.child)
                     {
                        hasChild = true;
                     }
                     if((item is ContextMenuItem) && (ContextMenuItem(item).selected))
                     {
                        this._hasPuce = true;
                        this._radioStyle = (this._radioStyle) || (ContextMenuItem(item).radioStyle);
                     }
                  }
                  testLabel.text = item.label;
                  if(testLabel.width > maxWidth)
                  {
                     maxWidth = testLabel.width;
                  }
                  if(item is ContextMenuPictureLabelItem)
                  {
                     testTexture = this.uiApi.createComponent("Texture") as Texture;
                     textureSize = ContextMenuPictureLabelItem(item).txSize;
                     tempWidth = testLabel.width + textureSize;
                  }
                  if(tempWidth > maxWidth)
                  {
                     maxWidth = tempWidth;
                  }
                  break;
            }
            i++;
         }
         var xOffset:uint = 16;
         maxWidth = maxWidth + (10 + (hasChild?20:0) + xOffset);
         if(maxWidth < minWidth)
         {
            maxWidth = minWidth;
         }
         i = 0;
         while(i < menu.length)
         {
            item = menu[i];
            switch(true)
            {
               case item is ContextMenuTitle:
                  btnLbl = this.uiApi.createComponent("Label") as Label;
                  btnLbl.width = maxWidth;
                  btnLbl.height = titleHeight;
                  btnLbl.cssClass = this.uiApi.me().getConstant("title.cssClass");
                  btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
                  btnLbl.text = this.uiApi.replaceKey(item.label);
                  btnLbl.bgColor = this.sysApi.getConfigEntry("colors.contextmenu.title");
                  btnLbl.bgAlpha = this.sysApi.getConfigEntry("colors.contextmenu.title.alpha");
                  btnLbl.y = currentY - 2;
                  this.mainCtr.addChild(btnLbl);
                  currentY = currentY + titleHeight;
                  this.uiApi.addComponentHook(btnLbl,"onRollOver");
                  break;
               case item is ContextMenuSeparator:
                  btn = this.uiApi.createContainer("GraphicContainer");
                  btn.width = maxWidth;
                  btn.height = 1;
                  btn.y = currentY + (sepHeight - 1) / 2;
                  btn.bgColor = this.sysApi.getConfigEntry("colors.contextmenu.separator");
                  this.mainCtr.addChild(btn);
                  currentY = currentY + sepHeight;
                  this.uiApi.addComponentHook(btn,"onRollOver");
                  break;
               case item is ContextMenuItem:
                  asLabel = true;
                  asTexture = false;
                  uri = "";
                  if(item is ContextMenuPictureItem)
                  {
                     uri = ContextMenuPictureItem(item).uri;
                     asLabel = false;
                     asTexture = true;
                  }
                  else if(item is ContextMenuPictureLabelItem)
                  {
                     asTexture = true;
                     uri = ContextMenuPictureLabelItem(item).uri;
                  }
                  
                  cmi = item as ContextMenuItem;
                  btn = this.uiApi.createContainer("ButtonContainer");
                  ButtonContainer(btn).isMute = true;
                  btn.width = maxWidth;
                  btn.height = itemHeight;
                  btn.y = currentY;
                  btn.name = "btn" + (i + 1);
                  this.uiApi.me().registerId(btn.name,this.uiApi.createContainer("GraphicElement",btn,new Array(),btn.name));
                  this._orderedItems.push(btn);
                  puce = this.uiApi.createComponent("Texture") as Texture;
                  puce.width = 16;
                  puce.height = 16;
                  puce.y = 3;
                  puce.name = "puce" + i;
                  puce.uri = this.uiApi.createUri(this.uiApi.me().getConstant(cmi.radioStyle?"radio.uri":"selected.uri"));
                  puce.finalize();
                  btn.addChild(puce);
                  puce.alpha = 0;
                  this.uiApi.me().registerId(puce.name,this.uiApi.createContainer("GraphicElement",puce,new Array(),puce.name));
                  stateChangingProperties = new Array();
                  if((!cmi.child) || (!cmi.child.length))
                  {
                     stateChangingProperties[StatesEnum.STATE_SELECTED] = new Array();
                     stateChangingProperties[StatesEnum.STATE_SELECTED]["puce" + i] = new Array();
                     stateChangingProperties[StatesEnum.STATE_SELECTED]["puce" + i]["alpha"] = 1;
                     stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name] = new Array();
                     stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name]["bgColor"] = -1;
                  }
                  if(!cmi.disabled)
                  {
                     stateChangingProperties[StatesEnum.STATE_OVER] = new Array();
                     stateChangingProperties[StatesEnum.STATE_OVER][btn.name] = new Array();
                     stateChangingProperties[StatesEnum.STATE_OVER][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
                     if((!cmi.child) || (!cmi.child.length))
                     {
                        stateChangingProperties[StatesEnum.STATE_SELECTED_OVER] = new Array();
                        stateChangingProperties[StatesEnum.STATE_SELECTED_OVER]["puce" + i] = new Array();
                        stateChangingProperties[StatesEnum.STATE_SELECTED_OVER]["puce" + i]["alpha"] = 1;
                        stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][btn.name] = new Array();
                        stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
                        stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED] = stateChangingProperties[4];
                        stateChangingProperties[StatesEnum.STATE_OVER]["puce" + i] = new Array();
                        stateChangingProperties[StatesEnum.STATE_OVER]["puce" + i]["alpha"] = 0;
                     }
                  }
                  ButtonContainer(btn).changingStateData = stateChangingProperties;
                  if(asTexture)
                  {
                     btnTx = this.uiApi.createComponent("Texture") as Texture;
                     if((item is ContextMenuPictureLabelItem) && (item.txSize <= itemHeight))
                     {
                        btnTx.height = item.txSize;
                        btnTx.width = item.txSize;
                        btnTx.y = itemHeight / 2 - item.txSize / 2;
                     }
                     else
                     {
                        btnTx.height = itemHeight;
                        btnTx.width = itemHeight;
                        btnTx.y = 0;
                     }
                     uriArr = uri.split("?");
                     btnTx.uri = this.uiApi.createUri(uriArr[0]);
                     btnTx.x = xOffset;
                     if(uriArr.length == 2)
                     {
                        btnTx.gotoAndStop = parseInt(uriArr[1]);
                     }
                     btnTx.finalize();
                  }
                  if(asLabel)
                  {
                     btnLbl = this.uiApi.createComponent("Label") as Label;
                     btnLbl.width = maxWidth - xOffset;
                     btnLbl.height = itemHeight;
                     if(cmi.disabled)
                     {
                        btnLbl.cssClass = this.uiApi.me().getConstant("disabled.cssClass");
                     }
                     else
                     {
                        btnLbl.cssClass = this.uiApi.me().getConstant("item.cssClass");
                     }
                     btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
                     btnLbl.html = true;
                     btnLbl.useCustomFormat = true;
                     btnLbl.text = this.uiApi.replaceKey(cmi.label);
                     if(asTexture)
                     {
                        if((item is ContextMenuPictureLabelItem) && (item.pictureAfterLaber))
                        {
                           btnTx.x = btnLbl.x + (maxWidth - btnTx.width);
                           btnLbl.x = xOffset;
                        }
                        else
                        {
                           btnLbl.x = xOffset + btnTx.width;
                        }
                     }
                     else
                     {
                        btnLbl.x = xOffset;
                     }
                     btnLbl.y = -3;
                  }
                  if(!cmi.disabled)
                  {
                     if(cmi.child)
                     {
                        btnChildIcon = this.uiApi.createComponent("Texture") as Texture;
                        btnChildIcon.width = 10;
                        btnChildIcon.height = 10;
                        btnChildIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("rightArrow.uri"));
                        btnChildIcon.x = btnLbl.width - btnChildIcon.width;
                        btnChildIcon.y = (btn.height - btnChildIcon.height) / 2;
                        btnChildIcon.finalize();
                        btn.addChild(btnChildIcon);
                     }
                     this.uiApi.addComponentHook(btn,"onRollOver");
                     this.uiApi.addComponentHook(btn,"onRollOut");
                  }
                  if((!(cmi.callback == null)) || (cmi.child))
                  {
                     this.uiApi.addComponentHook(btn,"onRelease");
                  }
                  if(asTexture)
                  {
                     btn.addChild(btnTx);
                  }
                  if(asLabel)
                  {
                     btn.addChild(btnLbl);
                  }
                  ButtonContainer(btn).finalize();
                  currentY = currentY + itemHeight;
                  this._items[btn.name] = cmi;
                  this.mainCtr.addChild(btn);
                  ButtonContainer(btn).selected = cmi.selected;
                  break;
            }
            i++;
         }
         this.bgCtr.x = -1;
         this.bgCtr.y = -1;
         this.bgCtr.width = maxWidth + 2;
         this.bgCtr.height = currentY + 4;
         if(args is Array)
         {
            if(!args[1])
            {
               startPoint = new Point(this.uiApi.getMouseX() + 5,this.uiApi.getMouseY() + 5);
            }
            else
            {
               startPoint = new Point(args[1].x,args[1].y);
            }
            ContextMenuManager.getInstance().mainUiLoaded = true;
         }
         else
         {
            startPoint = new Point(args.x,args.y);
         }
         ContextMenuManager.getInstance().placeMe(this.uiApi.me(),this.mainCtr,startPoint);
      }
      
      public function selectParentOpenItem() : void {
         var s:Object = null;
         var parent:Object = ContextMenuManager.getInstance().getParent(this.uiApi.me());
         if(parent)
         {
            s = parent.uiClass.getOpenItem();
            if(s)
            {
               parent.uiClass.onRollOver(s,true);
            }
         }
      }
      
      public function getOpenItem() : Object {
         return this._openedItem;
      }
      
      public function unload() : void {
         this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.showHelp);
         this.uiApi.hideTooltip("contextMenuHelp");
      }
      
      public function onRelease(target:Object) : void {
         var tmpItem:Object = null;
         if(this._openedItem == target)
         {
            return;
         }
         var item:ContextMenuItem = this._items[target.name];
         if(this._openedItem)
         {
            this.closeChild();
         }
         if(!item)
         {
            return;
         }
         if((!item.disabled) && (!(item.callback == null)))
         {
            if((item.radioStyle) || (item.forceCloseOnSelect))
            {
               item.callback.apply(null,item.callbackArgs);
               if(!item.child)
               {
                  ContextMenuManager.getInstance().closeAll();
               }
            }
            else
            {
               for each(tmpItem in this._orderedItems)
               {
                  if(tmpItem != target)
                  {
                     if(this._radioStyle)
                     {
                        tmpItem.selected = false;
                     }
                  }
                  else if(!this._radioStyle)
                  {
                     item.callback.apply(null,item.callbackArgs);
                     target.selected = !target.selected;
                  }
                  else
                  {
                     if(!target.selected)
                     {
                        item.callback.apply(null,item.callbackArgs);
                     }
                     target.selected = true;
                  }
                  
               }
            }
         }
         else if((item.disabled) && (!(item.disabledCallback == null)))
         {
            item.disabledCallback.apply(null,item.disabledCallbackArgs);
         }
         
         if((item.child) && (!item.disabled) && (!(this.mainCtr == null)))
         {
            this._openTimer.reset();
            this._openedItem = target;
            target.selected = true;
            ContextMenuManager.getInstance().openChild(
               {
                  "menu":this._items[target.name].child,
                  "x":this.mainCtr.x + this.mainCtr.width,
                  "y":this.mainCtr.y + target.y
               });
         }
         if(!item.child)
         {
            item.selected = target.selected;
         }
      }
      
      public function onRollOver(target:Object, virtual:Boolean = false) : void {
         this._tooltipTimer.reset();
         this.selectParentOpenItem();
         if((this._items[target.name]) && (this._items[target.name].child))
         {
            this._openTimer.start();
         }
         if(ContextMenuManager.getInstance().childHasFocus(this.uiApi.me()))
         {
            this._closeTimer.start();
         }
         if(this._lastItemOver == target)
         {
            this._closeTimer.reset();
         }
         if(virtual)
         {
            this._lastOverIsVirtual = true;
            target.state = target.state + 1;
         }
         if((this._lastItemOver) && (this._lastOverIsVirtual))
         {
            this.onRollOut(this._lastItemOver,true);
         }
         var item:ContextMenuItem = this._items[target.name];
         if((item) && (item.help))
         {
            this._tooltipTimer.delay = item.helpDelay;
            this._tooltipTimer.start();
            this._currentHelpText = item.help;
         }
         ContextMenuManager.getInstance().setCurrentFocus(this.uiApi.me());
         this._lastItemOver = target;
         this._lastOverIsVirtual = virtual;
      }
      
      public function onRollOut(target:Object, virtual:Boolean = false) : void {
         this._tooltipTimer.reset();
         this.uiApi.hideTooltip("contextMenuHelp");
         if(this._openedItem)
         {
            this._closeTimer.start();
         }
         this._openTimer.reset();
         if((virtual) && (target.hasOwnProperty("state")))
         {
            target.state = target.state - 1;
         }
      }
      
      public function showHelp(e:Event) : void {
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this._currentHelpText),ContextMenuManager.getInstance().getTopParent().getElement("mainCtr"),false,"contextMenuHelp",2,0,3,null,null,null,"TextInfo");
      }
      
      private function openChild(e:Event = null) : void {
         this._openTimer.reset();
         this.onRelease(this._lastItemOver);
      }
      
      private function closeChild(e:Event = null) : void {
         if((!this.uiApi) || (ContextMenuManager.getInstance().childHasFocus(this.uiApi.me())))
         {
            return;
         }
         this._openedItem.selected = false;
         this._closeTimer.reset();
         this._openedItem = null;
         ContextMenuManager.getInstance().closeChild(this.uiApi.me());
      }
      
      private function initTimer() : void {
         this._tooltipTimer = new Timer(1000,1);
         this._tooltipTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.showHelp);
         this._openTimer = new Timer(parseInt(this.uiApi.me().getConstant("timer.open")),1);
         this._openTimer.addEventListener(TimerEvent.TIMER,this.openChild);
         this._closeTimer = new Timer(parseInt(this.uiApi.me().getConstant("timer.close")),1);
         this._closeTimer.addEventListener(TimerEvent.TIMER,this.closeChild);
      }
      
      private function addToIndex(index:int) : void {
         var currentIndex:int = -1;
         if(this._lastItemOver)
         {
            currentIndex = this._orderedItems.indexOf(this._lastItemOver);
         }
         if(currentIndex == -1)
         {
            currentIndex = 0;
         }
         else
         {
            currentIndex = (currentIndex + index) % this._orderedItems.length;
            if(currentIndex == -1)
            {
               currentIndex = this._orderedItems.length - 1;
            }
         }
         var btn:Object = this._orderedItems[currentIndex];
         if(btn)
         {
            if(this._lastItemOver)
            {
               this.onRollOut(this._lastItemOver);
            }
            this.onRollOver(btn,true);
            this._lastItemOver = btn;
         }
      }
      
      private function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               if(this._lastItemOver)
               {
                  this.onRelease(this._lastItemOver);
               }
               ContextMenuManager.getInstance().closeAll();
               return true;
            case "upArrow":
               this.addToIndex(-1);
               return true;
            case "downArrow":
               this.addToIndex(1);
               return true;
            case "closeUi":
               ContextMenuManager.getInstance().closeAll();
               return true;
            default:
               return true;
         }
      }
   }
}
