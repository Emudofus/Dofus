package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.berilia.components.messages.RenameTabMessage;
   import com.ankamagames.berilia.components.messages.CreateTabMessage;
   import com.ankamagames.berilia.components.messages.DeleteTabMessage;
   import flash.ui.Keyboard;
   
   public class TabSet extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function TabSet() {
         super();
         this._aTabsList = new Array();
         this._aCtrs = new Array();
         this._aCloses = new Array();
         this._aLbls = new Array();
         this._aInputs = new Array();
         this._tabCtr = new GraphicContainer();
         this._tabCtr.width = __width;
         this._tabCtr.height = __height;
         addChild(this._tabCtr);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TabSet));
      
      private var _nSelected:int = -1;
      
      private var _nPreviousSelected:int = -1;
      
      private var _nNbTabs:uint = 0;
      
      private var _nTotalWidth:uint = 0;
      
      private var _nNbTabsRequired:uint;
      
      private var _nCurrentMaxIndex:uint = 0;
      
      private var _aTabsList:Array;
      
      private var _aCtrs:Array;
      
      private var _aCloses:Array;
      
      private var _aLbls:Array;
      
      private var _aInputs:Array;
      
      private var _uiClass:UiRootContainer;
      
      private var _tabCtr:GraphicContainer;
      
      private var _btnPlus:ButtonContainer;
      
      private var _sBgTextureUri:Uri;
      
      private var _sCloseTextureUri:Uri;
      
      private var _sPlusTextureUri:Uri;
      
      private var _sTabCss:Uri;
      
      private var _nWidthTab:int;
      
      private var _nWidthLabel:int;
      
      private var _nHeightLabel:int;
      
      private var _nWidthPlusTab:int;
      
      private var _nXCloseTab:int;
      
      private var _nYCloseTab:int;
      
      private var _nXPlusTab:int;
      
      private var _nYPlusTab:int;
      
      private var _nXLabelTab:int;
      
      private var _nYLabelTab:int;
      
      private var _finalized:Boolean = false;
      
      private var _bNameEdition:Boolean = false;
      
      public function get widthTab() : int {
         return this._nWidthTab;
      }
      
      public function set widthTab(param1:int) : void {
         this._nWidthTab = param1;
      }
      
      public function get widthLabel() : int {
         return this._nWidthLabel;
      }
      
      public function set widthLabel(param1:int) : void {
         this._nWidthLabel = param1;
      }
      
      public function get heightLabel() : int {
         return this._nHeightLabel;
      }
      
      public function set heightLabel(param1:int) : void {
         this._nHeightLabel = param1;
      }
      
      public function get widthPlusTab() : int {
         return this._nWidthPlusTab;
      }
      
      public function set widthPlusTab(param1:int) : void {
         this._nWidthPlusTab = param1;
      }
      
      public function get tabUri() : Uri {
         return this._sBgTextureUri;
      }
      
      public function set tabUri(param1:Uri) : void {
         this._sBgTextureUri = param1;
      }
      
      public function get closeUri() : Uri {
         return this._sCloseTextureUri;
      }
      
      public function set closeUri(param1:Uri) : void {
         this._sCloseTextureUri = param1;
      }
      
      public function get plusUri() : Uri {
         return this._sPlusTextureUri;
      }
      
      public function set plusUri(param1:Uri) : void {
         this._sPlusTextureUri = param1;
      }
      
      public function get cssUri() : Uri {
         return this._sTabCss;
      }
      
      public function set cssUri(param1:Uri) : void {
         this._sTabCss = param1;
      }
      
      public function get xClose() : int {
         return this._nXCloseTab;
      }
      
      public function set xClose(param1:int) : void {
         this._nXCloseTab = param1;
      }
      
      public function get yClose() : int {
         return this._nYCloseTab;
      }
      
      public function set yClose(param1:int) : void {
         this._nYCloseTab = param1;
      }
      
      public function get xLabel() : int {
         return this._nXLabelTab;
      }
      
      public function set xLabel(param1:int) : void {
         this._nXLabelTab = param1;
      }
      
      public function get yLabel() : int {
         return this._nYLabelTab;
      }
      
      public function set yLabel(param1:int) : void {
         this._nYLabelTab = param1;
      }
      
      public function get xPlus() : int {
         return this._nXPlusTab;
      }
      
      public function set xPlus(param1:int) : void {
         this._nXPlusTab = param1;
      }
      
      public function get yPlus() : int {
         return this._nYPlusTab;
      }
      
      public function set yPlus(param1:int) : void {
         this._nYPlusTab = param1;
      }
      
      public function get length() : int {
         return this._nNbTabs;
      }
      
      public function set length(param1:int) : void {
         this._nNbTabsRequired = param1;
         if((this._btnPlus) && this._nNbTabsRequired >= 1)
         {
            if(this._nNbTabsRequired > this._nNbTabs)
            {
               while(this._nNbTabsRequired > this._nNbTabs)
               {
                  this.addTab();
               }
            }
            if(this._nNbTabsRequired < this._nNbTabs)
            {
               while(this._nNbTabsRequired < this._nNbTabs)
               {
                  this.removeTab();
               }
            }
         }
      }
      
      public function get tabCtr() : GraphicContainer {
         return this._tabCtr;
      }
      
      public function set tabCtr(param1:GraphicContainer) : void {
         this._tabCtr = param1;
      }
      
      public function get selectedTab() : int {
         return this._nSelected;
      }
      
      public function set selectedTab(param1:int) : void {
         if(!this._aCtrs[param1])
         {
            if(param1 < 0)
            {
               this.selectedTab = ++param1;
            }
            else
            {
               this.selectedTab = --param1;
            }
         }
         this._nPreviousSelected = this._nSelected;
         this._nSelected = param1;
         if(!(this._nPreviousSelected == -1) && (this._aCtrs[this._nPreviousSelected]))
         {
            this._aCtrs[this._nPreviousSelected].selected = false;
            this._aCloses[this._nPreviousSelected].visible = false;
            this._aLbls[this._nPreviousSelected].cssClass = "p";
         }
         if(this._nSelected != -1)
         {
            this._aCtrs[this._nSelected].selected = false;
            this._aCtrs[this._nSelected].selected = true;
            this._aCloses[this._nSelected].visible = true;
         }
         if(UIEventManager.getInstance().isRegisteredInstance(this,SelectItemMessage))
         {
            Berilia.getInstance().handler.process(new SelectItemMessage(this,this._aCtrs[this._nSelected]));
         }
      }
      
      public function get lastTab() : int {
         return this._nNbTabs-1;
      }
      
      public function set dataProvider(param1:*) : void {
         if(!this.isIterable(param1))
         {
            throw new ArgumentError("dataProvider must be either Array or Vector.");
         }
         else
         {
            this._aTabsList = param1;
            this.finalize();
            return;
         }
      }
      
      public function get dataProvider() : * {
         return this._aTabsList;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function finalize() : void {
         this._uiClass = getUi();
         if((this._aTabsList) && this._aTabsList.length > 0)
         {
            this._nNbTabs = this._aTabsList.length;
            if(this._nNbTabs > 0)
            {
               this.tabsDisplay();
            }
         }
         else
         {
            this.tabsDisplay();
         }
         this._finalized = true;
         if(this._uiClass)
         {
            this._uiClass.iAmFinalized(this);
         }
      }
      
      override public function remove() : void {
         if(!__removed)
         {
            this._uiClass = null;
            this._tabCtr.remove();
            this._btnPlus.remove();
            this._tabCtr = null;
            this._btnPlus = null;
         }
         super.remove();
      }
      
      public function highlight(param1:uint, param2:Boolean=true) : void {
         if(param2)
         {
            this._aLbls[param1].cssClass = "highlighted";
         }
         else
         {
            this._aLbls[param1].cssClass = "p";
         }
      }
      
      public function renameTab(param1:uint, param2:String=null) : void {
         this._aInputs[this._nSelected].text = "";
         this._aLbls[param1].caretIndex = 0;
         if(param1 >= this._nCurrentMaxIndex)
         {
            return;
         }
         if(this._aCtrs[param1].selected)
         {
            this._aCtrs[param1].selected = false;
            this._aLbls[param1].text = param2;
            this._aCtrs[param1].reset();
            this._aCtrs[param1].selected = true;
         }
         else
         {
            this._aLbls[param1].text = param2;
            this._aCtrs[param1].reset();
         }
      }
      
      private function tabsDisplay() : void {
         this.addPlusTab();
         this.addTab();
         this.length = this._nNbTabsRequired;
         this.selectedTab = 0;
      }
      
      private function addTab() : void {
         var _loc1_:ButtonContainer = new ButtonContainer();
         _loc1_.soundId = "16009";
         _loc1_.width = this._nWidthTab;
         _loc1_.height = __height;
         _loc1_.name = "btn_tab" + this._nCurrentMaxIndex;
         var _loc2_:Texture = new Texture();
         _loc2_.width = this._nWidthTab;
         _loc2_.height = __height;
         _loc2_.autoGrid = true;
         _loc2_.uri = this._sBgTextureUri;
         _loc2_.name = "tx_bgTab" + this._nCurrentMaxIndex;
         _loc2_.finalize();
         var _loc3_:Label = new Label();
         _loc3_.width = this._nWidthLabel;
         _loc3_.height = this._nHeightLabel;
         _loc3_.x = this._nXLabelTab;
         _loc3_.y = this._nYLabelTab;
         _loc3_.css = this._sTabCss;
         _loc3_.cssClass = "p";
         _loc3_.name = "lbl_tab" + this._nCurrentMaxIndex;
         _loc3_.text = "tab " + (this._nCurrentMaxIndex + 1);
         var _loc4_:Input = new Input();
         _loc4_.width = this._nWidthLabel;
         _loc4_.height = this._nHeightLabel;
         _loc4_.x = this._nXLabelTab;
         _loc4_.y = this._nYLabelTab;
         _loc4_.css = this._sTabCss;
         _loc4_.cssClass = "p";
         _loc4_.name = "inp_tab" + this._nCurrentMaxIndex;
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc4_);
         getUi().registerId(_loc1_.name,new GraphicElement(_loc1_,new Array(),_loc1_.name));
         getUi().registerId(_loc2_.name,new GraphicElement(_loc2_,new Array(),_loc2_.name));
         getUi().registerId(_loc3_.name,new GraphicElement(_loc3_,new Array(),_loc3_.name));
         getUi().registerId(_loc4_.name,new GraphicElement(_loc4_,new Array(),_loc4_.name));
         var _loc5_:Array = new Array();
         _loc5_[StatesEnum.STATE_OVER] = new Array();
         _loc5_[StatesEnum.STATE_OVER][_loc2_.name] = new Array();
         _loc5_[StatesEnum.STATE_OVER][_loc2_.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         _loc5_[StatesEnum.STATE_CLICKED] = new Array();
         _loc5_[StatesEnum.STATE_CLICKED][_loc2_.name] = new Array();
         _loc5_[StatesEnum.STATE_CLICKED][_loc2_.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         _loc5_[StatesEnum.STATE_SELECTED] = new Array();
         _loc5_[StatesEnum.STATE_SELECTED][_loc2_.name] = new Array();
         _loc5_[StatesEnum.STATE_SELECTED][_loc2_.name]["gotoAndStop"] = StatesEnum.STATE_SELECTED_STRING.toLocaleLowerCase();
         _loc5_[StatesEnum.STATE_SELECTED][_loc3_.name] = new Array();
         _loc5_[StatesEnum.STATE_SELECTED][_loc3_.name]["cssClass"] = "selected";
         _loc1_.changingStateData = _loc5_;
         _loc1_.finalize();
         var _loc6_:ButtonContainer = new ButtonContainer();
         _loc6_.x = this._nXCloseTab;
         _loc6_.y = this._nYCloseTab;
         _loc6_.width = this._nWidthPlusTab;
         _loc6_.height = __height;
         _loc6_.name = "btn_closeTab" + this._nCurrentMaxIndex;
         var _loc7_:Texture = new Texture();
         _loc7_.uri = this._sCloseTextureUri;
         _loc7_.name = "tx_closeTab" + this._nCurrentMaxIndex;
         _loc7_.finalize();
         _loc6_.addChild(_loc7_);
         getUi().registerId(_loc6_.name,new GraphicElement(_loc6_,new Array(),_loc6_.name));
         getUi().registerId(_loc7_.name,new GraphicElement(_loc7_,new Array(),_loc7_.name));
         var _loc8_:Array = new Array();
         _loc8_[StatesEnum.STATE_OVER] = new Array();
         _loc8_[StatesEnum.STATE_OVER][_loc7_.name] = new Array();
         _loc8_[StatesEnum.STATE_OVER][_loc7_.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         _loc8_[StatesEnum.STATE_CLICKED] = new Array();
         _loc8_[StatesEnum.STATE_CLICKED][_loc7_.name] = new Array();
         _loc8_[StatesEnum.STATE_CLICKED][_loc7_.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         _loc6_.changingStateData = _loc8_;
         _loc6_.finalize();
         _loc6_.visible = false;
         this._tabCtr.addChild(_loc1_);
         this._tabCtr.addChild(_loc6_);
         this._aCtrs[this._nNbTabs] = _loc1_;
         this._aCloses[this._nNbTabs] = _loc6_;
         this._aLbls[this._nNbTabs] = _loc3_;
         this._aInputs[this._nNbTabs] = _loc4_;
         this._nTotalWidth = this._nTotalWidth + this._nWidthTab;
         this._nCurrentMaxIndex++;
         this.replaceTab();
      }
      
      private function addPlusTab() : void {
         this._btnPlus = new ButtonContainer();
         this._btnPlus.soundId = "16090";
         this._btnPlus.width = this._nWidthPlusTab;
         this._btnPlus.height = __height;
         this._btnPlus.name = "btn_plus";
         var _loc1_:Texture = new Texture();
         _loc1_.width = this._nWidthPlusTab;
         _loc1_.height = __height;
         _loc1_.autoGrid = true;
         _loc1_.uri = this._sBgTextureUri;
         _loc1_.name = "tx_bgPlus";
         _loc1_.finalize();
         var _loc2_:Texture = new Texture();
         _loc2_.x = this._nXPlusTab;
         _loc2_.y = this._nYPlusTab;
         _loc2_.uri = this._sPlusTextureUri;
         _loc2_.name = "tx_plus";
         _loc2_.finalize();
         this._btnPlus.addChild(_loc1_);
         this._btnPlus.addChild(_loc2_);
         getUi().registerId(this._btnPlus.name,new GraphicElement(this._btnPlus,new Array(),this._btnPlus.name));
         getUi().registerId(_loc1_.name,new GraphicElement(_loc1_,new Array(),_loc1_.name));
         getUi().registerId(_loc2_.name,new GraphicElement(_loc2_,new Array(),_loc2_.name));
         addChild(this._btnPlus);
         var _loc3_:Array = new Array();
         _loc3_[StatesEnum.STATE_OVER] = new Array();
         _loc3_[StatesEnum.STATE_OVER][_loc1_.name] = new Array();
         _loc3_[StatesEnum.STATE_OVER][_loc1_.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         _loc3_[StatesEnum.STATE_OVER][_loc2_.name] = new Array();
         _loc3_[StatesEnum.STATE_OVER][_loc2_.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         _loc3_[StatesEnum.STATE_CLICKED] = new Array();
         _loc3_[StatesEnum.STATE_CLICKED][_loc1_.name] = new Array();
         _loc3_[StatesEnum.STATE_CLICKED][_loc1_.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         _loc3_[StatesEnum.STATE_CLICKED][_loc2_.name] = new Array();
         _loc3_[StatesEnum.STATE_CLICKED][_loc2_.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         this._btnPlus.changingStateData = _loc3_;
         this._btnPlus.finalize();
         this._nTotalWidth = this._nTotalWidth + this._nWidthPlusTab;
      }
      
      private function removeTab() : void {
         var _loc1_:* = 0;
         if(this._nNbTabs > 1)
         {
            _loc1_ = this._nSelected;
            this._nPreviousSelected = _loc1_-1;
            this.removeContainerContent(this._aCtrs[_loc1_]);
            this._aCtrs.splice(_loc1_,1);
            this.removeContainerContent(this._aCloses[_loc1_]);
            this._aCloses.splice(_loc1_,1);
            this._aLbls.splice(_loc1_,1);
            this._nTotalWidth = this._nTotalWidth - this._nWidthTab;
            this.replaceTab();
            this.selectedTab = this._nPreviousSelected;
         }
      }
      
      private function replaceTab() : void {
         var _loc2_:* = undefined;
         var _loc1_:* = 0;
         for (_loc2_ in this._aCtrs)
         {
            this._aCtrs[_loc2_].state = 0;
            this._aCtrs[_loc2_].x = _loc1_;
            this._aCloses[_loc2_].x = _loc1_ + this._nXCloseTab;
            this._aCtrs[_loc2_].reset();
            _loc1_ = _loc1_ + this._aCtrs[_loc2_].width;
         }
         this._btnPlus.x = _loc1_;
         if(this._nSelected == -1)
         {
            this.selectedTab = _loc2_;
         }
         this._nNbTabs = this._aCtrs.length;
         if(this._nTotalWidth + this._nWidthTab < __width)
         {
            this._btnPlus.visible = true;
         }
         else
         {
            this._btnPlus.visible = false;
         }
      }
      
      private function isIterable(param1:*) : Boolean {
         if(param1 is Array)
         {
            return true;
         }
         if(!(param1["length"] == null) && !(param1["length"] == 0) && !isNaN(param1["length"]) && !(param1[0] == null) && !(param1 is String))
         {
            return true;
         }
         return false;
      }
      
      private function removeContainerContent(param1:GraphicContainer) : void {
         param1.remove();
      }
      
      private function switchToEdition(param1:Boolean) : void {
         this._bNameEdition = param1;
         if(param1)
         {
            this._aInputs[this._nSelected].text = this._aLbls[this._nSelected].text;
            this._aInputs[this._nSelected].focus();
            this._aInputs[this._nSelected].setSelection(0,this._aInputs[this._nSelected].text.length);
         }
         this._aInputs[this._nSelected].disabled = !param1;
         this._aInputs[this._nSelected].visible = param1;
         this._aLbls[this._nSelected].visible = !param1;
      }
      
      override public function process(param1:Message) : Boolean {
         var _loc2_:MouseClickMessage = null;
         var _loc3_:MouseRightClickMessage = null;
         var _loc4_:KeyboardKeyUpMessage = null;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         switch(true)
         {
            case param1 is MouseClickMessage:
               _loc2_ = param1 as MouseClickMessage;
               if(this._bNameEdition)
               {
                  this._bNameEdition = false;
                  _loc5_ = this._aInputs[this._nSelected].text;
                  this.renameTab(this._nSelected,_loc5_);
                  if(UIEventManager.getInstance().isRegisteredInstance(this,RenameTabMessage))
                  {
                     Berilia.getInstance().handler.process(new RenameTabMessage(this,this._nSelected,_loc5_));
                  }
               }
               switch(_loc2_.target.name)
               {
                  case this._btnPlus.name:
                     if(this._nTotalWidth + this._nWidthTab < __width)
                     {
                        this.addTab();
                        this.selectedTab = this._nNbTabs-1;
                        if(UIEventManager.getInstance().isRegisteredInstance(this,CreateTabMessage))
                        {
                           Berilia.getInstance().handler.process(new CreateTabMessage(this));
                        }
                     }
                     break;
                  default:
                     for (_loc6_ in this._aCtrs)
                     {
                        if(_loc2_.target == this._aCtrs[_loc6_])
                        {
                           this.selectedTab = _loc6_;
                        }
                     }
                     if(_loc2_.target == this._aCloses[this._nSelected])
                     {
                        if(this._nNbTabs > 1)
                        {
                           if(UIEventManager.getInstance().isRegisteredInstance(this,DeleteTabMessage))
                           {
                              Berilia.getInstance().handler.process(new DeleteTabMessage(this,this._nSelected));
                           }
                           this.removeTab();
                        }
                     }
               }
               break;
            case param1 is MouseRightClickMessage:
               _loc3_ = param1 as MouseRightClickMessage;
               if(_loc3_.target == this._aCtrs[this._nSelected] && !this._bNameEdition)
               {
                  this.switchToEdition(true);
               }
               else
               {
                  if(this._bNameEdition)
                  {
                     this.switchToEdition(false);
                  }
               }
               break;
            case param1 is KeyboardKeyUpMessage:
               _loc4_ = param1 as KeyboardKeyUpMessage;
               if(this._bNameEdition)
               {
                  if(_loc4_.keyboardEvent.keyCode == Keyboard.ENTER)
                  {
                     this._bNameEdition = false;
                     _loc7_ = this._aInputs[this._nSelected].text;
                     this.renameTab(this._nSelected,_loc7_);
                     if(UIEventManager.getInstance().isRegisteredInstance(this,RenameTabMessage))
                     {
                        Berilia.getInstance().handler.process(new RenameTabMessage(this,this._nSelected,_loc7_));
                     }
                  }
                  else
                  {
                     if(_loc4_.keyboardEvent.keyCode == Keyboard.ESCAPE)
                     {
                        this.switchToEdition(false);
                     }
                  }
               }
               break;
         }
         return false;
      }
   }
}
