package ui.item
{
   import d2components.Texture;
   import d2api.UiApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2actions.*;
   import d2hooks.*;
   import d2enums.ComponentHookList;
   
   public class ModuleItem extends Object
   {
      
      public function ModuleItem() {
         super();
      }
      
      private static var lastSelectedTexture:Texture;
      
      private static var currentlySelectedData:Object;
      
      public var uiApi:UiApi;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_name:Label;
      
      public var lbl_lastUpdate:Label;
      
      public var btn_install:ButtonContainer;
      
      public var btn_delete:ButtonContainer;
      
      public var btn_update:ButtonContainer;
      
      public var tx_bg:Texture;
      
      public var tx_selected:Texture;
      
      public var modCommon:Object;
      
      private var _data:Object;
      
      private var _selected:Boolean;
      
      private var _uiClass:Object;
      
      public function main(oParam:Object = null) : void {
         this._data = oParam.data;
         this._selected = oParam.selected;
         this._uiClass = oParam.grid.getUi().uiClass;
         this.update(this._data,this._selected);
         this.uiApi.addComponentHook(this.mainCtr,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.mainCtr,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.mainCtr,ComponentHookList.ON_RELEASE);
      }
      
      public function unload() : void {
      }
      
      public function get data() : Object {
         return this._data;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function update(data:Object, selected:Boolean) : void {
         this._data = data;
         if(data)
         {
            this.lbl_name.text = data.name + " (" + data.author + ")";
            this.lbl_lastUpdate.text = data.lastUpdateDate;
            this.btn_delete.visible = data.exist;
            this.btn_install.visible = !data.exist;
            this.btn_update.visible = (!this.btn_install.visible) && (!data.upToDate);
            this.tx_bg.visible = data.exist;
            this.tx_bg.bgColor = data.upToDate?6074716:14633259;
         }
         else
         {
            this.lbl_name.text = "";
            this.lbl_lastUpdate.text = "";
            this.btn_delete.visible = false;
            this.btn_install.visible = false;
            this.btn_update.visible = false;
            this.tx_bg.visible = false;
         }
         this.tx_selected.visible = selected;
         lastSelectedTexture = this.tx_selected;
      }
      
      public function onRelease(target:Object) : void {
         if((this._data) && (!(currentlySelectedData == this._data)))
         {
            this._uiClass.showModuleDetails(this._data);
            if(lastSelectedTexture)
            {
               lastSelectedTexture.visible = false;
            }
            currentlySelectedData = this._data;
            this.tx_selected.visible = true;
            lastSelectedTexture = this.tx_selected;
         }
         switch(target)
         {
            case this.btn_install:
               this._uiClass.startInstall(this._data);
               break;
            case this.btn_delete:
               this.modCommon.openPopup(this.uiApi.getText("ui.module.marketplace.uninstallmodule"),this.uiApi.getText("ui.module.marketplace.uninstallmodulewarning",this._data.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onDeleteOk]);
               break;
            case this.btn_update:
               this._uiClass.startInstall(this._data,true);
               break;
         }
      }
      
      private function onDeleteOk() : void {
         this._uiClass.startUninstall(this._data);
      }
      
      public function onRollOver(target:Object) : void {
         switch(target)
         {
            case this.mainCtr:
               break;
         }
      }
      
      public function onRollOut(target:Object) : void {
         switch(target)
         {
            case this.mainCtr:
               break;
         }
      }
      
      public function select(selected:Boolean) : void {
      }
   }
}
