package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.ConfigApi;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2hooks.*;
   import d2actions.*;
   
   public class QualitySelection extends Object
   {
      
      public function QualitySelection() {
         this._qualityTextures = new Array();
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var configApi:ConfigApi;
      
      public var modCommon:Object;
      
      private var _qualityTextures:Array;
      
      public var mainCtr:Object;
      
      public var grid_quality:Grid;
      
      public var btn_close:ButtonContainer;
      
      public function main(params:Object) : void {
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         var qualities:Array = [
            {
               "id":0,
               "title":"low",
               "x":130,
               "y":60
            },
            {
               "id":1,
               "title":"medium",
               "x":150,
               "y":45
            },
            {
               "id":2,
               "title":"high",
               "x":175,
               "y":80
            }];
         this.grid_quality.dataProvider = qualities;
      }
      
      public function unload() : void {
         this._qualityTextures = null;
      }
      
      public function updateQualitySlot(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.lbl_title.text = this.uiApi.getText("ui.option.quality." + data.title + "Quality");
            componentsRef.lbl_processor.text = this.uiApi.getText("ui.option.quality." + data.title + ".processor");
            componentsRef.lbl_ram.text = this.uiApi.getText("ui.option.quality." + data.title + ".ram");
            componentsRef.ed_decoQuality.x = data.x;
            componentsRef.ed_decoQuality.y = data.y;
            componentsRef.ed_decoQuality.look = this.sysApi.getEntityLookFromString("{1483}");
            componentsRef.ed_decoQuality.direction = 0;
            componentsRef.tx_decoQuality.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "tx_decoQuality" + data.id);
            this._qualityTextures[data.id] = componentsRef;
         }
      }
      
      private function popupQuit() : void {
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.option.quality.howcanifixit"),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onValidPopup,this.onClosePopup],this.onValidPopup,this.onClosePopup);
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
               this.popupQuit();
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(selectMethod != 7)
         {
            this.sysApi.dispatchHook(SetDofusQuality,this.grid_quality.selectedItem.id);
            this.popupQuit();
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         this._qualityTextures[item.data.id].tx_qualityShadow.visible = false;
         this._qualityTextures[item.data.id].ed_decoQuality.direction = 1;
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this._qualityTextures[item.data.id].tx_qualityShadow.visible = true;
         this._qualityTextures[item.data.id].ed_decoQuality.direction = 0;
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "closeUi":
               this.popupQuit();
               break;
         }
         return true;
      }
      
      public function onValidPopup() : void {
         this.configApi.setConfigProperty("dofus","askForQualitySelection",false);
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onClosePopup() : void {
         this.sysApi.log(2,"onClosePopup");
      }
   }
}
