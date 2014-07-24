package ui
{
   import flash.utils.Dictionary;
   import d2components.Grid;
   import d2components.Label;
   import d2components.TextArea;
   import d2components.Texture;
   import types.ConfigProperty;
   import d2hooks.*;
   import d2actions.*;
   
   public class ConfigTheme extends ConfigUi
   {
      
      public function ConfigTheme() {
         this._themeBtnList = new Dictionary(true);
         super();
      }
      
      public var output:Object;
      
      public var modCommon:Object;
      
      private var _skins:Array;
      
      private var _choosenSkin:String;
      
      private var _selectedThemeName:String;
      
      private var _themeBtnList:Dictionary;
      
      public var grid_theme:Grid;
      
      public var lbl_name:Label;
      
      public var lbl_description:TextArea;
      
      public var tx_preview:Texture;
      
      public function main(args:*) : void {
         var skin:* = undefined;
         var properties:Array = new Array();
         properties.push(new ConfigProperty("grid_theme","switchUiSkin","dofus"));
         init(properties);
         this._selectedThemeName = configApi.getCurrentTheme();
         this._skins = new Array();
         var selected:uint = 1;
         var i:uint = 0;
         for each(skin in configApi.getAllThemes())
         {
            this._skins.push(skin);
            if(skin.fileName == this._selectedThemeName)
            {
               selected = i;
            }
            i++;
         }
         this.grid_theme.dataProvider = this._skins;
         this.grid_theme.selectedIndex = selected;
         showDefaultBtn(false);
      }
      
      public function unload() : void {
      }
      
      private function saveOptions() : void {
      }
      
      private function undoOptions() : void {
      }
      
      private function displayTheme(theme:*) : void {
         var desc:String = theme.description;
         if((!(desc.indexOf("[") == -1)) && (!(desc.indexOf("]") == -1)))
         {
            desc = uiApi.getText(desc.slice(1,-1));
         }
         this.lbl_description.text = desc;
         var name:String = theme.name;
         if((!(name.indexOf("[") == -1)) && (!(name.indexOf("]") == -1)))
         {
            name = uiApi.getText(name.slice(1,-1));
         }
         this.lbl_name.text = name;
         if(theme.previewUri != "")
         {
            this.tx_preview.uri = uiApi.createUri(sysApi.getConfigEntry("config.content.path") + "themes/" + theme.fileName + "/bitmap/" + theme.previewUri);
         }
         else
         {
            this.tx_preview.uri = null;
         }
      }
      
      public function updateThemeLine(data:*, componentsRef:*, selected:Boolean) : void {
         var theme:Object = null;
         var name:String = null;
         if(!this._themeBtnList[componentsRef.btn_selectTheme.name])
         {
            uiApi.addComponentHook(componentsRef.btn_selectTheme,"onRelease");
         }
         this._themeBtnList[componentsRef.btn_selectTheme.name] = data;
         if(data)
         {
            componentsRef.btn_theme.visible = true;
            componentsRef.btn_theme.selected = selected;
            componentsRef.btn_theme.state = selected?sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED:sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_NORMAL;
            theme = data;
            name = theme.name;
            if((!(name.indexOf("[") == -1)) && (!(name.indexOf("]") == -1)))
            {
               name = uiApi.getText(name.slice(1,-1));
            }
            componentsRef.lbl_name.text = name;
            componentsRef.btn_selectTheme.visible = true;
            componentsRef.btn_selectTheme.selected = this._selectedThemeName == theme.fileName;
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.btn_selectTheme.selected = false;
            componentsRef.btn_selectTheme.visible = false;
            componentsRef.btn_theme.visible = false;
         }
      }
      
      override public function onRelease(target:Object) : void {
         if((!(target.name.indexOf("btn_selectTheme") == -1)) && (!(this._themeBtnList[target.name].fileName == this._selectedThemeName)))
         {
            this._choosenSkin = this._themeBtnList[target.name].fileName;
            this.modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.option.resetGameForNewSkin"),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmChangeSkin,null]);
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         switch(target)
         {
            case this.grid_theme:
               this.displayTheme(this.grid_theme.selectedItem);
               break;
         }
      }
      
      public function onConfirmChangeSkin() : void {
         setProperty("dofus","switchUiSkin",this._choosenSkin);
         sysApi.clearCache(true);
      }
      
      public function onRollOver(target:Object) : void {
         uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.option.themeApply")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         uiApi.hideTooltip();
      }
   }
}
