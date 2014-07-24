package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2api.RoleplayApi;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2hooks.*;
   import d2actions.*;
   
   public class SpellForget extends Object
   {
      
      public function SpellForget() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var rpApi:RoleplayApi;
      
      public var modCommon:Object;
      
      public var gd_spellToForget:Grid;
      
      public var btn_close:ButtonContainer;
      
      public var btn_validate:ButtonContainer;
      
      public function main(param:Array) : void {
         this.sysApi.addHook(LeaveDialog,this.onLeaveDialog);
         this.refreshList();
      }
      
      public function unload() : void {
      }
      
      private function validateSpellChoice() : void {
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.spellForgetConfirm",this.dataApi.getSpell(this.gd_spellToForget.selectedItem.id).name),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onPopupValidateSpellForget,this.onPopupClose],this.onPopupValidateSpellForget,this.onPopupClose);
      }
      
      private function refreshList() : void {
         this.gd_spellToForget.dataProvider = this.rpApi.getSpellToForgetList();
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_validate:
               if(this.gd_spellToForget.dataProvider.length > 0)
               {
                  this.validateSpellChoice();
               }
               else
               {
                  this.sysApi.sendAction(new LeaveDialogRequest());
               }
               break;
            case this.btn_close:
               this.sysApi.sendAction(new LeaveDialogRequest());
               break;
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               if(this.gd_spellToForget.dataProvider.length > 0)
               {
                  this.validateSpellChoice();
               }
               else
               {
                  this.sysApi.sendAction(new LeaveDialogRequest());
               }
               break;
         }
         return false;
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(selectMethod == this.sysApi.getEnum("com.ankamagames.berilia.enums.SelectMethodEnum").DOUBLE_CLICK)
         {
            this.validateSpellChoice();
         }
      }
      
      public function onPopupClose() : void {
      }
      
      public function onPopupValidateSpellForget() : void {
         if(!this.gd_spellToForget.selectedItem)
         {
            return;
         }
         var selectedSpell:Object = this.gd_spellToForget.selectedItem;
         this.sysApi.sendAction(new ValidateSpellForget(selectedSpell.id));
      }
      
      public function onLeaveDialog() : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
