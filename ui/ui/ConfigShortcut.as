package ui
{
   import d2api.BindsApi;
   import d2components.Grid;
   import d2components.ComboBox;
   import d2components.ButtonContainer;
   import flash.utils.Dictionary;
   import d2data.Shortcut;
   import d2actions.*;
   import d2hooks.*;
   import d2data.Bind;
   import d2enums.ComponentHookList;
   import d2enums.LocationEnum;
   
   public class ConfigShortcut extends ConfigUi
   {
      
      public function ConfigShortcut() {
         this._categoryCheckboxStates = new Dictionary();
         this._categoryCheckboxComponents = new Dictionary();
         this._lblShortcutNames = new Dictionary(true);
         this._buttonsList = new Dictionary();
         this._bindsList = new Dictionary();
         this._shortcutsList = new Dictionary();
         this._shortcutsCat = new Dictionary();
         super();
      }
      
      public var bindsApi:BindsApi;
      
      public var modCommon:Object;
      
      public var grid:Grid;
      
      public var cbKeyboard:ComboBox;
      
      public var btn_clearShortcuts:ButtonContainer;
      
      private var _lastSelectedIndex:int;
      
      private var _categoryCheckboxStates:Dictionary;
      
      private var _categoryCheckboxComponents:Dictionary;
      
      private var _lblShortcutNames:Dictionary;
      
      private var _buttonsList:Dictionary;
      
      private var _bindsList:Dictionary;
      
      private var _shortcutsList:Dictionary;
      
      private var _savedData:Dictionary;
      
      private var _currentShortcut:Shortcut;
      
      private var _shortcutsCat:Dictionary;
      
      public function main(args:*) : void {
         var o:Object = null;
         var lastCat:String = null;
         var i:uint = 0;
         var selectedIndex:uint = 0;
         var keyboard:Object = null;
         var s:Object = null;
         var categoryIndex:* = 0;
         var nbCategoryShortcuts:* = 0;
         var j:* = 0;
         var len:* = 0;
         var description:String = null;
         this._savedData = sysApi.getData("openShortcutsCategory");
         if(this._savedData == null)
         {
            this._savedData = new Dictionary();
         }
         var shortcuts:Array = new Array();
         var src:Object = this.bindsApi.getShortcut();
         var newScr:Array = new Array();
         for each(o in src)
         {
            newScr.push(o);
         }
         newScr.sortOn("unicID",Array.NUMERIC);
         i = 0;
         i = 0;
         while(i < newScr.length)
         {
            s = newScr[i];
            if(s.category.name != lastCat)
            {
               categoryIndex = shortcuts.indexOf(s.category.description);
               if(categoryIndex == -1)
               {
                  shortcuts.push(s.category.description?s.category.description:"");
                  shortcuts.push(s);
                  lastCat = s.category.name;
                  this._shortcutsCat[s.category.description] = lastCat;
               }
               else
               {
                  nbCategoryShortcuts = 0;
                  j = categoryIndex;
                  len = shortcuts.length;
                  while(++j < len)
                  {
                     if(!(shortcuts[j] is String))
                     {
                        nbCategoryShortcuts++;
                        continue;
                     }
                     break;
                  }
                  shortcuts.splice(categoryIndex + nbCategoryShortcuts + 1,0,s);
               }
            }
            else
            {
               shortcuts.push(s);
            }
            i++;
         }
         this.grid.dataProvider = shortcuts;
         var cbProvider:Array = new Array();
         var avaibleKeyboard:Object = this.bindsApi.avaibleKeyboard();
         i = 0;
         for each(keyboard in avaibleKeyboard)
         {
            description = keyboard.description;
            description = description.substr(1,description.length - 2);
            cbProvider.push(
               {
                  "label":uiApi.getText(description),
                  "value":keyboard.locale
               });
            if(keyboard.locale == this.bindsApi.getCurrentLocale())
            {
               selectedIndex = i;
            }
            i++;
         }
         this._lastSelectedIndex = selectedIndex;
         uiApi.addComponentHook(this.cbKeyboard,"onSelectItem");
         this.cbKeyboard.dataProvider = cbProvider;
         this.cbKeyboard.selectedIndex = selectedIndex;
         sysApi.addHook(ShortcutUpdate,this.onShortcutUpdate);
      }
      
      override public function reset() : void {
         this.bindsApi.resetAllBinds();
         this.grid.updateItems();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var btns:Array = null;
         var clbk:Array = null;
         if(this.bindsApi.getCurrentLocale() != this.cbKeyboard.value.value)
         {
            btns = [uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")];
            clbk = [this.onKeyboardConfirm,this.onKeyboardCancel];
            this.modCommon.openPopup(uiApi.getText("ui.common.confirm"),uiApi.getText("ui.config.shortcut.confirm.changeKeyboard"),btns,clbk,this.onKeyboardConfirm,this.onKeyboardCancel);
         }
      }
      
      public function onDoubleClick(target:Object) : void {
         if(target.name.indexOf("btn_deactivateShortcuts") != -1)
         {
            this.handleCheckboxClick(target);
         }
      }
      
      override public function onRelease(target:Object) : void {
         if(target == this.btn_clearShortcuts)
         {
            this.modCommon.openPopup(uiApi.getText("ui.common.confirm"),uiApi.getText("ui.popup.confirmCancelShortcuts"),[uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")],[this.onClearShortcuts,null]);
         }
         else if(target.name.indexOf("btn_deactivateShortcuts") != -1)
         {
            this.handleCheckboxClick(target);
         }
         else
         {
            this._currentShortcut = this._shortcutsList[target];
            uiApi.loadUi("configShortcutPopup",null,
               {
                  "callback":this.onChangeShortcut,
                  "shortcut":this._currentShortcut,
                  "bind":this._bindsList[target]
               },3);
         }
         
         super.onRelease(target);
      }
      
      private function onClearShortcuts() : void {
         var b:Bind = null;
         var shortcut:Object = null;
         var tab:Array = new Array();
         for each(shortcut in this.grid.dataProvider)
         {
            if((!(shortcut is String)) && (Shortcut(shortcut).visible) && (Shortcut(shortcut).bindable))
            {
               b = this.bindsApi.getShortcutBind(shortcut.name,false);
               if((b) && (!(b.key == null)) && (!b.disabled))
               {
                  this.bindsApi.removeShortcutBind(shortcut.name);
               }
            }
            tab.push(shortcut);
         }
         this.grid.dataProvider = tab;
      }
      
      private function handleCheckboxClick(target:Object) : void {
         var key:String = null;
         var index:* = 0;
         for(key in this._categoryCheckboxComponents)
         {
            if(this._categoryCheckboxComponents[key] == target)
            {
               this._categoryCheckboxStates[key] = target.selected;
               break;
            }
         }
         index = this.grid.dataProvider.indexOf(key);
         if(index != -1)
         {
            this._savedData[this._shortcutsCat[key]] = target.selected;
            this.deactivateShortcutsFromCategory(index + 1,!target.selected);
         }
      }
      
      private function deactivateShortcutsFromCategory(index:int, val:Boolean, disableButton:Boolean = true) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onChangeShortcut(pBind:Bind) : void {
         if(this._currentShortcut == null)
         {
            trace("ERROR");
         }
         if(pBind != null)
         {
            this.bindsApi.setShortcutBind(this._currentShortcut.name,pBind.key,pBind.alt,pBind.ctrl,pBind.shift);
         }
         else
         {
            this.bindsApi.removeShortcutBind(this._currentShortcut.name);
         }
         this._currentShortcut = null;
      }
      
      private function onKeyboardConfirm() : void {
         this.bindsApi.changeKeyboard(this.cbKeyboard.value.value);
         this._lastSelectedIndex = this.cbKeyboard.selectedIndex;
      }
      
      private function onKeyboardCancel() : void {
         this.cbKeyboard.selectedIndex = this._lastSelectedIndex;
      }
      
      public function updateConfigLine(data:*, componentsRef:*, selected:Boolean) : void {
         var key:String = null;
         var index:* = 0;
         var savedValue:* = false;
         var currentBind:Bind = null;
         if(data)
         {
            if(data is String)
            {
               for(key in this._categoryCheckboxComponents)
               {
                  if((!(key == data)) && (this._categoryCheckboxComponents[key] == componentsRef.btn_deactivateShortcuts))
                  {
                     this._categoryCheckboxComponents[key] = null;
                     break;
                  }
               }
               componentsRef.lblDescription.cssClass = "oppositebold";
               componentsRef.lblDescription.text = data;
               componentsRef.btnAssoc.visible = false;
               componentsRef.shortcutLine.bgColor = sysApi.getConfigEntry("colors.grid.title");
               componentsRef.btn_label_btn_deactivateShortcuts.fullWidth();
               componentsRef.btn_deactivateShortcuts.x = componentsRef.shortcutLine.contentWidth - componentsRef.btn_label_btn_deactivateShortcuts.textWidth - 35;
               if(this._categoryCheckboxStates[data] == null)
               {
                  index = this.grid.dataProvider.indexOf(data);
                  if(this._savedData[this._shortcutsCat[data]] != null)
                  {
                     savedValue = this._savedData[this._shortcutsCat[data]];
                     this._categoryCheckboxStates[data] = savedValue;
                     if(!savedValue)
                     {
                        this.deactivateShortcutsFromCategory(index + 1,true,false);
                     }
                     componentsRef.btn_deactivateShortcuts.selected = savedValue;
                  }
                  else
                  {
                     this._savedData[this._shortcutsCat[data]] = true;
                     this._categoryCheckboxStates[data] = true;
                     componentsRef.btn_deactivateShortcuts.selected = true;
                  }
               }
               else
               {
                  if(this._categoryCheckboxComponents[data] != componentsRef.btn_deactivateShortcuts)
                  {
                     componentsRef.btn_deactivateShortcuts.selected = this._categoryCheckboxStates[data];
                  }
                  this._savedData[this._shortcutsCat[data]] = componentsRef.btn_deactivateShortcuts.selected;
                  this._categoryCheckboxComponents[data] = componentsRef.btn_deactivateShortcuts;
                  uiApi.addComponentHook(componentsRef.btn_deactivateShortcuts,"onRelease");
                  uiApi.addComponentHook(componentsRef.btn_deactivateShortcuts,"onDoubleClick");
               }
               componentsRef.btn_deactivateShortcuts.visible = true;
            }
            else
            {
               componentsRef.lblDescription.cssClass = "p";
               componentsRef.btnAssoc.state = 0;
               componentsRef.lblDescription.text = data.description;
               componentsRef.btn_lbl_btnAssoc.html = false;
               currentBind = this.bindsApi.getShortcutBind(data.name,true);
               componentsRef.btn_lbl_btnAssoc.text = (currentBind) && (currentBind.key)?currentBind.toString():"(" + uiApi.getText("ui.common.none") + ")";
               componentsRef.btnAssoc.visible = true;
               componentsRef.shortcutLine.bgColor = -1;
               componentsRef.lblDescription.visible = true;
               componentsRef.btn_deactivateShortcuts.visible = false;
               componentsRef.btnAssoc.disabled = this.bindsApi.bindIsPermanent(currentBind) || data.disable;
               componentsRef.btnAssoc.reset();
               this._buttonsList[data] = 
                  {
                     "button":componentsRef.btnAssoc,
                     "label":componentsRef.btn_lbl_btnAssoc
                  };
               this._bindsList[componentsRef.btnAssoc] = currentBind;
               this._shortcutsList[componentsRef.btnAssoc] = data;
               uiApi.addComponentHook(componentsRef.btnAssoc,"onRelease");
               if(!this._lblShortcutNames[componentsRef.lblDescription.name])
               {
                  uiApi.addComponentHook(componentsRef.lblDescription,ComponentHookList.ON_ROLL_OVER);
                  uiApi.addComponentHook(componentsRef.lblDescription,ComponentHookList.ON_ROLL_OUT);
               }
               this._lblShortcutNames[componentsRef.lblDescription.name] = data.tooltipContent;
            }
         }
         else
         {
            componentsRef.lblDescription.cssClass = "p";
            componentsRef.btnAssoc.visible = false;
            componentsRef.lblDescription.visible = false;
         }
      }
      
      private function onShortcutUpdate(target:String, bind:Bind) : void {
         var btn:Object = null;
         if(this._currentShortcut != null)
         {
            btn = this._buttonsList[this._currentShortcut];
            btn.button.state = 0;
            btn.label.text = (!(bind == null)) && (!(bind.key == null))?bind.toString():"(" + uiApi.getText("ui.common.none") + ")";
            btn.button.reset();
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         if(target.name.indexOf("lblDescription") != -1)
         {
            text = this._lblShortcutNames[target.name];
         }
         if(text)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         uiApi.hideTooltip();
      }
   }
}
