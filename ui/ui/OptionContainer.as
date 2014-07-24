package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.SoundApi;
   import d2components.ScrollContainer;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import options.OptionManager;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2actions.*;
   import d2hooks.*;
   
   public class OptionContainer extends Object
   {
      
      public function OptionContainer() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      public var uiCtr:ScrollContainer;
      
      public var lblOptTitle:Label;
      
      public var lblOptDescription:Label;
      
      public var btnDefault:ButtonContainer;
      
      public var btnClose2:ButtonContainer;
      
      public var listOpt:Grid;
      
      public var btnClose:ButtonContainer;
      
      private var _subUi:Object;
      
      private var _currentSubUiId:String;
      
      public function main(tab:String) : void {
         var optionManager:OptionManager = null;
         var i:uint = 0;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.listOpt.autoSelectMode = 0;
         this.listOpt.dataProvider = OptionManager.getInstance().items;
         this.btnDefault.soundId = SoundEnum.SPEC_BUTTON;
         this.btnClose2.soundId = SoundEnum.CANCEL_BUTTON;
         this.uiApi.addComponentHook(this.listOpt,"onSelectItem");
         this.uiApi.addComponentHook(this.btnDefault,"onRelease");
         this.uiApi.addComponentHook(this.btnClose,"onRelease");
         this.uiApi.addComponentHook(this.btnClose2,"onRelease");
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiCtr.verticalScrollSpeed = 4;
         if(tab)
         {
            optionManager = OptionManager.getInstance();
            i = 0;
            while(i < optionManager.items.length)
            {
               if(optionManager.items[i].id == tab)
               {
                  this.listOpt.selectedIndex = i;
                  break;
               }
               i++;
            }
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var item:Object = this.listOpt.selectedItem;
         if(this._currentSubUiId == item.ui)
         {
            return;
         }
         this.lblOptTitle.text = item.name;
         this.lblOptDescription.text = item.description;
         if(this._subUi)
         {
            this.uiApi.unloadUi(this._subUi.name);
         }
         if(item.ui)
         {
            this.uiCtr.verticalScrollbarValue = 0;
            this.btnDefault.visible = true;
            this._subUi = this.uiApi.loadUiInside(item.ui,this.uiCtr,"subConfigUi",null);
            this._currentSubUiId = item.ui;
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btnDefault:
               if((this._subUi) && (Object(this._subUi.uiClass).hasOwnProperty("reset")))
               {
                  this._subUi.uiClass.reset();
               }
               break;
            case this.btnClose:
            case this.btnClose2:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
         }
      }
      
      public function unload() : void {
         if(this._subUi)
         {
            this.uiApi.hideTooltip();
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
            this.uiApi.unloadUi(this._subUi.name);
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "optionMenu1":
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
         }
         return true;
      }
      
      public function onPopupClose() : void {
      }
      
      public function onSelectiveClearCache() : void {
         this.sysApi.clearCache(true);
      }
      
      public function onCompleteClearCache() : void {
         this.sysApi.clearCache(false);
      }
   }
}
