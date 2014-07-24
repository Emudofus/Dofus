package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2hooks.*;
   import d2actions.*;
   
   public class JobLevelUp extends Object
   {
      
      public function JobLevelUp() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var btn_close:ButtonContainer;
      
      public var btn_ok:ButtonContainer;
      
      public var lbl_description:Label;
      
      public function main(pParam:Object) : void {
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.lbl_description.text = this.uiApi.getText("ui.craft.newJobLevel",pParam.jobName,pParam.newLevel);
      }
      
      public function unload() : void {
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
            case this.btn_ok:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
         }
      }
      
      public function onJobLevelUp(jobName:String, newLevel:uint) : void {
         this.lbl_description.text = this.uiApi.getText("ui.craft.newJobLevel",jobName,newLevel);
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
   }
}
