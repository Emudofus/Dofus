package ui
{
   import d2components.ButtonContainer;
   import d2api.UiApi;
   import d2enums.ComponentHookList;
   import d2enums.StrataEnum;
   
   public class SecureModeIcon extends Object
   {
      
      public function SecureModeIcon() {
         super();
      }
      
      private var _secureModeNeedReboot:Object;
      
      public var btn_open:ButtonContainer;
      
      public var uiApi:UiApi;
      
      public function main(secureModeNeedReboot:Object) : void {
         this._secureModeNeedReboot = secureModeNeedReboot;
         this.uiApi.addComponentHook(this.btn_open,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_open,ComponentHookList.ON_ROLL_OUT);
      }
      
      public function onRelease(target:ButtonContainer) : void {
         if(!this.uiApi.getUi("secureMode"))
         {
            this.uiApi.loadUi("secureMode","secureMode",this._secureModeNeedReboot,StrataEnum.STRATA_HIGH);
         }
      }
      
      public function onRollOver(target:ButtonContainer) : void {
         this.uiApi.showTooltip(this.uiApi.getText("ui.modeSecure.tooltip.icon"),target);
      }
      
      public function onRollOut(target:ButtonContainer) : void {
         this.uiApi.hideTooltip();
      }
   }
}
